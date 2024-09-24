import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/screens/mainTab/settingTab/profileScreen/SettingProfileScreenController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constant/color.dart';

import '../../../../constant/font_family.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../../main.dart';
import '../../../BaseViewController/baseController.dart';
import '../../tabScreen/MainTabController.dart';

class SettingProfileScreen extends BaseView<SettingProfileController> {
  const SettingProfileScreen({Key? key}) : super(key: key);

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
          headerTitle: "Profile Info",
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
            profileDetailsListView(),
          ],
        ),
      ),
    );
  }

  Widget profileDetailsListView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 38,
            color: AppColors().contentBg,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              child: Row(
                children: [
                  Text("Name", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  const Spacer(),
                  Text(controller.arrProfileData?.name ?? "", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                ],
              ),
            ),
          ),
          Container(
            width: 100.w,
            height: 38,
            color: AppColors().footerColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              child: Row(
                children: [
                  Text("User Name :", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  const Spacer(),
                  Text(controller.arrProfileData?.userName ?? "", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                ],
              ),
            ),
          ),
          Container(
            width: 100.w,
            height: 38,
            color: AppColors().contentBg,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              child: Row(
                children: [
                  Text("Device Name :", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  const Spacer(),
                  Text(Platform.isAndroid ? "Android" : "iOS", // bhavin
                      style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                ],
              ),
            ),
          ),
          Container(
            width: 100.w,
            height: 38,
            color: AppColors().footerColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              child: Row(
                children: [
                  Text("Version Code :", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  const Spacer(),
                  Text(packageInfo!.version, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
