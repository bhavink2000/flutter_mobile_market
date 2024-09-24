import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/modelClass/settingMessageListModelClass.dart';

import '../../../BaseViewController/baseController.dart';

class SettingMessageControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingMessageController());
  }
}

class SettingMessageController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  List<settingMessageListModel> arrMessageData = [];
  @override
  void onInit() async {
    super.onInit();
    arrMessageData.addAll(SettingMessageListClass().arrsettingMessageListModel);
    update();
  }
}
