import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/modelClass/groupSettingListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

class GroupQuantityControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupQuantityController());
  }
}

class GroupQuantityController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  List<GroupSettingData> arrGroupSetting = [];
  String selectedUserId = "";
  bool isDarkMode = false;
  bool isApiCallRunning = false;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      selectedUserId = Get.arguments["userId"];
      groupSettingList();
    }
  }

  groupSettingList() async {
    arrGroupSetting.clear();
    isApiCallRunning = true;
    update();
    var response = await service.groupSettingListCall(userId: selectedUserId, page: 1);

    arrGroupSetting = response!.data ?? [];
    isApiCallRunning = false;
    update();
  }
}
