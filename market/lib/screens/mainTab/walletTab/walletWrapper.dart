import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant/color.dart';

import '../../../constant/assets.dart';
import '../../../customWidgets/appNavigationBar.dart';
import '../../BaseViewController/baseController.dart';
import '../tabScreen/MainTabController.dart';
import 'walletController.dart';

class walletScreen extends BaseView<walletController> {
  const walletScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: appNavigationBar(
          isTrailingDisplay: true,
          backGroundColor: AppColors().headerBgColor,
          trailingIcon: Image.asset(
            AppImages.notificationIcon,
            width: 25,
            height: 25,
            color: AppColors().fontColor,
          ),
          isMoreDisplay: true,
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
      body: Container(),
    );
  }
}
