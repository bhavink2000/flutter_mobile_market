import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../BaseViewController/baseController.dart';

class walletControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => walletController());
  }
}

class walletController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();

}
