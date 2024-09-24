import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/ChangePasswordScreen/userListDetailChangePasswordController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../main.dart';

class UserListChangePasswordScreen extends BaseView<UserListChangePasswordController> {
  const UserListChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            if (userData!.changePasswordOnFirstLogin == true) {
              showWarningToast("Please update your password.", controller.globalContext!);
            } else {
              Get.back();
            }
          },
          isTrailingDisplay: true,
          trailingIcon: SizedBox(
            width: 45,
          ),
          headerTitle: "Change Password",
          backGroundColor: AppColors().headerBgColor,
          onDrawerButtonPress: () {
            var mainTab = Get.find<MainTabController>();
            if (mainTab.scaffoldKey.currentState!.isDrawerOpen) {
              mainTab.scaffoldKey.currentState!.closeDrawer();
              //close drawer, if drawer is open
            } else {
              mainTab.scaffoldKey.currentState!.openDrawer();
              //open drawer, if drawer is closed
            }
          }),
      backgroundColor: AppColors().headerBgColor,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: AppColors().bgColor,
        ),
        child: Column(
          children: [
            newPassword(),
            confirmNewPassword(),
            if (controller.selectedUserID == "") MasterPassword(),
            if (controller.selectedUserID != "")
              SizedBox(
                height: 15,
              ),
            changePasswordBtnView(),
          ],
        ),
      ),
    );
  }

  Widget newPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: CustomTextField(
        type: 'Password',
        keyBoardType: TextInputType.text,
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyPassword,
        placeHolderMsg: "New Password",
        labelMsg: "New Password",
        emptyFieldMsg: AppString.emptyPassword,
        controller: controller.passwordController,
        focus: controller.passwordFocus,
        isSecure: controller.isEyeOpen,
        maxLength: 20,
        keyboardButtonType: TextInputAction.next,
        sufixIcon: GestureDetector(
          onTap: () {
            controller.isEyeOpen = !controller.isEyeOpen;
            controller.update();
          },
          child: Image.asset(
            controller.isEyeOpen ? AppImages.eyeCloseIcon : AppImages.eyeOpenIcon,
            width: 22,
            height: 22,
          ),
        ),
      ),
    );
  }

  Widget confirmNewPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: CustomTextField(
        type: 'Password',
        keyBoardType: TextInputType.text,
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyConfirmPassword,
        placeHolderMsg: "Confirm Password",
        labelMsg: "Confirm Password",
        emptyFieldMsg: AppString.emptyConfirmPassword,
        controller: controller.confirmNewpasswordController,
        focus: controller.confirmNewpasswordFocus,
        isSecure: controller.confirmIsEyeOpen,
        maxLength: 20,
        keyboardButtonType: TextInputAction.next,
        sufixIcon: GestureDetector(
          onTap: () {
            controller.confirmIsEyeOpen = !controller.confirmIsEyeOpen;
            controller.update();
          },
          child: Image.asset(
            controller.confirmIsEyeOpen ? AppImages.eyeCloseIcon : AppImages.eyeOpenIcon,
            width: 22,
            height: 22,
          ),
        ),
      ),
    );
  }

  Widget MasterPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: CustomTextField(
        type: 'Password',
        keyBoardType: TextInputType.text,
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyMasterPassword,
        placeHolderMsg: "Current Password",
        labelMsg: "Current Password",
        emptyFieldMsg: AppString.emptyMasterPassword,
        controller: controller.MasterpasswordController,
        focus: controller.masterPasswordFocus,
        isSecure: controller.masterIsEyeOpen,
        maxLength: 20,
        keyboardButtonType: TextInputAction.done,
        sufixIcon: GestureDetector(
          onTap: () {
            controller.masterIsEyeOpen = !controller.masterIsEyeOpen;
            controller.update();
          },
          child: Image.asset(
            controller.masterIsEyeOpen ? AppImages.eyeCloseIcon : AppImages.eyeOpenIcon,
            width: 22,
            height: 22,
          ),
        ),
      ),
    );
  }

  Widget changePasswordBtnView() {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: CustomButton(
        isEnabled: true,
        shimmerColor: AppColors().whiteColor,
        title: "Change Password",
        textSize: 16,
        onPress: () {
          controller.callForChangePassword();
        },
        bgColor: AppColors().blueColor,
        isFilled: true,
        textColor: AppColors().whiteColor,
        isTextCenter: true,
        isLoading: controller.isApiCallRunning,
      ),
    );
  }
}
