import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../BaseViewController/baseController.dart';

class CustomDrawerControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomDrawerController());
  }
}

class CustomDrawerController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();

}
