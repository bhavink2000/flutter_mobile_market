import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../BaseViewController/baseController.dart';

class SetQuantityValueControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetQuantityValueController());
  }
}

class SetQuantityValueController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  TextEditingController text1Controller = TextEditingController();
  FocusNode text1Focus = FocusNode();
  TextEditingController text2Controller = TextEditingController();
  FocusNode text2Focus = FocusNode();
  TextEditingController text3Controller = TextEditingController();
  FocusNode text3Focus = FocusNode();
  TextEditingController text4Controller = TextEditingController();
  FocusNode text4Focus = FocusNode();
  TextEditingController text5Controller = TextEditingController();
  FocusNode text5Focus = FocusNode();
  TextEditingController text6Controller = TextEditingController();
  FocusNode text6Focus = FocusNode();
  TextEditingController text7Controller = TextEditingController();
  FocusNode text7Focus = FocusNode();
  TextEditingController text8Controller = TextEditingController();
  FocusNode text8Focus = FocusNode();
  bool isDarkMode = false;
}
