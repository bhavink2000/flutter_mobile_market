import 'dart:convert';

import 'package:get/get.dart';

import '../../../../constant/const_string.dart';
import '../../../../main.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/getScriptFromSocket.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../../modelClass/userWiseProfitLossSummaryModelClass.dart';
import '../../../BaseViewController/baseController.dart';

class ProfitAndLossControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfitAndLossController());
  }
}

class ProfitAndLossController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  RxString fromDate = "Start Date".obs;
  RxString endDate = "End Date".obs;

  bool isApiCallRunning = false;
  bool isResetCall = false;
  Rx<UserData> selectedUser = UserData().obs;
  Rx<ExchangeData> selectedExchange = ExchangeData().obs;
  Rx<GlobalSymbolData> selectedScriptFromFilter = GlobalSymbolData().obs;

  List<UserData> arrUserDataDropDown = [];
  double totalPL = 0.0;
  double totalPLPer = 0.0;
  RxDouble totalPlWithBrk = 0.0.obs;
  List<UserWiseProfitLossData> arrPlList = [];

  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();
    getUserList();
    getProfitLossList("");
  }

  getUserList() async {
    // arrUserDataDropDown = constantValues!.userFilterType!;
    var response = await service.getMyUserListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserDataDropDown = response.data ?? [];
        update();
      }
    }
  }

  getProfitLossList(String text, {bool isFromClear = false}) async {
    if (isFromClear) {
      isResetCall = true;
    } else {
      isApiCallRunning = true;
    }

    update();
    var response = await service.userWiseProfitLossListCall(1, text, selectedUser.value.userId ?? "");
    arrPlList = response!.data ?? [];
    totalPlWithBrk.value = 0.0;
    for (var element in arrPlList) {
      for (var i = 0; i < element.childUserDataPosition!.length; i++) {
        if (element.arrSymbol != null) {
          var symbolObj = element.arrSymbol!.firstWhere((obj) => element.childUserDataPosition![i].symbolId == obj.id);

          if (element.childUserDataPosition![i].tradeType!.toLowerCase() == "sell" && element.childUserDataPosition![i].totalQuantity! > 0) {
            element.childUserDataPosition![i].profitLossValue = (double.parse(element.childUserDataPosition![i].price!.toStringAsFixed(2)) - double.parse(symbolObj.ask.toString())) * element.childUserDataPosition![i].totalQuantity!;
          } else {
            element.childUserDataPosition![i].profitLossValue = element.childUserDataPosition![i].totalQuantity! < 0
                ? (double.parse(symbolObj.ask.toString()) - element.childUserDataPosition![i].price!) * element.childUserDataPosition![i].totalQuantity!
                : (double.parse(symbolObj.bid.toString()) - double.parse(element.childUserDataPosition![i].price!.toStringAsFixed(2))) * element.childUserDataPosition![i].totalQuantity!;
          }
        }
      }

      var pl = element.role == UserRollList.user ? element.profitLoss! : element.childUserProfitLossTotal!;

      element.totalProfitLossValue = 0.0;
      for (var value in element.childUserDataPosition!) {
        element.totalProfitLossValue += value.profitLossValue ?? 0.0;
      }
      var brkTotal = 0.0;
      if (element.role == UserRollList.master) {
        brkTotal = double.parse(element.childUserBrokerageTotal!.toString());
      } else {
        brkTotal = double.parse(element.brokerageTotal!.toString());
      }

      element.plWithBrk = element.totalProfitLossValue + pl - brkTotal;
      totalPlWithBrk.value = totalPlWithBrk.value + element.plWithBrk;
      var m2m = element.totalProfitLossValue;
      var sharingPer = element.role == UserRollList.user ? element.profitAndLossSharingDownLine! : element.profitAndLossSharing!;
      var total = pl + m2m;
      var finalValue = total * sharingPer / 100;

      finalValue = finalValue * -1;
      totalPLPer = totalPLPer + finalValue;

      element.plSharePer = finalValue;

      finalValue = finalValue + element.parentBrokerageTotal!;
      element.netPL = finalValue;

      finalValue = finalValue + element.parentBrokerageTotal!;
      totalPL = totalPL + finalValue;
    }
    isApiCallRunning = false;
    isResetCall = false;
    update();
    var arrTemp = [];
    arrPlList.forEach((userObj) {
      for (var element in userObj.childUserDataPosition!) {
        if (!arrTemp.contains(element.symbolName)) {
          if (!arrSymbolNames.contains(element.symbolName)) {
            arrTemp.insert(0, element.symbolName);
            arrSymbolNames.insert(0, element.symbolName!);
          }
        }
      }
    });

    if ((arrSymbolNames.isNotEmpty)) {
      var txt = {"symbols": arrSymbolNames};
      socket.connectScript(jsonEncode(txt));
    }
  }

  listenUserWiseProfitLossScriptFromSocket(GetScriptFromSocket socketData) {
    if (socketData.data != null) {
      arrPlList.forEach((userObj) {
        for (var i = 0; i < userObj.childUserDataPosition!.length; i++) {
          if (socketData.data!.symbol == userObj.childUserDataPosition![i].symbolName) {
            // userObj.childUserDataPosition![i].profitLossValue = userObj.childUserDataPosition![i].tradeType!.toUpperCase() == "BUY"
            //     ? (double.parse(socketData.data!.bid.toString()) - userObj.childUserDataPosition![i].price!) * userObj.childUserDataPosition![i].quantity!
            //     : (userObj.childUserDataPosition![i].price! - double.parse(socketData.data!.ask.toString())) * userObj.childUserDataPosition![i].quantity!;

            if (userObj.childUserDataPosition![i].tradeType!.toLowerCase() == "sell" && userObj.childUserDataPosition![i].totalQuantity! > 0) {
              userObj.childUserDataPosition![i].profitLossValue = (double.parse(userObj.childUserDataPosition![i].price!.toStringAsFixed(2)) - double.parse(socketData.data!.ask.toString())) * userObj.childUserDataPosition![i].totalQuantity!;
              ;
            } else {
              userObj.childUserDataPosition![i].profitLossValue = userObj.childUserDataPosition![i].totalQuantity! < 0
                  ? (double.parse(socketData.data!.ask.toString()) - userObj.childUserDataPosition![i].price!) * userObj.childUserDataPosition![i].totalQuantity!
                  : (double.parse(socketData.data!.bid.toString()) - double.parse(userObj.childUserDataPosition![i].price!.toStringAsFixed(2))) * userObj.childUserDataPosition![i].totalQuantity!;
            }

            var pl = userObj.role == UserRollList.user ? userObj.profitLoss! : userObj.childUserProfitLossTotal!;
            userObj.totalProfitLossValue = 0.0;
            for (var element in userObj.childUserDataPosition!) {
              userObj.totalProfitLossValue += element.profitLossValue ?? 0.0;
            }
            var brkTotal = 0.0;
            if (userObj.role == UserRollList.master) {
              brkTotal = double.parse(userObj.childUserBrokerageTotal!.toString());
            } else {
              brkTotal = double.parse(userObj.brokerageTotal!.toString());
            }

            userObj.plWithBrk = userObj.totalProfitLossValue + pl - brkTotal;

            var m2m = userObj.totalProfitLossValue;
            var sharingPer = userObj.role == UserRollList.user ? userObj.profitAndLossSharingDownLine! : userObj.profitAndLossSharing!;
            var total = pl + m2m;
            var finalValue = total * sharingPer / 100;

            // finalValue = finalValue * -1;
            userObj.plSharePer = finalValue * -1;

            var sharingPLPer = userObj.role == UserRollList.user ? userObj.profitAndLossSharingDownLine! : userObj.profitAndLossSharing!;
            var totalPL = pl + m2m;
            var finalValuePL = (totalPL * sharingPLPer) / 100;
            finalValuePL = finalValuePL * -1;
            finalValuePL = finalValuePL + userObj.parentBrokerageTotal!;
            userObj.netPL = finalValuePL;
          }
        }
      });
      totalPL = 0.0;
      totalPLPer = 0.0;
      totalPlWithBrk.value = 0.0;
      for (var element in arrPlList) {
        totalPLPer = totalPLPer + element.plSharePer;
        totalPL = totalPL + element.netPL;
        totalPlWithBrk.value = totalPlWithBrk.value + element.plWithBrk;
      }
      update();
    }
  }
}
