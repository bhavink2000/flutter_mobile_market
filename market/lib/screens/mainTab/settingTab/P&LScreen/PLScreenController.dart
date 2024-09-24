import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/modelClass/settingPLListModelClass.dart';

import 'package:market/screens/BaseViewController/baseController.dart';

import '../../../../modelClass/myUserListModelClass.dart';

class PLControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PLController());
  }
}

class PLController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();

  final TextEditingController searchtextEditingController =
      TextEditingController();
  FocusNode searchtextEditingFocus = FocusNode();
  RxString selectedUserdropdownValue = "".obs;
  bool isDarkMode = false;
  List<settingPLListModel> arrUserData = [];

  List<UserData> arrUserDataDropDown = [];
  @override
  void onInit() async {
    super.onInit();
    getUserList();
    arrUserData.addAll(settingProfitLossClass().arrUserData);
    update();
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
