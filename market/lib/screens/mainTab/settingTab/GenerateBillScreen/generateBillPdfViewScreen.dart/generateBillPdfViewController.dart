import 'package:get/get.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

class GenerateBillPdfViewControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenerateBillPdfViewController());
  }
}

class GenerateBillPdfViewController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */

  @override
  void onInit() async {
    super.onInit();
    update();
  }
}
