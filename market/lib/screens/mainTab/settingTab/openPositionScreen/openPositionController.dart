import 'dart:convert';
import 'dart:ui';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/modelClass/getScriptFromSocket.dart';
import 'package:market/modelClass/positionModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/positionTab/positionController.dart';
import 'package:market/screens/mainTab/tradeTab/tradeController.dart';
import '../../../../modelClass/constantModelClass.dart';
import '../../../../main.dart';

class OpenPositionControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OpenPositionController());
  }
}

class OpenPositionController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  bool isTotalViewExpanded = false;
  TextEditingController textController = TextEditingController();
  FocusNode textFocus = FocusNode();
  List<positionListData> arrPositionScriptList = [];
  Rx<positionListData?>? selectedScript;
  // Rx<ScriptData> selectedScriptFromSocket = ScriptData().obs;
  RxDouble totalPosition = 0.0.obs;
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
  bool isApiCall = false;
  ScrollController sheetController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    selectedOrderType = constantValues!.orderType![0];
    // selectedProductType = constantValues!.productType![0];
    Future.delayed(const Duration(milliseconds: 100), () {
      getPositionList("");
      update();
    });
  }

  String validateForm() {
    var msg = "";
    if (selectedOrderType!.id == "market") {
      if (qtyController.text.isEmpty) {
        msg = AppString.emptyQty;
      }
    } else {
      if (qtyController.text.isEmpty) {
        msg = AppString.emptyQty;
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
        quantity: double.parse(qtyController.text),
        price: double.parse(priceController.text.isEmpty ? "0" : priceController.text),
        isFromStopLoss: selectedOrderType!.name == "StopLoss",
        marketPrice: selectedOrderType!.name == "StopLoss"
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
          var positionVC = Get.find<positionController>();
          positionVC.getPositionList("");
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

  getPositionList(String text) async {
    isApiCall = true;
    update();
    var response = await service.positionListCall(1, text);
    arrPositionScriptList = response!.data ?? [];
    isApiCall = false;
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

  listenPositionScriptFromScoket(GetScriptFromSocket socketData) {
    if (socketData.status == true) {
      var obj = arrPositionScriptList.firstWhereOrNull((element) => socketData.data!.symbol == element.symbolName);

      if (obj != null) {
        var indexOfScript = arrPositionScriptList.indexWhere((element) => element.symbolName == socketData.data?.symbol);
        if (indexOfScript != -1) {
          arrPositionScriptList[indexOfScript].scriptDataFromSocket.value = socketData.data!;

          if (arrPositionScriptList[indexOfScript].currentPriceFromSocket != 0.0) {
            arrPositionScriptList[indexOfScript].profitLossValue = arrPositionScriptList[indexOfScript].tradeTypeValue!.toUpperCase() == "BUY"
                ? (double.parse(socketData.data!.bid.toString()) - arrPositionScriptList[indexOfScript].price!) * arrPositionScriptList[indexOfScript].quantity!
                : (arrPositionScriptList[indexOfScript].price! - double.parse(socketData.data!.ask.toString())) * arrPositionScriptList[indexOfScript].quantity!;
          }
        }
        totalPosition.value = 0.0;
        for (var element in arrPositionScriptList) {
          totalPosition.value += element.profitLossValue ?? 0.0;
        }
      }
      if (selectedScript?.value?.symbolName == socketData.data?.symbol) {
        selectedScript!.value!.scriptDataFromSocket.value = socketData.data!;
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
