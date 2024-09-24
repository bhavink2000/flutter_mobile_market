import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/getScriptFromSocket.dart';
import 'package:market/modelClass/m2mProfitLossDataModelClass.dart';
import 'package:market/modelClass/settingPLListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

class ClientPLControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientPLController());
  }
}

class ClientPLController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  final TextEditingController searchtextEditingController = TextEditingController();
  FocusNode searchtextEditingFocus = FocusNode();
  Rx<m2mProfitLossData> selectedDropdownValue = m2mProfitLossData().obs;
  bool isDarkMode = false;
  List<settingPLListModel> arrUserData = [];

  List<m2mProfitLossData> arrUserDataDropDown = [];
  List<m2mProfitLossData> arrPlList = [];
  String selectedUserId = "";
  var totalPLvalue = 0.0;

  @override
  void onInit() async {
    super.onInit();
    // arrUserData.addAll(settingProfitLossClass().arrUserData);
    getProfitLossList("");
    getDropDownList("");
    // selectedDropdownValue.value = arrUserDataDropDown.first.userName!;
    // selectedUserId = arrUserDataDropDown.first.userId!;
    update();
  }

  getProfitLossList(String text) async {
    // print(text);
    var response = await service.m2mProfitLossListCall(1, text, selectedUserId);
    arrPlList = response!.data ?? [];
    // print(response.data != null);
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

    var txt = {"symbols": arrSymbolNames};

    if ((arrSymbolNames.isNotEmpty)) {
      socket.connectScript(jsonEncode(txt));
    }
  }

  getDropDownList(String text) async {
    // print(text);
    var response = await service.m2mProfitLossListCall(1, text, selectedUserId);
    arrUserDataDropDown = response!.data ?? [];
    update();
  }

  listenM2MProfitLossScriptFromScoket(GetScriptFromSocket socketData) {
    if (socketData.data != null) {
      totalPLvalue = 0.0;
      arrPlList.forEach((userObj) {
        for (var i = 0; i < userObj.childUserDataPosition!.length; i++) {
          if (socketData.data!.symbol == userObj.childUserDataPosition![i].symbolName) {
            userObj.childUserDataPosition![i].profitLossValue = userObj.childUserDataPosition![i].tradeType!.toUpperCase() == "BUY"
                ? (double.parse(socketData.data!.bid.toString()) - userObj.childUserDataPosition![i].price!) * userObj.childUserDataPosition![i].quantity!
                : (userObj.childUserDataPosition![i].price! - double.parse(socketData.data!.ask.toString())) * userObj.childUserDataPosition![i].quantity!;
          }
        }
        // print(userObj.childUserDataPosition!.length);
        userObj.totalProfitLossValue = 0.0;
        for (var element in userObj.childUserDataPosition!) {
          userObj.totalProfitLossValue += element.profitLossValue ?? 0.0;
        }
        totalPLvalue += userObj.totalProfitLossValue;
      });
      update();
    }
  }
}
