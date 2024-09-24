import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/IntraDaySquareoffScreen/userListDetailIntraDayController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserListIntradayScreen extends BaseView<UserListIntradayController> {
  const UserListIntradayScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
          },
          isTrailingDisplay: true,
          trailingIcon: SizedBox(
            width: 45,
          ),
          headerTitle: "Intraday Square off",
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
            nseSwitchView(),
            lineView(),
            mcxSwitchView(),
            lineView(),
            sgxSwitchView(),
            lineView(),
            updateBtnView(),
          ],
        ),
      ),
    );
  }

  Widget lineView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Container(
        height: 1,
        width: 100.w,
        color: AppColors().grayLightLine,
      ),
    );
  }

  Widget nseSwitchView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text("NSE", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Container(
              height: 22, //set desired REAL HEIGHT
              width: 36,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.isNSEOn ? AppColors().blueColor : AppColors().lightText,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Transform.scale(
                transformHitTests: false,
                scale: .6,
                child: CupertinoSwitch(
                  value: controller.isNSEOn,
                  activeColor: AppColors().whiteColor,
                  trackColor: AppColors().whiteColor,
                  thumbColor: controller.isNSEOn ? AppColors().blueColor : AppColors().switchColor,
                  onChanged: (bool value) async {
                    controller.isNSEOn = !controller.isNSEOn;
                    controller.update();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mcxSwitchView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text("MCX", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Container(
              height: 22, //set desired REAL HEIGHT
              width: 36,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.isMCXOn ? AppColors().blueColor : AppColors().lightText,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Transform.scale(
                transformHitTests: false,
                scale: .6,
                child: CupertinoSwitch(
                  value: controller.isMCXOn,
                  activeColor: AppColors().whiteColor,
                  trackColor: AppColors().whiteColor,
                  thumbColor: controller.isMCXOn ? AppColors().blueColor : AppColors().switchColor,
                  onChanged: (bool value) async {
                    controller.isMCXOn = !controller.isMCXOn;
                    controller.update();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sgxSwitchView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text("SGX", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Container(
              height: 22, //set desired REAL HEIGHT
              width: 36,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.isSGXOn ? AppColors().blueColor : AppColors().lightText,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Transform.scale(
                transformHitTests: false,
                scale: .6,
                child: CupertinoSwitch(
                  value: controller.isSGXOn,
                  activeColor: AppColors().whiteColor,
                  trackColor: AppColors().whiteColor,
                  thumbColor: controller.isSGXOn ? AppColors().blueColor : AppColors().switchColor,
                  onChanged: (bool value) async {
                    controller.isSGXOn = !controller.isSGXOn;
                    controller.update();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget updateBtnView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: CustomButton(
        isEnabled: true,
        shimmerColor: AppColors().whiteColor,
        title: "Update",
        textSize: 16,
        // buttonWidth: 95.w,
        onPress: () {
          // Get.offAllNamed(RouterName.signInScreen);
        },
        bgColor: AppColors().blueColor,
        isFilled: true,
        textColor: AppColors().whiteColor,
        isTextCenter: true,
        isLoading: false,
      ),
    );
  }
}
