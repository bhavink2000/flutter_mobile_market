import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/modelClass/settelementListModelClass.dart';
import 'package:market/modelClass/settingPLListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

import '../../../../modelClass/myUserListModelClass.dart';

class SettlementReportControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettlementReportController());
  }
}

class SettlementReportController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  List<String> arrCustomDateSelection = [];
  bool radioYes = false;
  bool radioNo = false;
  String? fromDate = "";
  String? toDate = "";
  TextEditingController textController = TextEditingController();
  FocusNode textFocus = FocusNode();
  final TextEditingController searchtextEditingController = TextEditingController();

  RxString selectStatusdropdownValue = "".obs;
  RxString selectdatedropdownValue = "".obs;
  bool isDarkMode = false;
  List<settingPLListModel> arrUserData = [];

  List<UserData> arrUserDataDropDown = [];
  List<Profit> arrProfitList = [];
  List<Profit> arrLossList = [];
  String selectedUserId = "";
  Rx<UserData> selectedUser = UserData().obs;
  SettelementData? totalValues;
  bool isApiCallFromSearch = false;
  bool isApiCallFromReset = false;
  bool isApiCallFirstTime = false;

  FocusNode searchFocus = FocusNode();
  @override
  void onInit() async {
    super.onInit();
    getUserList();
    arrCustomDateSelection.addAll(CommonCustomDateSelection().arrCustomDate);
    arrUserData.addAll(settingProfitLossClass().arrUserData);
    getSettelementList();
    update();
  }

  getUserList() async {
    var response = await service.getMyUserListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserDataDropDown = response.data ?? [];
        update();
      }
    }
  }

  getSettelementList({int isFrom = 0}) async {
    if (isFrom == 0) {
      isApiCallFirstTime = true;
    } else if (isFrom == 1) {
      isApiCallFromSearch = true;
    } else {
      isApiCallFromReset = true;
    }
    update();
    var response = await service.settelementListCall(1, searchtextEditingController.text.trim(), selectedUser.value.userId ?? "");
    if (isFrom == 0) {
      isApiCallFirstTime = false;
    } else if (isFrom == 1) {
      isApiCallFromSearch = false;
    } else {
      isApiCallFromReset = false;
    }
    arrProfitList = response?.data?.profit ?? [];
    arrLossList = response?.data?.loss ?? [];
    totalValues = response?.data!;
    for (var element in arrProfitList) {
      totalValues!.plProfitGrandTotal = totalValues!.plProfitGrandTotal + element.profitLoss!;
      totalValues!.brkProfitGrandTotal = totalValues!.brkProfitGrandTotal + element.brokerageTotal!;
    }
    totalValues!.profitGrandTotal = totalValues!.plProfitGrandTotal - totalValues!.brkProfitGrandTotal;
    for (var element in arrLossList) {
      totalValues!.plLossGrandTotal = totalValues!.plLossGrandTotal + element.profitLoss!;
      totalValues!.brkLossGrandTotal = totalValues!.brkLossGrandTotal + element.brokerageTotal!;
    }
    totalValues!.LossGrandTotal = totalValues!.plLossGrandTotal - totalValues!.brkLossGrandTotal;
    update();
  }
}
