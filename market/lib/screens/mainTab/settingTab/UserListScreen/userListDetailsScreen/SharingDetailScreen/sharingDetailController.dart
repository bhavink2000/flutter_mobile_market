import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/modelClass/profileInfoModelClass.dart';
import 'package:market/modelClass/settingListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

class SharingDetailsControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SharingDetailsController());
  }
}

class SharingDetailsController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  List<sharingDetailsGroupModel> arrData = [];
  ProfileInfoData? selectedUserData;
  String selectedUserId = "";
  bool isUserApiCallRunning = false;
  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      selectedUserId = Get.arguments["userId"];
      getUSerInfo();
    }
  }

  getUSerInfo() async {
    isUserApiCallRunning = true;
    update();
    var userResponse = await service.profileInfoByUserIdCall(selectedUserId);
    isUserApiCallRunning = false;
    update();
    if (userResponse != null) {
      if (userResponse.statusCode == 200) {
        selectedUserData = userResponse.data;

        update();
      }
    }
  }
}
