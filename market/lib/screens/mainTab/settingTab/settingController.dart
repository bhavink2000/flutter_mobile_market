import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/modelClass/settingListModelClass.dart';
import 'package:ticker_text/ticker_text.dart';

import '../../BaseViewController/baseController.dart';
import '../../../constant/const_string.dart';

class SettingControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}

class SettingController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  TickerTextController moveTextController = TickerTextController();
  bool isDetailSciptOn = false;
  bool isUserOn = false;
  bool isDarkMode = false;
  List<GroupModel> arrCategoryData = [];
  bool isThemeOpen = false;

  List<String> arrHeader = ["Account", "Reports", "Setting"];

  @override
  void onInit() async {
    super.onInit();
    arrCategoryData.addAll(settingListClass().arrSettingCategoryData);
    isDetailSciptOn = localStorage.read(localStorageKeys.isDetailSciptOn) ?? false;
    moveTextController.startScroll();
    isDarkMode = localStorage.read(localStorageKeys.isDarkMode) ?? false;
    Future.delayed(const Duration(milliseconds: 100), () {
      update();
    });
  }
}
