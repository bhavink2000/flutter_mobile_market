import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/commonFunction.dart';
import '../../../constant/const_string.dart';
import '../../../constant/utilities.dart';
import '../../../main.dart';
import '../../../navigation/routename.dart';
import '../../BaseViewController/baseController.dart';

class SignInControllerBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(() => SignInController());
    Get.put(SignInController());
  }
}

class SignInController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */

  TextEditingController serverController = TextEditingController();
  FocusNode serverFocus = FocusNode();
  TextEditingController userNameController = TextEditingController();
  FocusNode userNameFocus = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  RxBool isLoadingSignIn = false.obs;
  List<String> arrServerName = [];
  bool isEyeOpen = true;

  @override
  void onInit() async {
    // TODO: implement onInit
    // serverController.text = "bazaar";
    // userNameController.text = "kesh";
    // passwordController.text = "123456";
    super.onInit();
    // serverController.text = "bazaar";
    localStorage.erase();
    var response = await service.getServerNameCall();
    if (response?.statusCode == 200) {
      serverName = response?.data?.serverName ?? "";
      arrServerName.add(response?.data?.serverName ?? "");
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      update();
    });
    serverFocus.addListener(() {
      update();
    });
    userNameFocus.addListener(() {
      update();
    });
    passwordFocus.addListener(() {
      update();
    });
  }

//*********************************************************************** */
  // Field Validation
  //*********************************************************************** */

  String validateField() {
    var msg = "";
    // if (serverController.text.trim().isEmpty) {
    //   msg = AppString.emptyServer;
    // } else if (serverController.text.trim() != serverName) {
    //   msg = AppString.invalidServer;
    // } else

    if (userNameController.text.trim().isEmpty) {
      msg = AppString.emptyUserName;
    } else if (passwordController.text.trim().isEmpty) {
      msg = AppString.emptyPassword;
    }
    return msg;
  }

  //*********************************************************************** */
  // Api Calls
  //*********************************************************************** */

  callForSignIn() async {
    var msg = validateField();
    if (msg.isEmpty) {
      serverFocus.unfocus();
      userNameFocus.unfocus();
      passwordFocus.unfocus();
      isLoadingSignIn.value = true;
      update();
      var response = await service.signInCall(userName: userNameController.text.trim(), password: passwordController.text.trim(), serverName: serverController.text.trim());

      if (response != null) {
        if (response.statusCode == 200) {
          update();
          if (response.statusCode == 200) {
            isAccessTokenExpired = false;
            arrSymbolNames.clear();
            isLogoutRunning = false;
            userToken = response.meta?.token;
            userId = response.data?.userId;
            await localStorage.write(localStorageKeys.userToken, response.meta?.token);

            await localStorage.write(localStorageKeys.userId, response.data?.userId);

            await localStorage.write(localStorageKeys.profitAndLossSharingDownLine, response.data?.profitAndLossSharingDownLine);
            await localStorage.write(localStorageKeys.brkSharingDownLine, response.data?.brkSharingDownLine);

            await localStorage.write(localStorageKeys.profitAndLossSharingUpLine, response.data?.profitAndLossSharing);
            await localStorage.write(localStorageKeys.brkSharingUpLine, response.data?.brkSharing);
            log("----------------Token------------------");
            log(userToken.toString());
            log("----------------Token------------------");
            await localStorage.write(localStorageKeys.userData, response.data!.toJson());
            await socket.connectSocket();

            var userResponse = await service.profileInfoCall();
            if (userResponse != null) {
              if (userResponse.statusCode == 200) {
                userData = userResponse.data;
                socketIO.init();
                update();
              }
            }
            if (userData!.role != UserRollList.user && userData!.role != UserRollList.broker) {
              await callForRoleList();
            }

            var response1 = await service.getConstantCall();

            if (response1 != null) {
              constantValues = response1.data;
              getExchangeList();
            }
            isLoadingSignIn.value = false;

            Get.offAllNamed(RouterName.mainTab, arguments: true);
          } else {
            isLoadingSignIn.value = false;
            update();
            showSuccessToast(response.meta?.message ?? "", globalContext!);
          }
        } else {
          isLoadingSignIn.value = false;
          update();
          showErrorToast(response.message ?? "", globalContext!);
        }
      } else {
        isLoadingSignIn.value = false;
        update();
        showErrorToast(AppString.generalError, globalContext!);
        isLoadingSignIn.value = false;
        update();
      }
    } else {
      isLoadingSignIn.value = false;
      update();
      showWarningToast(msg, globalContext!);
    }
  }
}
