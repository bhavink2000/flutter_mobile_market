import 'dart:convert';
import 'dart:developer';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/getScriptFromSocket.dart';
import 'package:market/modelClass/positionModelClass.dart';
import 'package:market/screens/mainTab/tradeTab/tradeController.dart';
import '../../../modelClass/constantModelClass.dart';
import '../../../constant/color.dart';
import '../../../modelClass/ltpUpdateModelClass.dart';
import '../../../modelClass/squareOffPositionRequestModelClass.dart';
import '../../BaseViewController/baseController.dart';

class positionControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => positionController());
  }
}

class positionController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  bool isTotalViewExpanded = false;
  ScrollController buySellBottomSheetScrollcontroller = ScrollController();
  TextEditingController textController = TextEditingController();
  FocusNode textFocus = FocusNode();
  List<positionListData> arrPositionScriptList = [];
  List<positionListData> arrSelectedPositionScriptList = [];
  List<positionListData> arrPrePositionScriptList = [];
  Rx<positionListData?>? selectedScript;
  List<LtpUpdateModel> arrLtpUpdate = [];
  // Rx<ScriptData> selectedScriptFromSocket = ScriptData().obs;
  RxDouble totalPosition = 0.0.obs;
  RxDouble totalPositionPercentWise = 0.0.obs;
  GlobalKey<ExpandableBottomSheetState>? buySellBottomSheetKey;
  ScrollController orderTypeListcontroller = ScrollController();
  RxInt selectedOptionBottomSheetTab = 0.obs;
  RxInt selectedIntraLongBottomSheetTab = 0.obs;
  Type? selectedOrderType;
  TextEditingController qtyController = TextEditingController();
  FocusNode qtyFocus = FocusNode();
  TextEditingController priceController = TextEditingController();
  FocusNode priceFocus = FocusNode();
  bool isForBuy = false;
  RxBool isTradeCallFinished = true.obs;
  bool isApicall = false;
  ScrollController sheetController = ScrollController();
  int totalPage = 0;
  int currentPage = 1;
  bool isPagingApiCall = false;
  bool isRefreshCall = false;
  RxBool isInfoClick = false.obs;
  int selectedIndex = -1;
  RxBool isValidQty = true.obs;
  RxDouble lotSizeConverted = 1.0.obs;
  RxBool isSelectedForSquareOff = false.obs;
  RxBool isSelectedForRollOver = false.obs;
  num totalQuantity = 0;

  @override
  void onInit() async {
    super.onInit();
    selectedOrderType = constantValues!.orderType![0];
    // selectedProductType = constantValues!.productType![0];
    isApicall = true;
  }

  String validateForm() {
    var msg = "";
    if (selectedOrderType!.id != "limit") {
      if (selectedScript!.value!.tradeSecond! != 0) {
        var ltpObj = arrLtpUpdate.firstWhereOrNull((element) => element.symbolTitle == arrPositionScriptList[selectedIndex].symbolName);
        if (ltpObj == null) {
          return "INVALID SERVER TIME";
        } else {
          var difference = DateTime.now().difference(ltpObj.dateTime!);
          var differenceInSeconds = difference.inSeconds;
          if (differenceInSeconds >= selectedScript!.value!.tradeSecond!) {
            return "INVALID SERVER TIME";
          }
        }
      }
    }
    if (selectedOrderType!.id == "market") {
      if (qtyController.text.isEmpty) {
        msg = AppString.emptyQty;
      } else if (num.parse(qtyController.text) == 0) {
        msg = AppString.emptyQty;
      } else if (isValidQty == false) {
        msg = AppString.inValidQty;
      }
    } else {
      if (qtyController.text.isEmpty) {
        msg = AppString.emptyQty;
      } else if (num.parse(qtyController.text) == 0) {
        msg = AppString.emptyQty;
      } else if (isValidQty == false) {
        msg = AppString.inValidQty;
      } else if (priceController.text.isEmpty) {
        msg = AppString.emptyPrice;
      }
    }
    return msg;
  }

  initiateTrade(StateSetter stateSetter) async {
    var msg = validateForm();
    isTradeCallFinished.value = true;
    if (msg.isEmpty) {
      isTradeCallFinished.value = false;

      var response = await service.tradeCall(
        symbolId: selectedScript!.value!.symbolId,
        quantity: arrPositionScriptList[selectedIndex].exchangeName!.toLowerCase() == "mcx" ? double.parse(qtyController.text) : lotSizeConverted.value,
        totalQuantity: arrPositionScriptList[selectedIndex].exchangeName!.toLowerCase() == "mcx" ? lotSizeConverted.value : double.parse(qtyController.text),
        price: double.parse(priceController.text.isEmpty ? "0" : priceController.text),
        isFromStopLoss: selectedOrderType!.id == "stopLoss",
        marketPrice: selectedOrderType!.id == "stopLoss"
            ? selectedScript!.value!.scriptDataFromSocket.value.ltp!.toDouble()
            : isForBuy
                ? selectedScript!.value!.scriptDataFromSocket.value.ask!.toDouble()
                : selectedScript!.value!.scriptDataFromSocket.value.bid!.toDouble(),
        lotSize: selectedScript!.value!.lotSize!.toInt(),
        orderType: selectedOrderType!.id,
        tradeType: isForBuy ? "buy" : "sell",
        exchangeId: selectedScript!.value!.exchangeId,
        productType: "longTerm",
        refPrice: isForBuy ? selectedScript!.value!.scriptDataFromSocket.value.ask!.toDouble() : selectedScript!.value!.scriptDataFromSocket.value.bid!.toDouble(),
      );

      //longterm
      isTradeCallFinished.value = false;
      update();
      if (response != null) {
        // Get.back();
        if (response.statusCode == 200) {
          var tradeVC = Get.find<tradeController>();
          tradeVC.getTradeList();
          currentPage = 1;
          arrLtpUpdate.clear();
          getPositionList("", isFromRefresh: true);
          showSuccessToast(response.meta!.message!, globalContext!);
          isTradeCallFinished.value = true;
          update();
        } else {
          isTradeCallFinished.value = true;
          showErrorToast(response.message!, globalContext!);
          update();
        }

        qtyController.text = "";
        priceController.text = "";
      }
    } else {
      // stateSetter(() {});
      showWarningToast(msg, globalContext!);
      Future.delayed(const Duration(milliseconds: 100), () {
        isTradeCallFinished.value = true;
      });
    }
  }

  squareOffPosition(List<SymbolRequestData>? arrSymbol) async {
    var response = await service.squareOffPositionCall(arrSymbol: arrSymbol);
    if (response?.statusCode == 200) {
      showSuccessToast(response!.meta!.message ?? "", globalContext!);
      arrPositionScriptList.clear();
      arrSelectedPositionScriptList.clear();
      currentPage = 1;
      isSelectedForSquareOff.value = false;
      getPositionList("", isFromRefresh: true);
      update();
    } else {
      showErrorToast(response!.message ?? "", globalContext!);
    }
  }

  rollOverPosition(List<SymbolRequestData>? arrSymbol) async {
    List<String> arr = [];
    for (var element in arrSymbol!) {
      arr.add(element.symbolId!);
    }
    var response = await service.rollOverTradeCall(symbolId: arr, userId: userData!.userId!);
    if (response?.statusCode == 200) {
      showSuccessToast(response!.meta!.message ?? "", globalContext!);
      arrPositionScriptList.clear();
      currentPage = 1;
      getPositionList("", isFromRefresh: true);
      update();
    } else {
      showErrorToast(response!.message ?? "", globalContext!);
    }
  }

  getPositionList(String text, {bool isFromRefresh = false}) async {
    // if (isApicall) {
    //   CancelToken().cancel();
    // }
    isSelectedForSquareOff = false.obs;
    isSelectedForRollOver = false.obs;
    if (isFromRefresh) {
      isRefreshCall = true;
      arrPositionScriptList.clear();
      arrPrePositionScriptList.clear();
    } else {
      if (isPagingApiCall) {
        return;
      }
      isPagingApiCall = true;
    }

    update();
    var response = await service.positionListCall(currentPage, text);
    // arrPositionScriptList.addAll(response!.data ?? []);
    // arrPrePositionScriptList.addAll(response.data ?? []);
    totalPosition.value = 0.0;
    totalPositionPercentWise.value = 0.0;
    response!.data!.forEach((element) {
      var index = arrPositionScriptList.indexWhere((internalObj) => element.symbolId == internalObj.symbolId);
      if (index != -1) {
        arrPositionScriptList[index] = positionListData.fromJson(element.toJson());
        arrPrePositionScriptList[index] = positionListData.fromJson(element.toJson());
      } else {
        arrPositionScriptList.add(positionListData.fromJson(element.toJson()));
        arrPrePositionScriptList.add(positionListData.fromJson(element.toJson()));
      }
    });
    isPagingApiCall = false;
    isRefreshCall = false;
    totalPage = response.meta!.totalPage!;
    if (totalPage >= currentPage) {
      currentPage = currentPage + 1;
    }
    isApicall = false;
    update();
    var arrTemp = [];
    for (var indexOfScript = 0; indexOfScript < arrPositionScriptList.length; indexOfScript++) {
      arrPositionScriptList[indexOfScript].profitLossValue = arrPositionScriptList[indexOfScript].totalQuantity! < 0
          ? (double.parse(arrPositionScriptList[indexOfScript].ask!.toStringAsFixed(2)) - arrPositionScriptList[indexOfScript].price!) * arrPositionScriptList[indexOfScript].totalQuantity!
          : (double.parse(arrPositionScriptList[indexOfScript].bid!.toStringAsFixed(2)) - double.parse(arrPositionScriptList[indexOfScript].price!.toStringAsFixed(2))) * arrPositionScriptList[indexOfScript].totalQuantity!;
    }
    for (var element in arrPositionScriptList) {
      totalPosition.value += element.profitLossValue ?? 0.0;
      totalPositionPercentWise.value = totalPositionPercentWise.value + getPlPer(percentage: element.profitAndLossSharing!, pl: element.profitLossValue!);
    }
    for (var element in response.data!) {
      if (!arrSymbolNames.contains(element.symbolName)) {
        arrTemp.insert(0, element.symbolName);
        arrSymbolNames.insert(0, element.symbolName!);
      }
    }

    var txt = {"symbols": arrSymbolNames};
    log("**************position******************");
    log(txt.toString());
    log("**************position******************");
    if (arrSymbolNames.isNotEmpty) {
      socket.connectScript(jsonEncode(txt));
    }
  }

  bool hasNonZeroDecimalPart(num number) {
    String numberString = number.toString();

    // Check if the number contains a decimal point
    if (numberString.contains('.')) {
      // Extract the decimal part and convert it to double
      double decimalPart = double.parse('0.${numberString.split('.')[1]}');

      // Check if the decimal part is greater than 0
      return decimalPart > 0;
    } else {
      // If there is no decimal point, there is no decimal part
      return false;
    }
  }

  num getPlPer({num? percentage, num? pl}) {
    var temp1 = pl! * percentage!;
    var temp2 = temp1 / 100;

    return userData!.role == UserRollList.user ? temp2 : temp2 * -1;
  }

  double getTotal(bool isBuy) {
    var total = 0.0;
    if (isBuy) {
      for (var element in selectedScript!.value!.scriptDataFromSocket.value.depth!.buy!) {
        total = total + element.price!;
      }
    } else {
      for (var element in selectedScript!.value!.scriptDataFromSocket.value.depth!.sell!) {
        total = total + element.price!;
      }
    }
    return total;
  }

  Function? updateBottomSheet;
  listenPositionScriptFromScoket(GetScriptFromSocket socketData) {
    if (socketData.status == true) {
      var indexOfScript = arrPositionScriptList.indexWhere((element) => socketData.data!.symbol == element.symbolName);

      if (indexOfScript != -1) {
        // print(socketData.data!.symbol);
        var ltpObj = LtpUpdateModel(symbolId: "", ltp: socketData.data!.ltp!, bid: socketData.data!.bid, ask: socketData.data!.ask!, symbolTitle: socketData.data!.symbol, dateTime: DateTime.now());
        var isAvailableObj = arrLtpUpdate.firstWhereOrNull((element) => socketData.data!.symbol == element.symbolTitle);
        if (isAvailableObj == null) {
          arrLtpUpdate.add(ltpObj);
        } else {
          var index = arrLtpUpdate.indexWhere((element) => element.symbolTitle == ltpObj.symbolTitle);
          arrLtpUpdate[index] = ltpObj;
          // print(ltpObj.symbolTitle);
          // print(ltpObj.ltp);
        }

        arrPrePositionScriptList[indexOfScript].ask = num.parse(arrPositionScriptList[indexOfScript].ask.toString());
        arrPrePositionScriptList[indexOfScript].bid = num.parse(arrPositionScriptList[indexOfScript].bid.toString());
        arrPrePositionScriptList[indexOfScript].ltp = num.parse(arrPositionScriptList[indexOfScript].ltp.toString());

        arrPositionScriptList[indexOfScript].scriptDataFromSocket.value = socketData.data!;
        arrPositionScriptList[indexOfScript].bid = socketData.data!.bid;
        arrPositionScriptList[indexOfScript].ask = socketData.data!.ask;
        arrPositionScriptList[indexOfScript].ltp = socketData.data!.ltp;

        if (arrPositionScriptList[indexOfScript].currentPriceFromSocket != 0.0) {
          arrPositionScriptList[indexOfScript].profitLossValue = arrPositionScriptList[indexOfScript].totalQuantity! < 0
              ? (double.parse(arrPositionScriptList[indexOfScript].ask!.toStringAsFixed(2)) - arrPositionScriptList[indexOfScript].price!) * arrPositionScriptList[indexOfScript].totalQuantity!
              : (double.parse(arrPositionScriptList[indexOfScript].bid!.toStringAsFixed(2)) - double.parse(arrPositionScriptList[indexOfScript].price!.toStringAsFixed(2))) * arrPositionScriptList[indexOfScript].totalQuantity!;
        }

        totalPosition.value = 0.0;
        totalPositionPercentWise.value = 0.0;
        for (var element in arrPositionScriptList) {
          totalPosition.value += element.profitLossValue ?? 0.0;
          totalPositionPercentWise.value = totalPositionPercentWise.value + getPlPer(percentage: element.profitAndLossSharing!, pl: element.profitLossValue!);
        }
      }
      if (selectedScript?.value?.symbolName == socketData.data?.symbol) {
        selectedScript!.value!.scriptDataFromSocket.value = socketData.data!;
        selectedScript!.value!.scriptDataFromSocket.value.copyObject(socketData.data!);
        // selectedScript.value!.ask = 1 + selectedScript.value!.ask!;
        if (updateBottomSheet != null) {
          updateBottomSheet!(() {});
        }
      }
      update();
    }
  }

  Color getPriceColor(double value) {
    if (value == 0.0) {
      return AppColors().fontColor;
    }
    if (value > 0.0) {
      return AppColors().blueColor;
    } else if (value < 0.0) {
      return AppColors().redColor;
    } else {
      return AppColors().fontColor;
    }
  }
}
