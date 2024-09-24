import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/modelClass/settingListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/UserListDetailsScreen/SharingDetailScreen/sharingDetailController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SharingDetailsScreen extends BaseView<SharingDetailsController> {
  const SharingDetailsScreen({Key? key}) : super(key: key);

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
          headerTitle: "Sharing Details",
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
        child: controller.isUserApiCallRunning
            ? Container()
            : Column(
                children: [
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  clientSelectedView(context, sharingDetailsItemModel(amountPer: "", names: "P & L Sharing", isImage: false), 0),
                  clientSelectedView(
                      context,
                      sharingDetailsItemModel(
                          amountPer: controller.selectedUserData!.profitAndLossSharing!.toString() + "%",
                          names: "Admin",
                          isImage: false),
                      1),
                  clientSelectedView(
                      context,
                      sharingDetailsItemModel(
                          amountPer: controller.selectedUserData!.profitAndLossSharingDownLine!.toString() + "%",
                          names: "Master ${controller.selectedUserData!.userName}",
                          isImage: false),
                      2),

                  clientSelectedView(context, sharingDetailsItemModel(amountPer: "", names: "Brk Sharing", isImage: false), 0),
                  clientSelectedView(
                      context,
                      sharingDetailsItemModel(
                          amountPer: controller.selectedUserData!.brkSharing!.toString() + "%", names: "Admin", isImage: false),
                      1),
                  clientSelectedView(
                      context,
                      sharingDetailsItemModel(
                          amountPer: controller.selectedUserData!.brkSharingDownLine!.toString() + "%",
                          names: "Master ${controller.selectedUserData!.userName}",
                          isImage: false),
                      2),
                  SizedBox(
                    height: 3.h,
                  )
                ],
              ),
      ),
    );
  }

  Widget clientSelectedView(BuildContext context, sharingDetailsItemModel itemData, int itemIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            height: 7.h,
            decoration: BoxDecoration(
                border: Border(
              top: itemIndex == 0
                  ? BorderSide(
                      color: AppColors().grayLightLine,
                      width: 1.5,
                    )
                  : const BorderSide(
                      color: Colors.transparent,
                      width: 1.5,
                    ),
            )),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 7.h,
                    decoration: BoxDecoration(
                        border: Border(
                      left: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                      bottom: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                      right: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(itemData.names,
                            style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                        if (itemData.isImage == true)
                          SizedBox(
                            width: 40,
                            child: Image.asset(
                              AppImages.arrowup,
                              height: 21,
                              width: 21,
                              color: AppColors().fontColor,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      // top: BorderSide(
                      //   color: AppColors().grayLightLine,
                      //   width: 1.5,
                      // ),
                      right: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                      bottom: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                    )),
                    child: Center(
                        child: Text(itemData.amountPer,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
