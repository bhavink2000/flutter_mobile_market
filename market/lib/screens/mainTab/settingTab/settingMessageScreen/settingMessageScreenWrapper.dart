import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/screens/mainTab/settingTab/SettingMessageScreen/SettingMessageScreenController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constant/color.dart';

import '../../../../constant/font_family.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../BaseViewController/baseController.dart';
import '../../tabScreen/MainTabController.dart';

class SettingMessageScreen extends BaseView<SettingMessageController> {
  const SettingMessageScreen({Key? key}) : super(key: key);

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
          headerTitle: "Messages",
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
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    clipBehavior: Clip.hardEdge,
                    itemCount: controller.arrMessageData.length,
                    controller: controller.listcontroller,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return messageListView(context, index);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget messageListView(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().grayLightLine,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          color: index % 2 == 1 ? AppColors().contentBg : AppColors().footerColor),
      child: Column(
        children: [
          Text(
            controller.arrMessageData[index].text ?? "",
            style: TextStyle(
              fontSize: 14,
              fontFamily: Appfonts.family1Medium,
              color: AppColors().DarkText,
              // overflow: TextOverflow.ellipsis
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                controller.arrMessageData[index].date ?? "",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: Appfonts.family1Regular,
                  color: AppColors().lightText,
                  // overflow: TextOverflow.ellipsis
                ),
              ),
              const Spacer(),
              Text(
                controller.arrMessageData[index].time ?? "",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: Appfonts.family1Regular,
                  color: AppColors().lightText,
                  // overflow: TextOverflow.ellipsis
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
