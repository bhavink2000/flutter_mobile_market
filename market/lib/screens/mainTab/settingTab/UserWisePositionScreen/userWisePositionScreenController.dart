import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

import '../../../../constant/color.dart';
import '../../../../constant/const_string.dart';
import '../../../../main.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/getScriptFromSocket.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../../modelClass/settingUserListModelClass.dart';
import '../../../../modelClass/settingUserWiseNetpositionModelClass.dart';
import '../../../../modelClass/userRoleListModelClass.dart';

class UserWiseScreenControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserWiseScreenController());
  }
}

class UserWiseScreenController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  final TextEditingController searchListingTextEditingController = TextEditingController();
  FocusNode searchListingtextEditingFocus = FocusNode();
  Rx<userRoleListData> selectedRoll = userRoleListData().obs;
  final TextEditingController searchScriptextEditingController = TextEditingController();
  FocusNode searchScripttextEditingFocus = FocusNode();
  Rx<GlobalSymbolData> selectScriptdropdownValue = GlobalSymbolData().obs;
  final TextEditingController searchUsertextEditingController = TextEditingController();
  FocusNode searchUsertextEditingFocus = FocusNode();
  Rx<UserData> selectUserdropdownValue = UserData().obs;
  bool isDarkMode = false;
  Rx<ExchangeData> selectExchangedropdownValue = ExchangeData().obs;
  List<settingUserListModel> arrUserListData = [];
  List<settingUserListModel> arrMainScript = [];

  RxList<GlobalSymbolData> arrScriptDropdown = RxList<GlobalSymbolData>();
  List<ExchangeData> arrExchangeList = [];
  RxList<UserData> arrUserDataDropDown = RxList<UserData>();

  bool isLoadingData = false;
  List<UWNPData> arrUserWiseNPList = [];
  RxDouble totalPosition = 0.0.obs;
  Rx<UWNPData?>? selectedScript;

  @override
  void onInit() async {
    super.onInit();

    getScriptList();
    getExchangeList();
    arrUserListData.addAll(SettingUserListScreenClass().arrUserListData);
    arrMainScript.addAll(arrUserListData);
    await getUserWiseNetpositionList();
    update();
  }

  getUserWiseNetpositionList() async {
    isLoadingData = true;
    update();
    var response = await service.userWiseNetPosition(
      search: searchListingTextEditingController.text.trim(),
      eId: selectExchangedropdownValue.value.exchangeId.toString(),
      sId: selectScriptdropdownValue.value.symbolId ?? "",
      uId: selectUserdropdownValue.value.userId.toString(),
    );
    isLoadingData = false;
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserWiseNPList = response.data ?? [];
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

  listenUserWisePositionScriptFromScoket(GetScriptFromSocket socketData) {
    if (socketData.status == true) {
      var obj = arrUserWiseNPList.firstWhereOrNull((element) => socketData.data!.symbol == element.symbolName);

      if (obj != null) {
        var indexOfScript = arrUserWiseNPList.indexWhere((element) => element.symbolName == socketData.data?.symbol);
        if (indexOfScript != -1) {
          arrUserWiseNPList[indexOfScript].scriptDataFromSocket.value = socketData.data!;

          if (arrUserWiseNPList[indexOfScript].currentPriceFromSocket != 0.0) {
            arrUserWiseNPList[indexOfScript].profitLossValue = arrUserWiseNPList[indexOfScript].tradeTypeValue!.toUpperCase() == "BUY"
                ? (double.parse(socketData.data!.bid.toString()) - arrUserWiseNPList[indexOfScript].price!) * arrUserWiseNPList[indexOfScript].quantity!
                : (arrUserWiseNPList[indexOfScript].price! - double.parse(socketData.data!.ask.toString())) * arrUserWiseNPList[indexOfScript].quantity!;
          }
        }
        totalPosition.value = 0.0;
        for (var element in arrUserWiseNPList) {
          totalPosition.value += element.profitLossValue;
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

  getUserList() async {
    var response = await service.getMyUserListCall(roleId: selectedRoll.value.roleId!);
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserDataDropDown.value = response.data ?? [];
        update();
      }
    }
  }

  bool isScriptLoad = false;
  getScriptList() async {
    isScriptLoad = true;

    var response = await service.allSymbolListCall(1, "", selectExchangedropdownValue.value.exchangeId ?? "");

    if (response != null) {
      if (response.data!.isNotEmpty) {
        arrScriptDropdown.addAll(response.data!);
      }
    } else {
      arrScriptDropdown.clear();
    }

    isScriptLoad = false;
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
}
