import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/constantModelClass.dart';
import 'package:market/modelClass/myUserListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import '../../../../modelClass/userRoleListModelClass.dart';

class SettingUserListControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingUserListController());
  }
}

class SettingUserListController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  TextEditingController textController = TextEditingController();
  FocusNode textFocus = FocusNode();
  RxBool isLoadingGiveHelp = false.obs;
  List<UserData> arrSearchUserData = [];
  List<UserData> arrUserListData = [];

  int totalPage = 0;
  int currentPage = 1;
  bool isDarkMode = false;
  List<AddMaster> userlist = [];
  List<userRoleListData> selectUserlist = [];
  List<AddMaster> selectStatuslist = [];
  Rx<AddMaster> userdropdownValue = AddMaster().obs;
  Rx<userRoleListData> selectUserdropdownValue = userRoleListData().obs;
  Rx<AddMaster> selectStatusdropdownValue = AddMaster().obs;
  bool isLoadingData = false;
  bool isPagingApiCall = false;
  @override
  void onInit() async {
    selectStatuslist = constantValues!.status!;
    userlist = constantValues!.userFilterType!;
    super.onInit();
    isLoadingData = true;
    await getUserList();
    await callForRoleList();
    update();
  }

  updateList() {
    currentPage = 1;

    getUserList();
  }

  getUserList() async {
    if (isPagingApiCall) {
      return;
    }
    isPagingApiCall = true;
    update();
    var response = await service.getChildUserListCall(text: textController.text.trim(), status: selectStatusdropdownValue.value.id?.toString() ?? "", roleId: selectUserdropdownValue.value.roleId ?? "", filterType: userdropdownValue.value.id?.toString() ?? "", page: currentPage);
    isLoadingData = false;
    isPagingApiCall = false;
    update();
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserListData.clear();
        arrSearchUserData.clear();
        arrUserListData.addAll(response.data!);
        arrSearchUserData.addAll(response.data!);
        totalPage = response.meta!.totalPage!;
        if (totalPage >= currentPage) {
          currentPage = currentPage + 1;
        }
        update();
      }
    }
  }

  callForRoleList() async {
    update();
    var response = await service.userRoleListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        selectUserlist = response.data!;
        update();
      }
    }
  }
}
