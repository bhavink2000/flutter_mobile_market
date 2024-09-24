import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/modelClass/settingIntradayHistoryListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';

class IntradayHistoryControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntradayHistoryController());
  }
}

class IntradayHistoryController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  RxString exchangedropdownValue = "".obs;
  List<String> minuteslistdata = <String>['Minute', '3Minute', '5Minute', '10Minute', '15Minute', '30Minute', '60Minute', 'Day'];
  RxString minutesdropdownValue = "".obs;
  List<String> arrUserData = [];
  bool isDarkMode = false;
  final TextEditingController searchtextEditingController = TextEditingController();
  FocusNode searchtextEditingFocus = FocusNode();
  RxString selectScriptdropdownValue = "".obs;
  List<settingIntradayHistoryListModel> arrData = [];

  List<ExchangeData> arrExchangeList = [];
  List<GlobalSymbolData> arrScriptListDropdown = [];
  @override
  void onInit() async {
    super.onInit();
    getExchangeList();
    getScriptList();
    arrUserData.addAll(CommonCustomUserSelection().arrUserDatas);
    arrData.addAll(settingIntradayHistoryClass().arrSettingIntradayHistoryListData);
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
    var response = await service.allSymbolListCall(1, "", "");
    arrScriptListDropdown = response!.data ?? [];
    update();
  }
}
