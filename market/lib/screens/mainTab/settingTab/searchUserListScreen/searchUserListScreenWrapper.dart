import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appNavigationBar.dart';

import 'package:market/screens/mainTab/settingTab/SearchUserListScreen/SearchUserListScreenController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/userDetailsController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constant/color.dart';
import '../../../../constant/const_string.dart';
import '../../../../navigation/routename.dart';
import '../../../BaseViewController/baseController.dart';

class SearchUserListScreen extends BaseView<SearchUserListController> {
  const SearchUserListScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          isTrailingDisplay: true,
          trailingIcon: SizedBox(
            width: 45,
          ),
          headerTitle: "Search User",
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
      body: Column(
        children: [
          userView(),
        ],
      ),
    );
  }

  Widget userView() {
    return Expanded(
      child: Container(
        // height: 87.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: AppColors().bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Get.toNamed(RouterName.mainTab);
                  // arguments: {"onSelectedCallBack": controller.getSelectedScripts});
                },
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors().bgColor,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.searchIcon,
                              width: 20,
                              height: 20,
                              color: AppColors().blueColor,
                            ),
                            SizedBox(
                              width: 70.w,
                              child: TextField(
                                onTapOutside: (event) {
                                  // FocusScope.of(context).unfocus();
                                },
                                textCapitalization: TextCapitalization.sentences,
                                controller: controller.textController,
                                focusNode: controller.textFocus,
                                keyboardType: TextInputType.text,
                                minLines: 1,
                                maxLines: 1,
                                // onChanged: (value) {
                                //   controller.arrUserListData.clear();
                                //   controller.arrUserListData.addAll(controller.arrMainScript);
                                //   controller.arrUserListData.retainWhere((scriptObj) {
                                //     return scriptObj.userName!.toLowerCase().contains(value.toLowerCase());
                                //   });
                                //   controller.update();
                                // },
                                textInputAction: TextInputAction.search,
                                onEditingComplete: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  controller.getUserList();
                                },
                                style: TextStyle(fontSize: 16.0, color: AppColors().fontColor, fontFamily: Appfonts.family1Medium),
                                decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.w), borderSide: BorderSide.none),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                    hintStyle: TextStyle(color: AppColors().placeholderColor),
                                    hintText: ""),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 100.w,
                        color: AppColors().grayLightLine,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: controller.isLoadingData
                      ? Container(
                          width: 30.w,
                          height: 30.h,
                          child: displayIndicator(),
                        )
                      : controller.arrSUserListData.isNotEmpty
                          ? ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              clipBehavior: Clip.hardEdge,
                              itemCount: controller.arrSUserListData.length,
                              controller: controller.listcontroller,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return userListView(context, index);
                              })
                          : Container(
                              child: Center(
                              child: Text(
                                "Data not found".tr,
                                style: TextStyle(fontSize: 15, fontFamily: Appfonts.family1Regular, color: AppColors().fontColor),
                              ),
                            ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget userListView(BuildContext, int index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouterName.UserListDetailsScreen, arguments: {"userId": controller.arrSUserListData[index].userId, "roll": controller.arrSUserListData[index].role});
        if (Get.isRegistered<UserDetailsController>()) {
          Get.find<UserDetailsController>().onInit();
        }
        controller.update();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.userImage,
                            width: 10,
                            height: 10,
                            color: AppColors().fontColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Center(
                            child: Text(controller.arrSUserListData[index].userName ?? "", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(color: AppColors().blueColor.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                          controller.arrSUserListData[index].role == UserRollList.master
                              ? "M"
                              : controller.arrSUserListData[index].role == UserRollList.user
                                  ? "C"
                                  : controller.arrSUserListData[index].role == UserRollList.broker
                                      ? "B"
                                      : "",
                          style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Regular, color: AppColors().blueColor)),
                    ),
                  ),
                  // Image.asset(
                  //   AppImages.userListImage,
                  //   width: 30,
                  //   height: 30,
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text("Credit : ${controller.arrSUserListData[index].credit ?? ""}", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                const Spacer(),
                Text("${controller.arrSUserListData[index].profitAndLossSharing ?? ""}%", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().redColor)),
                const SizedBox(
                  width: 7,
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              width: 100.w,
              color: AppColors().grayLightLine,
            )
          ],
        ),
      ),
    );
  }
}
