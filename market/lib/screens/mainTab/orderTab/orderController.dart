import 'dart:convert';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market/constant/color.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/modelClass/myTradeListModelClass.dart';
import 'package:market/modelClass/myUserListModelClass.dart';
import '../../../constant/const_string.dart';
import '../../../modelClass/constantModelClass.dart';
import '../../../constant/utilities.dart';
import '../../../modelClass/allSymbolListModelClass.dart';
import '../../../modelClass/getScriptFromSocket.dart';
import '../../../modelClass/ltpUpdateModelClass.dart';
import '../../BaseViewController/baseController.dart';

class orderControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => orderController());
  }
}

class orderController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  DateTime? fromDate;
  DateTime? toDate;
  TextEditingController textController = TextEditingController();
  FocusNode textFocus = FocusNode();
  List<TradeData> arrTrade = [];

  RxList<TradeData> arrPreTrade = RxList<TradeData>();

  TradeData? selectedTrade;
  int pageNumber = 1;
  int totalPage = 0;
  int totalSuccessRecord = 0;
  int totalPendingRecord = 0;
  bool isLocalDataLoading = true;
  bool isApicall = false;
  int selectedOrderIndex = -1;
  List<LtpUpdateModel> arrLtpUpdate = [];
  // List<UserData> arrUserList = [];
  List<ExchangeData> arrExchangeList = [];

  RxList<GlobalSymbolData> arrMainScript = RxList<GlobalSymbolData>();
  Rx<ExchangeData> selectExchangedropdownValue = ExchangeData().obs;
  Rx<GlobalSymbolData> selectedScriptDropDownValue = GlobalSymbolData().obs;
  Rx<Type> selectedOrderType = Type().obs;
  RxString fromDateStr = "Start Date".obs;
  RxString endDateStr = "End Date".obs;

  List<UserData> arrUserDataDropDown = [];
  final TextEditingController textEditingController = TextEditingController();
  FocusNode textEditingFocus = FocusNode();
  Rx<UserData> selectUserDropdownValue = UserData().obs;

  GlobalKey<ExpandableBottomSheetState>? buySellBottomSheetKey;
  RxBool isInfoClick = false.obs;
  ScrollController buySellBottomSheetScrollcontroller = ScrollController();
  ScrollController orderTypeListcontroller = ScrollController();
  TextEditingController qtyController = TextEditingController();
  FocusNode qtyFocus = FocusNode();
  TextEditingController priceController = TextEditingController();
  FocusNode priceFocus = FocusNode();
  RxBool isValidQty = true.obs;
  RxDouble lotSizeConverted = 1.0.obs;
  bool isForBuy = false;
  ScrollController sheetController = ScrollController();
  int quantity = 0;
  num totalQuantity = 0;
  RxInt selectedOptionBottomSheetTab = 0.obs;
  RxInt selectedIntraLongBottomSheetTab = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    isLocalDataLoading = false;
    getTradeList();
    getExchangeList();
    getUserList();

    // getScriptList();

    listcontroller.addListener(() async {
      if ((listcontroller.position.pixels > listcontroller.position.maxScrollExtent / 2.5 && totalPage > 1 && pageNumber < totalPage && !isLocalDataLoading)) {
        isLocalDataLoading = true;
        pageNumber++;
        update();
        var response = await service.getMyTradeListCall(
            status: "pending",
            page: pageNumber,
            text: textController.text.trim(),
            userId: selectUserDropdownValue.value.userId,
            symbolId: selectedScriptDropDownValue.value.symbolId,
            exchangeId: selectedScriptDropDownValue.value.exchangeId,
            startDate: fromDateStr.value != "Start Date" ? fromDateStr.value : "",
            endDate: endDateStr.value != "End Date" ? endDateStr.value : "",
            orderType: selectedOrderType.value.id ?? "");
        if (response != null) {
          if (response.statusCode == 200) {
            totalPage = response.meta?.totalPage ?? 0;
            totalPendingRecord = response.meta?.totalCount ?? 0;

            for (var v in response.data!) {
              arrTrade.add(v);
            }
            isLocalDataLoading = false;
            update();
            var arrTemp = [];
            for (var element in response.data!) {
              if (!arrSymbolNames.contains(element.symbolName)) {
                arrTemp.insert(0, element.symbolName);
                arrSymbolNames.insert(0, element.symbolName!);
              }
            }

            var txt = {"symbols": arrSymbolNames};

            if ((arrSymbolNames.isNotEmpty)) {
              socket.connectScript(jsonEncode(txt));
            }
          }
        }
      }
    });
  }

  String validateForm() {
    var msg = "";
    if (qtyController.text.isEmpty) {
      msg = AppString.emptyQty;
    } else if (num.parse(qtyController.text) == 0) {
      msg = AppString.emptyQty;
    } else if (isValidQty == false) {
      msg = AppString.inValidQty;
    } else if (priceController.text.isEmpty) {
      msg = AppString.emptyPrice;
    }
    return msg;
  }

  double getTotal(bool isBuy) {
    var total = 0.0;
    if (isBuy) {
      for (var element in arrTrade[selectedOrderIndex].scriptDataFromSocket.value.depth!.buy!) {
        total = total + element.price!;
      }
    } else {
      for (var element in arrTrade[selectedOrderIndex].scriptDataFromSocket.value.depth!.sell!) {
        total = total + element.price!;
      }
    }
    return total;
  }

  initiateTrade(bool isFromBuy) async {
    var msg = validateForm();

    if (msg.isEmpty) {
      update();
      var response = await service.modifyTradeCall(
        tradeId: arrTrade[selectedOrderIndex].tradeId!,
        symbolId: arrTrade[selectedOrderIndex].symbolId!,
        quantity: arrTrade[selectedOrderIndex].exchangeName!.toLowerCase() == "mcx" ? double.parse(qtyController.text) : lotSizeConverted.value,
        totalQuantity: arrTrade[selectedOrderIndex].exchangeName!.toLowerCase() == "mcx" ? lotSizeConverted.value : double.parse(qtyController.text),
        price: double.parse(priceController.text),
        marketPrice: double.parse(priceController.text),
        lotSize: arrTrade[selectedOrderIndex].lotSize!.toDouble(),
        orderType: arrTrade[selectedOrderIndex].orderType,
        tradeType: isFromBuy ? "buy" : "sell",
        exchangeId: arrTrade[selectedOrderIndex].exchangeId,
        productType: arrTrade[selectedOrderIndex].productTypeMain!,
        refPrice: isFromBuy ? arrTrade[selectedOrderIndex].scriptDataFromSocket.value.ask!.toDouble() : arrTrade[selectedOrderIndex].scriptDataFromSocket.value.bid!.toDouble(),
      );

      if (response != null) {
        // Get.back();
        if (response.statusCode == 200) {
          showSuccessToast(response.meta!.message!, globalContext!);
          // pageNumber = 1;
          // arrTrade.clear();
          // getTradeList();
          update();
        } else {
          showErrorToast(response.message!, globalContext!);
          update();
        }

        qtyController.text = "";
        priceController.text = "";
      }
    } else {
      // stateSetter(() {});
      showWarningToast(msg, globalContext!);
      Future.delayed(const Duration(milliseconds: 100), () {});
    }
  }

  pendingToSuccessTrade(bool isFromBuy) async {
    if (selectedTrade!.tradeSecond != 0) {
      var ltpObj = arrLtpUpdate.firstWhereOrNull((element) => element.symbolTitle == arrTrade[selectedOrderIndex].symbolName);
      if (ltpObj == null) {
        showWarningToast("INVALID SERVER TIME", globalContext!);
        return;
      } else {
        var difference = DateTime.now().difference(ltpObj.dateTime!);
        var differenceInSeconds = difference.inSeconds;
        if (differenceInSeconds >= selectedTrade!.tradeSecond!) {
          showWarningToast("INVALID SERVER TIME", globalContext!);
          return;
        }
      }
    }

    var response = await service.modifyTradeCall(
      tradeId: arrTrade[selectedOrderIndex].tradeId!,
      symbolId: arrTrade[selectedOrderIndex].symbolId!,
      quantity: arrTrade[selectedOrderIndex].quantity!.toDouble(),
      totalQuantity: arrTrade[selectedOrderIndex].totalQuantity!.toDouble(),
      price: arrTrade[selectedOrderIndex].currentPriceFromScoket!,
      marketPrice: arrTrade[selectedOrderIndex].currentPriceFromScoket!,
      lotSize: arrTrade[selectedOrderIndex].lotSize!.toDouble(),
      orderType: "market",
      tradeType: isFromBuy ? "buy" : "sell",
      exchangeId: arrTrade[selectedOrderIndex].exchangeId,
      productType: arrTrade[selectedOrderIndex].productTypeMain!,
      refPrice: isFromBuy ? arrTrade[selectedOrderIndex].scriptDataFromSocket.value.ask!.toDouble() : arrTrade[selectedOrderIndex].scriptDataFromSocket.value.bid!.toDouble(),
    );

    if (response != null) {
      // Get.back();
      if (response.statusCode == 200) {
        showSuccessToast(response.meta!.message!, globalContext!);
        pageNumber = 1;
        arrTrade.clear();
        getTradeList();
        update();
      } else {
        showErrorToast(response.message!, globalContext!);
        update();
      }

      qtyController.text = "";
      priceController.text = "";
    }
  }

  getUserList() async {
    // arrUserDataDropDown = constantValues!.userFilterType!;
    var response = await service.getMyUserListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserDataDropDown = response.data ?? [];
      }
    }
  }

  getExchangeList() async {
    var response = await service.getExchangeListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrExchangeList = response.exchangeData ?? [];
      }
    }
  }

  getScriptList() async {
    var response = await service.allSymbolListCall(1, "", selectExchangedropdownValue.value.exchangeId ?? "");
    arrMainScript.value = response!.data ?? [];

    update();
  }

  getTradeList() async {
    arrTrade.clear();
    arrPreTrade.clear();
    pageNumber = 1;

    isLocalDataLoading = true;
    isApicall = true;
    String strFromDate = "";
    String strToDate = "";
    update();
    if (fromDateStr.value != "Start Date") {
      strFromDate = DateFormat('yyyy-MM-dd').format(fromDate!);
    }
    if (endDateStr.value != "End Date") {
      strToDate = DateFormat('yyyy-MM-dd').format(toDate!);
    }

    var response = await service.getMyTradeListCall(
        status: "pending",
        page: pageNumber,
        text: textController.text.trim(),
        userId: selectUserDropdownValue.value.userId,
        symbolId: selectedScriptDropDownValue.value.symbolId,
        exchangeId: selectedScriptDropDownValue.value.exchangeId,
        startDate: strFromDate,
        endDate: strToDate,
        orderType: selectedOrderType.value.id ?? "");
    isLocalDataLoading = false;
    isApicall = false;
    update();
    if (response != null) {
      if (response.statusCode == 200) {
        var arrTemp = [];
        response.data?.forEach((v) {
          var index = arrTrade.indexWhere((element) => element.tradeId == v.tradeId);
          if (index == -1) {
            arrTrade.add(TradeData.fromJson(v.toJson()));
            arrPreTrade.add(TradeData.fromJson(v.toJson()));
          } else {
            arrTrade[index] = TradeData.fromJson(v.toJson());
            arrPreTrade[index] = TradeData.fromJson(v.toJson());
          }
        });
        update();
        totalPage = response.meta?.totalPage ?? 0;
        totalPendingRecord = response.meta?.totalCount ?? 0;
        for (var element in response.data!) {
          if (!arrSymbolNames.contains(element.symbolName)) {
            arrTemp.insert(0, element.symbolName);
            arrSymbolNames.insert(0, element.symbolName!);
          }
        }

        var txt = {"symbols": arrSymbolNames};

        if ((arrSymbolNames.isNotEmpty)) {
          socket.connectScript(jsonEncode(txt));
        }
      }
    }
  }

  cancelTrade() async {
    var response = await service.cancelTradeCall(arrTrade[selectedOrderIndex].tradeId!);
    if (response?.statusCode == 200) {
      arrTrade.removeAt(selectedOrderIndex);
      showSuccessToast(response!.meta!.message ?? "", globalContext!);
      selectedOrderIndex = -1;
      update();
    }
  }

  cancelAllTrade() async {
    var response = await service.cancelAllTradeCall();
    if (response?.statusCode == 200) {
      arrTrade.clear();
      showSuccessToast(response!.meta!.message ?? "", globalContext!);
      selectedOrderIndex = -1;
      update();
    }
  }

  addSymbolInSocket(String symbolName) {
    if (!arrSymbolNames.contains(symbolName)) {
      arrSymbolNames.insert(0, symbolName);
      var txt = {
        "symbols": [symbolName]
      };
      socket.connectScript(jsonEncode(txt));
    }
  }

  listenTradeScriptFromScoket(GetScriptFromSocket socketData) {
    if (socketData.status == true) {
      var ltpObj = LtpUpdateModel(symbolId: "", ltp: socketData.data!.ltp!, symbolTitle: socketData.data!.symbol, dateTime: DateTime.now());
      var isAvailableObj = arrLtpUpdate.firstWhereOrNull((element) => socketData.data!.symbol == element.symbolTitle);
      if (isAvailableObj == null) {
        arrLtpUpdate.add(ltpObj);
      } else {
        if (isAvailableObj.ltp != ltpObj.ltp) {
          var index = arrLtpUpdate.indexWhere((element) => element.symbolTitle == ltpObj.symbolTitle);
          arrLtpUpdate[index] = ltpObj;
          // print(ltpObj.symbolTitle);
          // print(ltpObj.ltp);
        }
      }

      var obj = arrTrade.firstWhereOrNull((element) => socketData.data!.symbol == element.symbolName);
      if (obj != null) {
        for (var i = 0; i < arrTrade.length; i++) {
          if (arrTrade[i].symbolName == obj.symbolName) {
            if (arrPreTrade.length > i) {
              arrPreTrade.removeAt(i);
            }

            arrPreTrade.insert(i, arrTrade[i]);
            arrTrade[i].scriptDataFromSocket.value = socketData.data!;
            arrTrade[i].currentPriceFromScoket = double.parse(socketData.data!.ltp.toString());
          }
        }
      }

      update();
    }
  }

  Color getPriceColor(String type, double currentPrice, double tradePrice) {
    switch (type) {
      case "buy":
        {
          if (currentPrice > tradePrice) {
            return AppColors().blueColor;
          } else if (currentPrice < tradePrice) {
            return AppColors().redColor;
          } else {
            return AppColors().fontColor;
          }
        }
      case "sell":
        {
          if (currentPrice < tradePrice) {
            return AppColors().blueColor;
          } else if (currentPrice > tradePrice) {
            return AppColors().redColor;
          } else {
            return AppColors().fontColor;
          }
        }

      default:
        {
          return AppColors().fontColor;
        }
    }
  }
}
