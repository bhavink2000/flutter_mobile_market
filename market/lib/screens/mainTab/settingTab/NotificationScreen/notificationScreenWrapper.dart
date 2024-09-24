import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/screens/mainTab/settingTab/NotificationScreen/notificationScreenController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constant/color.dart';

import '../../../../constant/font_family.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../../main.dart';
import '../../../BaseViewController/baseController.dart';
import '../../tabScreen/MainTabController.dart';

class SettingNotificationScreen extends BaseView<SettingNotificationController> {
  const SettingNotificationScreen({Key? key}) : super(key: key);

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
          headerTitle: "Notification Settings",
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
      backgroundColor: AppColors().bgColor,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: AppColors().bgColor,
        ),
        child: Column(
          children: [
            marketOrderSwitchView(),
            lineView(),
            pendingOrderSwitchView(),
            lineView(),
            executePendingOrderSwitchView(),
            lineView(),
            DeletePendingOrderSwitchView(),
            lineView(),
            TreadingSoundSwitchView(),
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

  Widget marketOrderSwitchView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text("Market Order", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Container(
              height: 23, //set desired REAL HEIGHT
              width: 36,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: isMarketOrderOn ? AppColors().blueColor : AppColors().lightText,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Transform.scale(
                transformHitTests: false,
                scale: .6,
                child: CupertinoSwitch(
                  value: isMarketOrderOn,
                  activeColor: AppColors().whiteColor,
                  trackColor: AppColors().whiteColor,
                  thumbColor: isMarketOrderOn ? AppColors().blueColor : AppColors().switchColor,
                  onChanged: (bool value) async {
                    isMarketOrderOn = !isMarketOrderOn;
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

  Widget pendingOrderSwitchView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text("Pending Order", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Container(
              height: 23, //set desired REAL HEIGHT
              width: 36,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: isPendingOrderOn ? AppColors().blueColor : AppColors().lightText,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Transform.scale(
                transformHitTests: false,
                scale: .6,
                child: CupertinoSwitch(
                  value: isPendingOrderOn,
                  activeColor: AppColors().whiteColor,
                  trackColor: AppColors().whiteColor,
                  thumbColor: isPendingOrderOn ? AppColors().blueColor : AppColors().switchColor,
                  onChanged: (bool value) async {
                    isPendingOrderOn = !isPendingOrderOn;
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

  Widget executePendingOrderSwitchView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text("Execute Pending Order", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Container(
              height: 23, //set desired REAL HEIGHT
              width: 36,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: isExecutePendingOrderOn ? AppColors().blueColor : AppColors().lightText,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Transform.scale(
                transformHitTests: false,
                scale: .6,
                child: CupertinoSwitch(
                  value: isExecutePendingOrderOn,
                  activeColor: AppColors().whiteColor,
                  trackColor: AppColors().whiteColor,
                  thumbColor: isExecutePendingOrderOn ? AppColors().blueColor : AppColors().switchColor,
                  onChanged: (bool value) async {
                    isExecutePendingOrderOn = !isExecutePendingOrderOn;
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

  Widget DeletePendingOrderSwitchView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text("Delete Pending Order", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Container(
              height: 23, //set desired REAL HEIGHT
              width: 36,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: isDeletePendingOrderOn ? AppColors().blueColor : AppColors().lightText,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Transform.scale(
                transformHitTests: false,
                scale: .6,
                child: CupertinoSwitch(
                  value: isDeletePendingOrderOn,
                  activeColor: AppColors().whiteColor,
                  trackColor: AppColors().whiteColor,
                  thumbColor: isDeletePendingOrderOn ? AppColors().blueColor : AppColors().switchColor,
                  onChanged: (bool value) async {
                    isDeletePendingOrderOn = !isDeletePendingOrderOn;
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

  Widget TreadingSoundSwitchView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text("Treading Sound", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Container(
              height: 23, //set desired REAL HEIGHT
              width: 36,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: isTreadingSoundOn ? AppColors().blueColor : AppColors().lightText,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Transform.scale(
                transformHitTests: false,
                scale: .6,
                child: CupertinoSwitch(
                  value: isTreadingSoundOn,
                  activeColor: AppColors().whiteColor,
                  trackColor: AppColors().whiteColor,
                  thumbColor: isTreadingSoundOn ? AppColors().blueColor : AppColors().switchColor,
                  onChanged: (bool value) async {
                    isTreadingSoundOn = !isTreadingSoundOn;
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
          controller.updateNotificationSettings();
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
