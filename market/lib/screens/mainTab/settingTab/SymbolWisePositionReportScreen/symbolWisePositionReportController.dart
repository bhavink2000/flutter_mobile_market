import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/color.dart';
import '../../../../constant/const_string.dart';
import '../../../../main.dart';
import '../../../../modelClass/accountSummaryNewListModelClass.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/constantModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/getScriptFromSocket.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../BaseViewController/baseController.dart';

class SymbolWisePositionReportControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SymbolWisePositionReportController());
  }
}

class SymbolWisePositionReportController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  RxString selectStatusdropdownValue = "".obs;
  List<String> arrCustomDateSelection = [];
  String fromDate = "";
  String toDate = "";
  Rx<UserData> selectedUser = UserData().obs;
  Rx<String> selectedplType = "All".obs;

  List<AccountSummaryNewListData> arrSummaryList = [];
  // Rx<positionListData>? selectedScript;
  List<UserData> arrUserListOnlyClient = [];

  RxBool isTradeCallFinished = true.obs;
  double visibleWidth = 0.0;
  Rx<Type> selectedValidity = Type().obs;
  final FocusNode focusNode = FocusNode();
  final FocusNode popUpfocusNode = FocusNode();
  List<Type> arrOrderType = [];

  bool isKeyPressActive = false;

  List<ExchangeData> arrExchangeList = [];
  int selectedScriptIndex = -1;
  Rx<Type> selectedProductType = Type().obs;

  RxList<GlobalSymbolData> arrMainScript = RxList<GlobalSymbolData>();
  bool isApiCallRunning = false;
  bool isResetCall = false;
  int totalPage = 0;
  int currentPage = 1;

  bool isPagingApiCall = false;
  RxDouble plTotal = 0.0.obs;
  RxDouble plPerTotal = 0.0.obs;
  RxDouble brkPerTotal = 0.0.obs;
  RxDouble brkTotal = 0.0.obs;
  RxDouble netQtyPerTotal = 0.0.obs;

  Rx<ExchangeData> selectExchangedropdownValue = ExchangeData().obs;
  Rx<GlobalSymbolData> selectedScriptDropDownValue = GlobalSymbolData().obs;
  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();
    arrCustomDateSelection.addAll(CommonCustomDateSelection().arrCustomDate);
    // isApiCallRunning = true;

    // getAccountSummaryNewList("");

    getExchangeList();
    update();
  }

  getExchangeList() async {
    var response = await service.getExchangeListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrExchangeList = response.exchangeData ?? [];
        update();
      }
    }
  }

  getScriptList() async {
    var response = await service.allSymbolListCall(1, "", selectExchangedropdownValue.value.exchangeId ?? "");
    arrMainScript.value = response!.data ?? [];

    update();
  }

  getAccountSummaryNewList(String text, {bool isFromfilter = false, bool isFromClear = false}) async {
    if (isFromfilter) {
      currentPage = 1;
      arrSummaryList.clear();
      if (isFromClear) {
        isResetCall = true;
      } else {
        isApiCallRunning = true;
      }
    }
    if (isPagingApiCall) {
      return;
    }
    if (selectStatusdropdownValue.toString().isNotEmpty) {
      if (selectStatusdropdownValue.toString() != 'Custom Period') {
        String thisWeekDateRange = "$selectStatusdropdownValue";
        List<String> dateParts = thisWeekDateRange.split(" to ");
        fromDate = dateParts[0].trim().split('Week').last;
        toDate = dateParts[1];
      } else {
        fromDate = '';
        toDate = '';
      }
    }
    isPagingApiCall = true;
    update();
    var response = await service.symbolWisePositionListCall(currentPage, text,
        userId: selectedUser.value.userId ?? "", startDate: fromDate, endDate: toDate, symbolId: selectedScriptDropDownValue.value.symbolId ?? "", exchangeId: selectExchangedropdownValue.value.exchangeId ?? "", productType: selectedProductType.value.id ?? "");
    arrSummaryList.addAll(response!.data!);
    isPagingApiCall = false;
    isResetCall = false;

    totalPage = response.meta!.totalPage!.toInt();
    if (totalPage >= currentPage) {
      currentPage = currentPage + 1;
    }
    for (var indexOfScript = 0; indexOfScript < arrSummaryList.length; indexOfScript++) {
      arrSummaryList[indexOfScript].currentPriceFromSocket = arrSummaryList[indexOfScript].totalQuantity! < 0 ? arrSummaryList[indexOfScript].ask!.toDouble() : arrSummaryList[indexOfScript].bid!.toDouble();
      arrSummaryList[indexOfScript].profitLossValue = arrSummaryList[indexOfScript].totalQuantity! < 0
          ? (double.parse(arrSummaryList[indexOfScript].ask!.toStringAsFixed(2)) - arrSummaryList[indexOfScript].avgPrice!) * arrSummaryList[indexOfScript].totalQuantity!
          : (double.parse(arrSummaryList[indexOfScript].bid!.toStringAsFixed(2)) - double.parse(arrSummaryList[indexOfScript].avgPrice!.toStringAsFixed(2))) * arrSummaryList[indexOfScript].totalQuantity!;
    }
    plTotal = 0.0.obs;
    plPerTotal = 0.0.obs;
    brkPerTotal = 0.0.obs;
    brkTotal = 0.0.obs;
    netQtyPerTotal = 0.0.obs;
    arrSummaryList.forEach((element) {
      plTotal.value = plTotal.value + element.profitLossValue!;

      var temp = ((element.profitLossValue! * element.profitAndLossSharing!) / 100);
      plPerTotal.value = (plPerTotal.value + temp) * -1;
      brkPerTotal.value = brkPerTotal.value + element.adminBrokerageTotal!;
      netQtyPerTotal.value = netQtyPerTotal.value + element.totalShareQuantity!;
      brkTotal.value = brkTotal.value + element.brokerageTotal!;
    });
    isApiCallRunning = false;
    update();
    var arrTemp = [];
    for (var element in response.data!) {
      if (!arrSymbolNames.contains(element.symbolName)) {
        arrTemp.insert(0, element.symbolName);
        arrSymbolNames.insert(0, element.symbolName!);
      }
    }

    if ((arrSymbolNames.isNotEmpty)) {
      var txt = {"symbols": arrSymbolNames};
      socket.connectScript(jsonEncode(txt));
    }
  }

  double getTotal(bool isBuy) {
    var total = 0.0;
    if (isBuy) {
      for (var element in arrSummaryList[selectedScriptIndex].scriptDataFromSocket.value.depth!.buy!) {
        total = total + element.price!;
      }
    } else {
      for (var element in arrSummaryList[selectedScriptIndex].scriptDataFromSocket.value.depth!.sell!) {
        total = total + element.price!;
      }
    }
    return total;
  }

  Color getPriceColor(double value) {
    if (value == 0.0) {
      return AppColors().fontColor;
    }
    if (value > 0.0) {
      return AppColors().greenColor;
    } else if (value < 0.0) {
      return AppColors().redColor;
    } else {
      return AppColors().fontColor;
    }
  }

  num getPlPer({num? cmp, num? netAPrice}) {
    var temp1 = cmp! - netAPrice!;
    var temp2 = temp1 / netAPrice;
    var temp3 = temp2 * 100;
    return temp3;
  }

  listenSymbolWisePositionScriptFromSocket(GetScriptFromSocket socketData) {
    if (socketData.status == true) {
      var obj = arrSummaryList.firstWhereOrNull((element) => socketData.data!.symbol == element.symbolName);

      if (obj != null) {
        var indexOfScript = arrSummaryList.indexWhere((element) => element.symbolName == socketData.data?.symbol);
        if (indexOfScript != -1) {
          arrSummaryList[indexOfScript].scriptDataFromSocket = socketData.data!.obs;
          arrSummaryList[indexOfScript].bid = socketData.data!.bid!.toDouble();
          arrSummaryList[indexOfScript].ask = socketData.data!.ask!.toDouble();
          arrSummaryList[indexOfScript].ltp = socketData.data!.ltp!.toDouble();
          arrSummaryList[indexOfScript].currentPriceFromSocket = socketData.data!.ltp!.toDouble();
          if (indexOfScript == 0) {}

          if (arrSummaryList[indexOfScript].currentPriceFromSocket != 0.0) {
            arrSummaryList[indexOfScript].profitLossValue = arrSummaryList[indexOfScript].totalQuantity! < 0
                ? (double.parse(arrSummaryList[indexOfScript].ask!.toStringAsFixed(2)) - arrSummaryList[indexOfScript].avgPrice!) * arrSummaryList[indexOfScript].totalQuantity!
                : (double.parse(arrSummaryList[indexOfScript].bid!.toStringAsFixed(2)) - double.parse(arrSummaryList[indexOfScript].avgPrice!.toStringAsFixed(2))) * arrSummaryList[indexOfScript].totalQuantity!;
          }
          plTotal = 0.0.obs;
          plPerTotal = 0.0.obs;
          brkPerTotal = 0.0.obs;
          brkTotal = 0.0.obs;
          netQtyPerTotal = 0.0.obs;
          arrSummaryList.forEach((element) {
            plTotal.value = plTotal.value + element.profitLossValue!;

            var temp = ((element.profitLossValue! * element.profitAndLossSharing!) / 100);
            plPerTotal.value = (plPerTotal.value + temp) * -1;
            brkPerTotal.value = brkPerTotal.value + element.adminBrokerageTotal!;
            netQtyPerTotal.value = netQtyPerTotal.value + element.totalShareQuantity!;
            brkTotal.value = brkTotal.value + element.brokerageTotal!;
          });
        }
      }

      update();
    }
  }
}
