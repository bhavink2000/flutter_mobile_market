import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/modelClass/myUserListModelClass.dart';
import 'package:market/modelClass/settelementListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/SettlementReportScreen/SettlementReportScreenController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constant/color.dart';
import '../../../../constant/const_string.dart';

class SettlementReportScreen extends BaseView<SettlementReportController> {
  const SettlementReportScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
          },
          headerTitle: "Settlements Report",
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
          child: controller.isApiCallFirstTime
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors().bgColor,
                    color: AppColors().blueColor,
                    strokeWidth: 2,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // DatedropDownView(),
                      // if (controller.selectdatedropdownValue == "Custom Period") DatebtnField(),
                      SizedBox(
                        height: 3.w,
                      ),

                      profitLabelView(),
                      tableHeaderView(),
                      GrandTotalView(isFromProfit: true),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          clipBehavior: Clip.hardEdge,
                          itemCount: controller.arrProfitList.length,
                          controller: controller.listcontroller,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return PLView(context, index, controller.arrProfitList[index]);
                          }),
                      lossLabelView(),
                      tableHeaderView(),
                      GrandTotalView(isFromProfit: false),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          clipBehavior: Clip.hardEdge,
                          itemCount: controller.arrLossList.length,
                          controller: controller.listcontroller,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return PLView(context, index, controller.arrLossList[index]);
                          }),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
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
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
              horizontal: 5.w,
              // vertical: 31.h,
            ),
            content: Column(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
                Container(
                  padding: EdgeInsets.all(20),
                  height: 29.h,
                  decoration: BoxDecoration(color: AppColors().bgColor, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: 1.w,
                      // ),
                      searchView(),
                      SizedBox(
                        height: 3.w,
                      ),
                      selectUserdropDownView(),
                      SizedBox(
                        height: 3.w,
                      ),
                      btnView(),
                    ],
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
              ],
            )));
  }

  Widget searchView() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors().bgColor,
      ),
      child: CustomTextField(
        type: 'Search',
        keyBoardType: TextInputType.text,
        isEnabled: true,
        isOptional: false,
        onChange: (value) {
          controller.getSettelementList();
        },
        inValidMsg: AppString.emptyServer,
        isNoNeededCapital: true,
        placeHolderMsg: "Search",
        labelMsg: "Search",
        emptyFieldMsg: AppString.emptyServer,
        controller: controller.searchtextEditingController,
        focus: controller.searchFocus,
        isSecure: false,
        keyboardButtonType: TextInputAction.search,
        maxLength: 64,
      ),
    );
  }

  Widget selectUserdropDownView() {
    return Container(
      height: 6.5.h,
      // margin: EdgeInsets.symmetric(horizontal: 5.w),
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
            child: DropdownButton2<UserData>(
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
                  .map((UserData item) => DropdownMenuItem<UserData>(
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
                    .map((UserData item) => DropdownMenuItem<UserData>(
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
              value: controller.selectedUser.value.userId != null ? controller.selectedUser.value : null,
              onChanged: (UserData? value) {
                controller.selectedUser.value = value!;
                controller.update();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                // height: 54,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 54,
              ),

              // dropdownSearchData: DropdownSearchData(
              //   searchController: controller.searchtextEditingController,
              //   searchInnerWidgetHeight: 50,
              //   searchInnerWidget: Container(
              //     height: 60,
              //     padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
              //     child: CustomTextField(
              //       type: 'Remark',
              //       keyBoardType: TextInputType.text,
              //       isEnabled: true,
              //       isOptional: false,
              //       inValidMsg: "",
              //       placeHolderMsg: "Search User",
              //       emptyFieldMsg: "",
              //       controller: controller.searchtextEditingController,
              //       focus: controller.searchFocus,
              //       isSecure: false,
              //       borderColor: AppColors().grayLightLine,
              //       keyboardButtonType: TextInputAction.next,
              //       maxLength: 64,
              //       prefixIcon: Image.asset(
              //         AppImages.searchIcon,
              //         height: 24,
              //         width: 24,
              //       ),
              //       sufixIcon: Container(
              //         child: GestureDetector(
              //           onTap: () {
              //             controller.searchtextEditingController.clear();
              //           },
              //           child: Image.asset(
              //             AppImages.crossIcon,
              //             height: 20,
              //             width: 20,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              //   searchMatchFn: (item, searchValue) {
              //     return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
              //   },
              // ),
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

  Widget btnView() {
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
              onPress: () {
                Get.back();
                controller.getSettelementList(isFrom: 1);
              },
              bgColor: AppColors().blueColor,
              isFilled: true,
              textColor: AppColors().whiteColor,
              isTextCenter: true,
              isLoading: controller.isApiCallFromSearch,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            // flex: 1,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().blueColor,
              title: "Reset",
              textSize: 16,
              onPress: () {
                Get.back();
                controller.selectStatusdropdownValue.value = "";
                controller.selectdatedropdownValue.value = "";
                controller.searchtextEditingController.clear();
                controller.selectedUser.value = UserData();
                controller.fromDate = "";
                controller.toDate = "";
                controller.getSettelementList(isFrom: 2);
              },
              bgColor: AppColors().grayLightLine,
              isFilled: true,
              textColor: AppColors().DarkText,
              isTextCenter: true,
              isLoading: controller.isApiCallFromReset,
            ),
          ),
        ],
      ),
    );
  }

  Widget profitLabelView() {
    return Container(
      width: 100.w,
      height: 6.5.h,
      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors().blueColor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 2.5.w,
          ),
          Text("Profit", style: TextStyle(fontSize: 18, fontFamily: Appfonts.family1SemiBold, color: AppColors().whiteColor)),
        ],
      ),
    );
  }

  Widget lossLabelView() {
    return Container(
      width: 100.w,
      height: 6.5.h,
      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors().redColor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 2.5.w,
          ),
          Text("Loss", style: TextStyle(fontSize: 18, fontFamily: Appfonts.family1SemiBold, color: AppColors().whiteColor)),
        ],
      ),
    );
  }

  Widget tableHeaderView() {
    return Container(
      height: 6.5.h,
      // margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      margin: EdgeInsets.only(left: 1.w, right: 1.w),
      decoration: BoxDecoration(
          border: Border.all(
        color: AppColors().grayLightLine,
        width: 1.5,
      )),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Username", textAlign: TextAlign.left, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  ),
                ),
                Container(
                    height: 7.h,
                    decoration: BoxDecoration(
                        border: Border(
                      right: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                    ))),
              ],
            ),
          ),
          Container(
            width: 18.w,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text("P&L", textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          Container(
            width: 18.w,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text("BRK", textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          Container(
            width: 18.w,
            decoration: const BoxDecoration(border: Border()),
            child: Center(child: Text("Total", textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
        ],
      ),
    );
  }

  Widget GrandTotalView({bool isFromProfit = true}) {
    return Container(
      height: 6.5.h,
      // margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      margin: EdgeInsets.only(left: 1.w, right: 1.w),
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
              ))),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(isFromProfit ? "Net Profit" : "Net Loss", textAlign: TextAlign.left, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  ),
                ),
                Container(
                    height: 7.h,
                    decoration: BoxDecoration(
                        border: Border(
                      right: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                    ))),
              ],
            ),
          ),
          Container(
            width: 18.w,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(
                child: Text(isFromProfit ? controller.totalValues!.plProfitGrandTotal.toStringAsFixed(2) : controller.totalValues!.plLossGrandTotal.toStringAsFixed(2), textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          Container(
            width: 18.w,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(
                child: Text(isFromProfit ? controller.totalValues!.brkProfitGrandTotal.toStringAsFixed(2) : controller.totalValues!.brkLossGrandTotal.toStringAsFixed(2), textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          Container(
            width: 18.w,
            decoration: const BoxDecoration(border: Border()),
            child:
                Center(child: Text(isFromProfit ? controller.totalValues!.profitGrandTotal.toStringAsFixed(2) : controller.totalValues!.LossGrandTotal.toStringAsFixed(2), textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
        ],
      ),
    );
  }

  Widget PLView(BuildContext context, int index, Profit value) {
    return Container(
      height: 4.5.h,
      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0),
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
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(value.displayName ?? "", textAlign: TextAlign.left, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  ),
                ),
                Container(
                    height: 7.h,
                    decoration: BoxDecoration(
                        border: Border(
                      right: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                    ))),
              ],
            ),
          ),
          Container(
            width: 18.w,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text(value.profitLoss!.toStringAsFixed(2), textAlign: TextAlign.right, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          Container(
            width: 18.w,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text(value.brokerageTotal! < 0 ? (value.brokerageTotal! * -1).toStringAsFixed(2) : value.brokerageTotal!.toStringAsFixed(2), textAlign: TextAlign.right, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          Container(
            width: 18.w,
            // decoration: BoxDecoration(border: Border()),
            child: Center(child: Text((value.profitLoss! - value.brokerageTotal!).toStringAsFixed(2), textAlign: TextAlign.right, style: TextStyle(fontSize: 11, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
        ],
      ),
    );
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: 'Select From Date',
      cancelText: 'Cancel',
      confirmText: 'Select To Date',
    );

    if (picked != null) {
      // Format the DateTime to display only the date portion
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      print(formattedDate);
      controller.fromDate = formattedDate;
      controller.update();
      _selectToDate(context, DateTime.parse(controller.fromDate!));
    }
  }

  Future<void> _selectToDate(BuildContext context, DateTime fromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate, // Set the initial date to the selected "From Date"
      firstDate: fromDate, // Set the first selectable date to the selected "From Date"
      lastDate: DateTime.now(),
      helpText: 'Select To Date',
      cancelText: 'Cancel',
      confirmText: 'OK',
    );
    if (picked != null) {
      // Format the DateTime to display only the date portion
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      print(formattedDate);
      controller.toDate = formattedDate;
      controller.update();
    }
  }
}
