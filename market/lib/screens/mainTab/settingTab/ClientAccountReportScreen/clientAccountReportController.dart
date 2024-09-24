import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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

class ClientAccountReportControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientAccountReportController());
  }
}

class ClientAccountReportController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */

  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  Rx<UserData> selectUserDropdownValue = UserData().obs;
  Rx<String> selectedplType = "All".obs;

  Rx<GlobalSymbolData> selectedScriptFromFilter = GlobalSymbolData().obs;
  List<AccountSummaryNewListData> arrSummaryList = [];
  // Rx<positionListData>? selectedScript;
  List<UserData> arrUserListOnlyClient = [];
  final TextEditingController textEditingController = TextEditingController();
  FocusNode textEditingFocus = FocusNode();
  RxBool isTradeCallFinished = true.obs;
  double visibleWidth = 0.0;
  Rx<Type> selectedValidity = Type().obs;
  final FocusNode focusNode = FocusNode();
  final FocusNode popUpfocusNode = FocusNode();
  List<Type> arrOrderType = [];
  RxString selectStatusdropdownValue = "".obs;
  bool isKeyPressActive = false;
  List<String> arrCustomDateSelection = [];
  FocusNode viewFocus = FocusNode();
  FocusNode clearFocus = FocusNode();
  List<String> arrPLTypeforAccount = ["All", "Only M2M", "Only Release"];
  int selectedScriptIndex = -1;
  Rx<Type> selectedProductType = Type().obs;

  bool isApiCallRunning = false;
  bool isResetCall = false;
  int totalPage = 0;
  int currentPage = 1;

  bool isPagingApiCall = false;
  RxDouble grandTotal = 0.0.obs;
  RxDouble outPerGrandTotal = 0.0.obs;
  List<ExchangeData> arrExchangeList = [];
  Rx<ExchangeData> selectExchangeDropdownValue = ExchangeData().obs;
  FocusNode SubmitFocus = FocusNode();
  FocusNode CancelFocus = FocusNode();
  RxList<GlobalSymbolData> arrMainScript = RxList<GlobalSymbolData>();

  Rx<GlobalSymbolData> selectedScriptDropDownValue = GlobalSymbolData().obs;
  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();
    arrCustomDateSelection.addAll(CommonCustomDateSelection().arrCustomDate);
    // selectStatusdropdownValue.value = arrCustomDateSelection.first;
    isApiCallRunning = true;
    getAccountSummaryNewList("");

    getUserList();
    getExchangeList();
    if (userData!.role == UserRollList.user) {
      getAccountSummaryNewList("");
    }

    update();
  }

  getExchangeList() async {
    var response = await service.getExchangeListUserWiseCall(userId: userData!.userId!);
    if (response != null) {
      if (response.statusCode == 200) {
        arrExchangeList = response.exchangeData ?? [];
        update();
      }
    }
  }

  getScriptList() async {
    var response = await service.allSymbolListCall(1, "", selectExchangeDropdownValue.value.exchangeId ?? "");
    arrMainScript.value = response!.data ?? [];

    update();
  }

  getUserList() async {
    var response = await service.getMyUserListCall(roleId: UserRollList.user);
    arrUserListOnlyClient = response!.data ?? [];
    if (arrUserListOnlyClient.isNotEmpty) {
      // selectedUser.value = arrUserListOnlyClient.first;
    }
  }

  getAccountSummaryNewList(String text, {bool isFromfilter = false, bool isFromClear = false}) async {
    if (selectStatusdropdownValue.toString().isNotEmpty) {
      if (selectStatusdropdownValue.toString() != 'Custom Period') {
        String thisWeekDateRange = "$selectStatusdropdownValue";
        List<String> dateParts = thisWeekDateRange.split(" to ");
        startDate.value = dateParts[0].trim().split('Week').last.trim();
        endDate.value = dateParts[1];
      }
      // else {
      //   startDate = '';
      //   endDate = '';
      // }
    }
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
    isPagingApiCall = true;
    update();
    var response = await service.accountSummaryNewListCall(
      currentPage,
      text,
      userId: selectUserDropdownValue.value.userId ?? "",
      startDate: startDate.value,
      endDate: endDate.value,
      symbolId: selectedScriptDropDownValue.value.symbolId ?? "",
      exchangeId: selectExchangeDropdownValue.value.exchangeId ?? "",
      productType: selectedProductType.value.id ?? "",
    );
    arrSummaryList.addAll(response!.data!);
    isPagingApiCall = false;
    isResetCall = false;
    totalPage = response.meta!.totalPage!.toInt();
    if (totalPage >= currentPage) {
      currentPage = currentPage + 1;
    }
    for (var indexOfScript = 0; indexOfScript < arrSummaryList.length; indexOfScript++) {
      arrSummaryList[indexOfScript].profitLossValue = arrSummaryList[indexOfScript].totalQuantity! < 0
          ? (double.parse(arrSummaryList[indexOfScript].ask!.toStringAsFixed(2)) - arrSummaryList[indexOfScript].avgPrice!) * arrSummaryList[indexOfScript].totalQuantity!
          : (double.parse(arrSummaryList[indexOfScript].bid!.toStringAsFixed(2)) - double.parse(arrSummaryList[indexOfScript].avgPrice!.toStringAsFixed(2))) * arrSummaryList[indexOfScript].totalQuantity!;

      arrSummaryList[indexOfScript].total = (double.parse(arrSummaryList[indexOfScript].profitLoss!.toStringAsFixed(2)) + double.parse(arrSummaryList[indexOfScript].profitLossValue!.toStringAsFixed(2))) - double.parse(arrSummaryList[indexOfScript].brokerageTotal!.toStringAsFixed(2));
      arrSummaryList[indexOfScript].ourPer = (((arrSummaryList[indexOfScript].profitLossValue! + arrSummaryList[indexOfScript].profitLoss!) * arrSummaryList[indexOfScript].profitAndLossSharing!) / 100);
      // if (arrSummaryList[indexOfScript].total < 0) {
      arrSummaryList[indexOfScript].ourPer = arrSummaryList[indexOfScript].ourPer * -1;
      // }
      arrSummaryList[indexOfScript].ourPer = arrSummaryList[indexOfScript].ourPer + arrSummaryList[indexOfScript].adminBrokerageTotal!;
    }
    grandTotal.value = 0.0;
    outPerGrandTotal.value = 0.0;
    arrSummaryList.forEach((element) {
      grandTotal.value = element.total + grandTotal.value;

      outPerGrandTotal.value = outPerGrandTotal.value + element.ourPer;
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

  listenClientAccountScriptFromSocket(GetScriptFromSocket socketData) {
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

            arrSummaryList[indexOfScript].total = (double.parse(arrSummaryList[indexOfScript].profitLoss!.toStringAsFixed(2)) + double.parse(arrSummaryList[indexOfScript].profitLossValue!.toStringAsFixed(2))) - double.parse(arrSummaryList[indexOfScript].brokerageTotal!.toStringAsFixed(2));
            arrSummaryList[indexOfScript].ourPer = (((arrSummaryList[indexOfScript].profitLossValue! + arrSummaryList[indexOfScript].profitLoss!) * arrSummaryList[indexOfScript].profitAndLossSharing!) / 100);
            // if (arrSummaryList[indexOfScript].total < 0) {
            arrSummaryList[indexOfScript].ourPer = arrSummaryList[indexOfScript].ourPer * -1;
            // }
            arrSummaryList[indexOfScript].ourPer = arrSummaryList[indexOfScript].ourPer + arrSummaryList[indexOfScript].adminBrokerageTotal!;
          }
        }
      }

      update();
      grandTotal.value = 0.0;
      outPerGrandTotal.value = 0.0;
      arrSummaryList.forEach((element) {
        grandTotal.value = grandTotal.value + element.total;

        outPerGrandTotal.value = outPerGrandTotal.value + element.ourPer;
      });
    }
  }
}
