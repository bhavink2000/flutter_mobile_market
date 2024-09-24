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
import 'package:market/screens/mainTab/settingTab/P&LScreen/PLScreenController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constant/color.dart';

class PLScreen extends BaseView<PLController> {
  const PLScreen({Key? key}) : super(key: key);

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
          headerTitle: "P&L",
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
              selectUserdropDownView(),
              btnField(),
              userSelectedView(),
              Expanded(
                child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    clipBehavior: Clip.hardEdge,
                    itemCount: controller.arrUserData.length,
                    controller: controller.listcontroller,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return userlistView(context, index);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectUserdropDownView() {
    return Container(
      height: 6.5.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
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
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: Appfonts.family1Medium,
                    color: AppColors().lightText,
                    overflow: TextOverflow.ellipsis),
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
              value: controller.selectedUserdropdownValue.value.isNotEmpty ? controller.selectedUserdropdownValue.value : null,
              onChanged: (String? value) {
                controller.selectedUserdropdownValue.value = value.toString();
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
                    keyboardButtonType: TextInputAction.next,
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
              title: "View",
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
              title: "Clear",
              textSize: 16,
              onPress: () {
                controller.selectedUserdropdownValue.value = "";
              },
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

  Widget userSelectedView() {
    return Container(
      height: 6.5.h,
      // margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.w),
      decoration: BoxDecoration(
          border: Border.all(
        color: AppColors().grayLightLine,
        width: 1.5,
      )),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
              )),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("User Name",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  Image.asset(
                    AppImages.arrowup,
                    height: 18,
                    width: 18,
                    color: AppColors().fontColor,
                  ),
                ],
              )),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
              )),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Realised P&L",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  Text("0.00",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                ],
              )),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
              )),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("M2M P&L",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  Text("0.00",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                ],
              )),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      // right: BorderSide(
                      //   color: AppColors().grayLightLine,
                      //   width: 1.5,
                      // ),
                      )),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  Text("0.00",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget userlistView(BuildContext context, int index) {
    return Container(
      height: 6.5.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(
          color: AppColors().grayLightLine,
          width: 1.5,
        ),
        right: BorderSide(
          color: AppColors().grayLightLine,
          width: 1.5,
        ),
        bottom: BorderSide(
          color: AppColors().grayLightLine,
          width: 1.5,
        ),
      )),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
              )),
              child: Center(
                  child: Text(controller.arrUserData[index].userName ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
              )),
              child: Center(
                  child: Text(controller.arrUserData[index].releasedPL ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
              )),
              child: Center(
                  child: Text(controller.arrUserData[index].MMPL ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      // right: BorderSide(
                      //   color: AppColors().grayLightLine,
                      //   width: 1.5,
                      // ),
                      )),
              child: Center(
                  child: Text(controller.arrUserData[index].total ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor))),
            ),
          ),
        ],
      ),
    );
  }
}
