import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/modelClass/myUserListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/WeeklyAdminScreen/WeeklyAdminController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constant/color.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'dart:math' as math;

class WeeklyAdminScreen extends BaseView<WeeklyAdminController> {
  const WeeklyAdminScreen({Key? key}) : super(key: key);

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
          headerTitle: "% Weekly Admin",
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
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: AppColors().bgColor,
        ),
        child: Column(
          children: [
            selectUserdropDownView(),
            btnField(),
            balanceView(),
            Expanded(
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  clipBehavior: Clip.hardEdge,
                  itemCount: controller.arrUserListData.length,
                  controller: controller.listcontroller,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return userListView(context, index);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectUserdropDownView() {
    return Container(
      height: 6.5.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().grayLightLine,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3)),
      padding: const EdgeInsets.only(right: 15),
      child: Obx(() {
        return Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              dropdownStyleData: DropdownStyleData(
                maxHeight: 300,
                decoration: BoxDecoration(
                  color: AppColors().grayBg,
                ),
              ),
              // alignment: AlignmentDirectional.center,
              iconStyleData: IconStyleData(
                  icon: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                  openMenuIcon: AnimatedRotation(
                    turns: 0.5,
                    duration: const Duration(milliseconds: 400),
                    child: Image.asset(
                      AppImages.arrowDown,
                      width: 20,
                      height: 20,
                      color: AppColors().fontColor,
                    ),
                  )),
              hint: Text(
                'Select User',
                maxLines: 1,
                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
              ),
              items: controller.arrUserDataDropDown
                  .map((UserData item) => DropdownMenuItem<String>(
                        value: item.userName ?? "",
                        child: Text(
                          item.userName ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: Appfonts.family1Medium,
                            color: AppColors().DarkText,
                          ),
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return controller.arrUserDataDropDown
                    .map((UserData item) => DropdownMenuItem<String>(
                          value: item.userName ?? "",
                          child: Text(
                            item.userName ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: Appfonts.family1Medium,
                              color: AppColors().DarkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: controller.selectStatusdropdownValue.value.isNotEmpty ? controller.selectStatusdropdownValue.value : null,
              onChanged: (String? value) {
                controller.selectStatusdropdownValue.value = value.toString();
                controller.update();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                // height: 54,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 54,
              ),

              dropdownSearchData: DropdownSearchData(
                searchController: controller.searchtextEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 60,
                  padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
                  child: CustomTextField(
                    type: 'Remark',
                    keyBoardType: TextInputType.text,
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: "",
                    placeHolderMsg: "Search User",
                    emptyFieldMsg: "",
                    controller: controller.searchtextEditingController,
                    focus: controller.searchtextEditingFocus,
                    isSecure: false,
                    borderColor: AppColors().grayLightLine,
                    keyboardButtonType: TextInputAction.done,
                    maxLength: 64,
                    prefixIcon: Image.asset(
                      AppImages.searchIcon,
                      height: 24,
                      width: 24,
                    ),
                    sufixIcon: Container(
                      child: GestureDetector(
                        onTap: () {
                          controller.searchtextEditingController.clear();
                        },
                        child: Image.asset(
                          AppImages.crossIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  controller.searchtextEditingController.clear();
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Widget btnField() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Search",
              textSize: 16,
              onPress: () {},
              bgColor: AppColors().blueColor,
              isFilled: true,
              textColor: AppColors().whiteColor,
              isTextCenter: true,
              isLoading: false,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            // flex: 1,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Reset",
              textSize: 16,
              onPress: () {},
              bgColor: AppColors().grayLightLine,
              isFilled: true,
              textColor: AppColors().DarkText,
              isTextCenter: true,
              isLoading: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget balanceView() {
    return Container(
      padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w, bottom: 2.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Realised P&L", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().DarkText)),
                        Transform.rotate(
                          angle: math.pi,
                          child: Image.asset(
                            AppImages.arrowup,
                            height: 18,
                            width: 18,
                            color: AppColors().fontColor,
                          ),
                          // alignment: Alignment.center,
                        ),
                      ],
                    ),
                    Text("30050.00", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("M2M P&L", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().DarkText)),
                        Transform.rotate(
                          angle: math.pi,
                          child: Image.asset(
                            AppImages.arrowup,
                            height: 18,
                            width: 18,
                            color: AppColors().fontColor,
                          ),
                          // alignment: Alignment.center,
                        ),
                      ],
                    ),
                    Text("30050.00", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Total P&L", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().DarkText)),
                        Transform.rotate(
                          angle: math.pi,
                          child: Image.asset(
                            AppImages.arrowup,
                            height: 18,
                            width: 18,
                            color: AppColors().fontColor,
                          ),
                          // alignment: Alignment.center,
                        ),
                      ],
                    ),
                    Text("30050.00", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 1,
            width: 100.w,
            color: AppColors().grayLightLine,
          )
        ],
      ),
    );
  }

  Widget userListView(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(top: 0.w, left: 5.w, right: 5.w, bottom: 2.w),
      child: ExpansionWidget(
          initiallyExpanded: false,
          titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
            return InkWell(
                onTap: () => toogleFunction(animated: true),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.userImage,
                                  height: 12,
                                  width: 12,
                                  color: AppColors().fontColor,
                                ),
                                const SizedBox(
                                  width: 1,
                                ),
                                Text(controller.arrUserListData[index].userName ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                const Spacer(),
                                Transform.rotate(
                                  angle: math.pi * animationValue,
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    AppImages.arrowDown,
                                    height: 18,
                                    width: 18,
                                    color: AppColors().fontColor,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Realised P&L", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                                      Text(controller.arrUserListData[index].releasePL ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().blueColor)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("M2M P&L", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                                      Text(controller.arrUserListData[index].MMPL ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().blueColor)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Total P&L", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                                      Text(controller.arrUserListData[index].totalPL ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().blueColor)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (isExpaned == false)
                              const SizedBox(
                                height: 5,
                              ),
                            isExpaned == false
                                ? Container(
                                    height: 1,
                                    width: 100.w,
                                    color: AppColors().grayLightLine,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          },
          content: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Admin Profit", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                          Text(controller.arrUserListData[index].adminProfit ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().blueColor)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Admin Brokerage", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                          Text(controller.arrUserListData[index].adminBrokerage ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().blueColor)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Total Admin Profit", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                          Text(controller.arrUserListData[index].totalAdminProfil ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().blueColor)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 1,
                  width: 100.w,
                  color: AppColors().grayLightLine,
                ),
              ],
            ),
          )),
    );
  }
}
