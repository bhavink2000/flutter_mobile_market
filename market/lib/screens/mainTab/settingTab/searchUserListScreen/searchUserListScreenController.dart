import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:market/screens/BaseViewController/baseController.dart';

import '../../../../modelClass/myUserListModelClass.dart';

class SearchUserListControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchUserListController());
  }
}

class SearchUserListController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  TextEditingController textController = TextEditingController();
  FocusNode textFocus = FocusNode();
  //List<settingUserListModel> arrMainScript = [];
  //List<settingUserListModel> arrUserListData = [];

  List<UserData> arrSearchUserData = [];
  List<UserData> arrSUserListData = [];
  bool isLoadingData = false;
  @override
  void onInit() async {
    super.onInit();
    //arrUserListData.addAll(SearchUserListScreenClass().arrUserListDatas);
    //arrMainScript.addAll(SearchUserListScreenClass().arrUserListDatas);
    await getUserList();
    update();
  }

  getUserList() async {
    isLoadingData = true;
    update();
    var response = await service.getMyUserListCall(
      text: textController.text.trim(),
    );
    isLoadingData = false;
    if (response != null) {
      if (response.statusCode == 200) {
        arrSUserListData = response.data ?? [];
        arrSearchUserData.addAll(arrSUserListData);
        update();
      }
      print('=============================');
      print("arr S User List Data ->${arrSUserListData}");
      print('=============================');
    }
  }
}
