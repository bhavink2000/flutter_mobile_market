import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/navigation/routename.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/GroupQuantitySettingScreen/groupQuantitySettingController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../constant/commonWidgets.dart';

class GroupQuantityScreen extends BaseView<GroupQuantityController> {
  const GroupQuantityScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: appNavigationBar(
        isBackDisplay: true,
        onBackButtonPress: () {
          Get.back();
        },
        isTrailingDisplay: true,
        trailingIcon: Image.asset(
          AppImages.settingUser6,
          width: 20,
          height: 20,
          color: AppColors().DarkText,
        ),
        onTrailingButtonPress: () {
          Get.offAndToNamed(RouterName.brkSettingScreen, arguments: {"userId": controller.selectedUserId});
        },
        headerTitle: "Group Quantity Settings",
        backGroundColor: AppColors().headerBgColor,
      ),
      backgroundColor: AppColors().bgColor,
      body: controller.isApiCallRunning
          ? displayIndicator()
          : controller.isApiCallRunning == false && controller.arrGroupSetting.isEmpty
              ? dataNotFoundView("Data not found")
              : Column(
                  children: [
                    Container(
                      height: 3.h,
                      color: AppColors().whiteColor,
                      child: Row(
                        children: [
                          // Container(
                          //   width: 30,
                          // ),
                          listTitleContent(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          clipBehavior: Clip.hardEdge,
                          itemCount: controller.arrGroupSetting.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return groupContent(context, index);
                          }),
                    ),
                  ],
                ),
    );
  }

  Widget groupContent(BuildContext context, int index) {
    var groupValue = controller.arrGroupSetting[index];
    return GestureDetector(
      onTap: () {
        // controller.selectedScriptIndex = index;
        controller.update();
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            valueBox(groupValue.groupName ?? "", 30.w, index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText, index),
            valueBox(
              shortFullDateTime(groupValue.updatedAt!),
              53.w,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
            valueBox("", 15.w, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, Colors.transparent, index,
                isImage: true, strImage: AppImages.viewIcon, onClickImage: () {
              Get.toNamed(RouterName.quantitySettingScreen,
                  arguments: {"groupId": groupValue.groupId!, "userId": controller.selectedUserId});
            }),
          ],
        ),
      ),
    );
  }

  Widget listTitleContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // titleBox("", 0),

        titleBox("Group", width: 30.w),
        titleBox("Last Updated", width: 53.w),
        titleBox("View", width: 17.w),
      ],
    );
  }
}
