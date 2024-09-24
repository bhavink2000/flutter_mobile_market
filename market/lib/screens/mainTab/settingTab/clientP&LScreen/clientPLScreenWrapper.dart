import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/modelClass/m2mProfitLossDataModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/clientP&LScreen/ClientPLScreenController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:math' as math;
import '../../../../../constant/color.dart';
import '../../../../constant/const_string.dart';

class ClientPLScreen extends BaseView<ClientPLController> {
  const ClientPLScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
          },
          headerTitle: "M2M P&L",
          isTrailingDisplay: true,
          trailingIcon: SizedBox(
            width: 45,
            child: Image.asset(
              AppImages.filterIcon,
              width: 25,
              height: 25,
              color: AppColors().blueColor,
            ),
          ),
          onTrailingButtonPress: () {
            filterPopupDialog();
          },
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
              totalExpandableView(),
              SizedBox(
                height: 1.h,
              ),
              // userDataListView(),
              Expanded(
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    clipBehavior: Clip.hardEdge,
                    itemCount: controller.arrPlList.length,
                    controller: controller.listcontroller,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return userDataListView(context, index);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  filterPopupDialog({String? message, String? subMessage, Function? CancelClick, Function? DeleteClick}) {
    showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
            titlePadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: AppColors().bgColor,
            surfaceTintColor: AppColors().bgColor,
            insetPadding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 34.h,
            ),
            content: Column(
              children: [
                selectUserdropDownView(),
                btnField(),
              ],
            )));
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
            child: DropdownButton2<m2mProfitLossData>(
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
                  .map((m2mProfitLossData item) => DropdownMenuItem<m2mProfitLossData>(
                        value: item,
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
                    .map((m2mProfitLossData item) => DropdownMenuItem<m2mProfitLossData>(
                          value: item,
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
              value: controller.selectedDropdownValue.value.userName != null ? controller.selectedDropdownValue.value : null,
              onChanged: (m2mProfitLossData? value) {
                var userIndex = controller.arrUserDataDropDown.firstWhere((element) => element.userName == value!.userName!);
                controller.selectedUserId = userIndex.userId!;
                controller.selectedDropdownValue.value = value!;
                controller.getProfitLossList(value.userName!);
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
                  return item.value!.userName!.toLowerCase().contains(searchValue.toLowerCase());
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
              onPress: () {
                Get.back();
              },
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
                Get.back();
                controller.selectedDropdownValue.value = m2mProfitLossData();
                controller.selectedUserId = "";
                controller.getProfitLossList("");
                controller.update();
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

  Widget totalExpandableView() {
    return Container(
      margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4.w),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().blueColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3)),
      child: ExpansionWidget(
          initiallyExpanded: false,
          titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
            return InkWell(
                onTap: () => toogleFunction(animated: true),
                child: Container(
                  child: Row(
                    children: [
                      Text("Total", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                      const Spacer(),
                      Text(controller.totalPLvalue.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Appfonts.family1Medium,
                              color: controller.totalPLvalue > 0
                                  ? AppColors().blueColor
                                  : controller.totalPLvalue < 0
                                      ? AppColors().redColor
                                      : AppColors().DarkText)),
                      const Spacer(),
                      Transform.rotate(
                        angle: math.pi * animationValue,
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppImages.arrowDown,
                          height: 20,
                          width: 20,
                          color: AppColors().fontColor,
                        ),
                      )
                    ],
                  ),
                ));
          },
          content: Container(
            child: Column(
              children: [
                Container(
                  height: 38,
                  color: AppColors().contentBg,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("M2M P&L", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                      const Spacer(),
                      Text(controller.totalPLvalue.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: Appfonts.family1SemiBold,
                              color: controller.totalPLvalue > 0
                                  ? AppColors().blueColor
                                  : controller.totalPLvalue < 0
                                      ? AppColors().redColor
                                      : AppColors().DarkText)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Realised P&L", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                      const Spacer(),
                      Text("0.00", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1SemiBold, color: AppColors().blueColor)),
                    ],
                  ),
                ),
                // Container(
                //   height: 38,
                //   color: AppColors().contentBg,
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Text("M2M % Net P&L",
                //           style: TextStyle(
                //               fontSize: 12,
                //               fontFamily: Appfonts.family1Regular,
                //               color: AppColors().DarkText)),
                //       const Spacer(),
                //       Text("100.00",
                //           style: TextStyle(
                //               fontSize: 12,
                //               fontFamily: Appfonts.family1SemiBold,
                //               color: AppColors().blueColor)),
                //     ],
                //   ),
                // ),
              ],
            ),
          )),
    );
  }

  Widget userDataListView(BuildContext context, int index) {
    var plObj = controller.arrPlList[index];
    return GestureDetector(
      onTap: () {
        // Get.toNamed(RouterName.UserListDetailsScreen);
        // controller.update();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Center(
                  child: Text(controller.arrPlList[index].userName ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 30.w,
                  child: Row(
                    children: [
                      Text(plObj.roleName ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                      Text(" -> ", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().redColor)),
                      Text("${plObj.role == UserRollList.master ? plObj.profitAndLossSharing.toString() : plObj.profitAndLossSharingDownLine.toString()}%", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                    ],
                  ),
                ),
                Spacer(),
                Text(plObj.totalProfitLossValue.toStringAsFixed(2), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                Spacer(),
                Text(plObj.totalProfitLossValue == 0.00 ? "0.00" : ((plObj.totalProfitLossValue * (plObj.role == UserRollList.master ? plObj.profitAndLossSharing! : plObj.profitAndLossSharingDownLine!) / 100) * -1).toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: Appfonts.family1Medium,
                      color: (plObj.totalProfitLossValue * (plObj.role == UserRollList.master ? plObj.profitAndLossSharing! : plObj.profitAndLossSharingDownLine!) / 100) > 0
                          ? AppColors().redColor
                          : (plObj.totalProfitLossValue * (plObj.role == UserRollList.master ? plObj.profitAndLossSharing! : plObj.profitAndLossSharingDownLine!) / 100) < 0
                              ? AppColors().blueColor
                              : AppColors().DarkText,
                    )),
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
