import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

class UserListIntradayControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserListIntradayController());
  }
}

class UserListIntradayController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  bool isNSEOn = false;
  bool isMCXOn = false;
  bool isSGXOn = false;
  bool isDarkMode = false;
}
