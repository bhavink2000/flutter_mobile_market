import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/modelClass/settingWeeklyAdminListModel.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

import '../../../../modelClass/myUserListModelClass.dart';

class WeeklyAdminControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeeklyAdminController());
  }
}

class WeeklyAdminController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  final TextEditingController searchtextEditingController =
      TextEditingController();
  FocusNode searchtextEditingFocus = FocusNode();
  RxString selectStatusdropdownValue = "".obs;
  bool isDarkMode = false;
  List<settingWeeklyAdmimListModel> arrUserListData = [];

  List<UserData> arrUserDataDropDown = [];
  @override
  void onInit() async {
    super.onInit();
    getUserList();
    arrUserListData
        .addAll(settingWeeklyAdminClass().settingWeeklyAdmimListData);
  }

  getUserList() async {
    var response = await service.getMyUserListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserDataDropDown = response.data ?? [];
        update();
      }
    }
  }
}
