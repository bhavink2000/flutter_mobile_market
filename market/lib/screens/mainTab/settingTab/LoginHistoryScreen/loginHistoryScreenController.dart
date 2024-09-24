import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/modelClass/userLoginHistoryModelClass.dart';

import '../../../../constant/const_string.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../BaseViewController/baseController.dart';

class SettingLoginHistoryControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingLoginHistoryController());
  }
}

class SettingLoginHistoryController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  List<String> arrCustomDateSelection = [];
  String? fromDate;
  String? toDate;
  RxString selectUserDropdownValue = "".obs;
  final TextEditingController textEditingController = TextEditingController();
  FocusNode textEditingFocus = FocusNode();
  final TextEditingController searchtextEditingController = TextEditingController();
  FocusNode searchtextEditingFocus = FocusNode();
  RxString selectStatusdropdownValue = "".obs;
  bool isDarkMode = false;
  // List<settingUserListModel> arrUserListData = [];
  List<userLoginHistoryData> arrMainScript = [];
  bool isApiCallRunning = false;
  List<UserData> arrUserDataDropDown = [];
  bool isPagingApiCall = false;
  int totalPage = 0;
  int currentPage = 1;
  @override
  void onInit() async {
    super.onInit();
    getUserList();
    arrCustomDateSelection.addAll(CommonCustomDateSelection().arrCustomDate);
    arrMainScript.addAll(arrUserLoginHistoryData);
    isApiCallRunning = true;
    getUserListData();
    update();
  }

  //*********************************************************************** */
  // Api Calls
  //*********************************************************************** */

  List<userLoginHistoryData> arrUserLoginHistoryData = [];
  getUserListData() async {
    if (isPagingApiCall) {
      return;
    }
    isPagingApiCall = true;
    update();
    var response = await service.userLoginHistoryCall(currentPage);
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserLoginHistoryData.addAll(response.data!);
        isApiCallRunning = false;
        isPagingApiCall = false;
        totalPage = response.meta!.totalPage!;
        if (totalPage >= currentPage) {
          currentPage = currentPage + 1;
        }

        update();
      }
    }
  }

  getUserList() async {
    var response = await service.getMyUserListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserDataDropDown = response.data ?? [];
        update();
      } else {
        print("in else");
      }
    } else {
      print("main else");
    }
  }
}
