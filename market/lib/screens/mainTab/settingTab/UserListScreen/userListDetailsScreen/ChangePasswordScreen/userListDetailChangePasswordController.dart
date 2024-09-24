import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

import '../../../../../../constant/const_string.dart';
import '../../../../../../constant/utilities.dart';
import '../../../../../../main.dart';

class UserListChangePasswordControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserListChangePasswordController());
  }
}

class UserListChangePasswordController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  TextEditingController confirmNewpasswordController = TextEditingController();
  FocusNode confirmNewpasswordFocus = FocusNode();
  TextEditingController MasterpasswordController = TextEditingController();
  FocusNode masterPasswordFocus = FocusNode();

  bool isEyeOpen = true;
  bool confirmIsEyeOpen = true;
  bool masterIsEyeOpen = true;
  bool isDarkMode = false;
  bool isApiCallRunning = false;
  String selectedUserID = "";

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      selectedUserID = Get.arguments["userId"];
    }
    update();
  }

  //*********************************************************************** */
  // Field Validation
  //*********************************************************************** */

  String validateField() {
    var msg = "";
    if (selectedUserID == "") {
      if (passwordController.text.trim().isEmpty) {
        msg = AppString.emptyPassword;
      } else if (confirmNewpasswordController.text.trim().isEmpty) {
        msg = AppString.emptyConfirmPassword;
      } else if (MasterpasswordController.text.trim().isEmpty) {
        msg = AppString.emptyMasterPassword;
      } else if (passwordController.text.trim() != confirmNewpasswordController.text.trim()) {
        msg = AppString.passwordNotMatch;
      }
    } else {
      if (passwordController.text.trim().isEmpty) {
        msg = AppString.emptyPassword;
      } else if (confirmNewpasswordController.text.trim().isEmpty) {
        msg = AppString.emptyConfirmPassword;
      } else if (passwordController.text.trim() != confirmNewpasswordController.text.trim()) {
        msg = AppString.passwordNotMatch;
      }
    }

    return msg;
  }
  //*********************************************************************** */
  // Api Calls
  //*********************************************************************** */

  callForChangePassword() async {
    var msg = validateField();
    if (msg.isEmpty) {
      masterPasswordFocus.unfocus();
      confirmNewpasswordFocus.unfocus();
      passwordFocus.unfocus();
      isApiCallRunning = true;
      update();

      var response = await service.changePasswordCall(MasterpasswordController.text.trim(), passwordController.text.trim(), userId: selectedUserID);
      if (response != null) {
        isApiCallRunning = false;
        if (response.statusCode == 200) {
          var userResponse = await service.profileInfoCall();
          if (userResponse != null) {
            if (userResponse.statusCode == 200) {
              userData = userResponse.data;
              Get.back();
              showSuccessToast(response.meta?.message ?? "",globalContext!);
              update();
              update();
            }
          }
        } else {
          showErrorToast(response.message ?? "",globalContext!);
          update();
        }
      } else {
        showErrorToast(AppString.generalError,globalContext!);
        update();
      }
    } else {
      showWarningToast(msg,globalContext!);
    }
  }
}
