import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/main.dart';
import 'package:market/screens/mainTab/settingTab/rejectionLogScreen/rejectionLogController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant/assets.dart';
import '../../../../constant/commonWidgets.dart';
import '../../../../constant/font_family.dart';
import '../../../../constant/utilities.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../BaseViewController/baseController.dart';

class RejectionLogScreen extends BaseView<RejectionLogController> {
  const RejectionLogScreen({Key? key}) : super(key: key);

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
        headerTitle: "Rejection Log",
        backGroundColor: AppColors().headerBgColor,
      ),
      body: GestureDetector(
        onTap: () {
          // controller.focusNode.requestFocus();
        },
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: mainContent(context),
              // child: BouncingScrollWrapper.builder(context, mainContent(context), dragWithMouse: true),
            ),
          ],
        ),
      ),
    );
  }

  filterPopupDialog({String? message, String? subMessage, Function? CancelClick, Function? DeleteClick}) {
    showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) => Obx(() {
              return AlertDialog(
                  titlePadding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  backgroundColor: AppColors().bgColor,
                  surfaceTintColor: AppColors().bgColor,
                  insetPadding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 18.h,
                  ),
                  content: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    filterContent(context),
                  ]));
            }));
  }

  Widget toAndFromDateBtnView() {
    return Container(
      width: 100.w,
      margin: EdgeInsets.only(top: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors().grayLightLine,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(3)),
              child: CustomButton(
                isEnabled: true,
                shimmerColor: AppColors().whiteColor,
                title: controller.startDate == "" ? "From Date" : controller.endDate.toString(),
                textSize: 14,
                onPress: () {
                  _selectFromDate(Get.context!);
                },
                bgColor: Colors.transparent,
                isFilled: true,
                textColor: AppColors().DarkText,
                isTextCenter: true,
                isLoading: false,
              ),
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            // flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors().grayLightLine,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(3)),
              child: CustomButton(
                isEnabled: true,
                shimmerColor: AppColors().whiteColor,
                title: controller.endDate == "" ? "To Date" : controller.endDate.toString(),
                textSize: 14,
                onPress: () {
                  // _selectToDate(Get.context!);
                  _selectToDate(Get.context!, DateTime.parse(controller.startDate));
                },
                bgColor: Colors.transparent,
                isFilled: true,
                textColor: AppColors().DarkText,
                isTextCenter: true,
                isLoading: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget weekSelectiondropDownView() {
    return Container(
      height: 6.5.h,
      margin: EdgeInsets.only(top: 2.h),
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
                'Please Select Week of Period',
                maxLines: 1,
                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
              ),
              items: controller.arrCustomDateSelection
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: Appfonts.family1Medium,
                            color: AppColors().DarkText,
                          ),
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return controller.arrCustomDateSelection
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
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
            ),
          ),
        );
      }),
    );
  }

  Widget filterContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          weekSelectiondropDownView(),
          if (controller.selectStatusdropdownValue == "Custom Period") toAndFromDateBtnView(),
          if (userData!.role == UserRollList.user)
            SizedBox(
              height: 15,
            ),
          if (userData!.role != UserRollList.user)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              height: 6.5.h,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors().grayLightLine,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(3)),
              // color: AppColors().whiteColor,
              padding: EdgeInsets.only(right: 10),
              child: Obx(() {
                return Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<UserData>(
                      isExpanded: true,
                      iconStyleData: IconStyleData(
                        icon: Image.asset(
                          AppImages.arrowDown,
                          height: 25,
                          width: 25,
                          color: AppColors().fontColor,
                        ),
                      ),
                      hint: Text(
                        'Select User',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: Appfonts.family1Medium,
                          color: AppColors().DarkText,
                        ),
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
                      value: controller.selectUserDropdownValue.value.userId != null ? controller.selectUserDropdownValue.value : null,
                      onChanged: (UserData? value) {
                        controller.selectUserDropdownValue.value = value!;
                        controller.update();
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        // height: 54,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 54,
                      ),
                      dropdownStyleData: const DropdownStyleData(maxHeight: 300),
                    ),
                  ),
                );
              }),
            ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 0),
            height: 6.5.h,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(3)),
            // color: AppColors().whiteColor,
            padding: const EdgeInsets.only(right: 10),
            child: Obx(() {
              return Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<ExchangeData>(
                    isExpanded: true,
                    iconStyleData: IconStyleData(
                      icon: Image.asset(
                        AppImages.arrowDown,
                        height: 25,
                        width: 25,
                        color: AppColors().fontColor,
                      ),
                    ),
                    hint: Text(
                      'Select Exchange',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: Appfonts.family1Medium,
                        color: AppColors().DarkText,
                      ),
                    ),
                    items: controller.arrExchangeList
                        .map((ExchangeData item) => DropdownMenuItem<ExchangeData>(
                              value: item,
                              child: Text(
                                item.name ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: Appfonts.family1Medium,
                                  color: AppColors().DarkText,
                                ),
                              ),
                            ))
                        .toList(),
                    selectedItemBuilder: (context) {
                      return controller.arrExchangeList
                          .map((ExchangeData item) => DropdownMenuItem<ExchangeData>(
                                value: item,
                                child: Text(
                                  item.name ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: Appfonts.family1Medium,
                                    color: AppColors().DarkText,
                                  ),
                                ),
                              ))
                          .toList();
                    },
                    value: controller.selectExchangedropdownValue.value.name != null ? controller.selectExchangedropdownValue.value : null,
                    onChanged: (ExchangeData? value) {
                      // setState(() {
                      controller.selectExchangedropdownValue.value = value!;
                      controller.selectedScriptDropDownValue.value = GlobalSymbolData();
                      controller.arrMainScript.clear();
                      controller.update();
                      controller.getScriptList();
                      // });
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      height: 40,
                      // width: 140,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              );
            }),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            height: 6.5.h,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(3)),
            // color: AppColors().whiteColor,
            padding: const EdgeInsets.only(right: 10),
            child: Obx(() {
              return Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<GlobalSymbolData>(
                    isExpanded: true,
                    iconStyleData: IconStyleData(
                      icon: Image.asset(
                        AppImages.arrowDown,
                        height: 25,
                        width: 25,
                        color: AppColors().fontColor,
                      ),
                    ),
                    hint: Text(
                      'Select Script',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: Appfonts.family1Medium,
                        color: AppColors().DarkText,
                      ),
                    ),
                    items: controller.arrMainScript
                        .map((GlobalSymbolData item) => DropdownMenuItem<GlobalSymbolData>(
                              value: item,
                              child: Text(
                                item.symbolTitle ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: Appfonts.family1Medium,
                                  color: AppColors().DarkText,
                                ),
                              ),
                            ))
                        .toList(),
                    selectedItemBuilder: (context) {
                      return controller.arrMainScript
                          .map((GlobalSymbolData item) => DropdownMenuItem<GlobalSymbolData>(
                                value: item,
                                child: Text(
                                  item.symbolTitle ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: Appfonts.family1Medium,
                                    color: AppColors().DarkText,
                                  ),
                                ),
                              ))
                          .toList();
                    },
                    value: controller.selectedScriptDropDownValue.value.symbolName != null ? controller.selectedScriptDropDownValue.value : null,
                    onChanged: (GlobalSymbolData? value) {
                      // setState(() {
                      controller.selectedScriptDropDownValue.value = value!;
                      controller.update();
                      // });
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      height: 40,
                      // width: 140,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 30.w,
                child: CustomButton(
                  isEnabled: true,
                  shimmerColor: AppColors().whiteColor,
                  title: "Reset",
                  textSize: 16,
                  onPress: () {
                    Get.back();
                    controller.startDate = "";
                    controller.endDate = "";
                    controller.selectUserDropdownValue.value = UserData();
                    controller.selectExchangedropdownValue.value = ExchangeData();
                    controller.selectedScriptDropDownValue.value = GlobalSymbolData();
                  },
                  bgColor: AppColors().grayLightLine,
                  isFilled: true,
                  textColor: AppColors().DarkText,
                  isTextCenter: true,
                  isLoading: false,
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              SizedBox(
                width: 30.w,
                child: CustomButton(
                  isEnabled: true,
                  shimmerColor: AppColors().whiteColor,
                  title: "Done",
                  textSize: 16,
                  // buttonWidth: 36.w,
                  onPress: () {
                    Get.back();
                    controller.rejectLogList();
                    // Get.back();
                  },
                  bgColor: AppColors().blueColor,
                  isFilled: true,
                  textColor: AppColors().whiteColor,
                  isTextCenter: true,
                  isLoading: false,
                ),
              ),
              // SizedBox(width: 5.w,),
            ],
          )
        ],
      ),
    );
  }

  Widget mainContent(BuildContext context) {
    return controller.isApiCallRunning
        ? displayIndicator()
        : controller.isApiCallRunning == false && controller.arrRejectLog.isEmpty
            ? dataNotFoundView("Data not found")
            : SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: 950,
                  // margin: EdgeInsets.only(right: 1.w),
                  color: AppColors().bgColor,
                  child: Column(
                    children: [
                      Container(
                        height: 3.h,
                        color: AppColors().bgColor,
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
                            itemCount: controller.arrRejectLog.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return rejectionLogContent(context, index);
                            }),
                      ),
                    ],
                  ),
                ),
              );
  }

  Widget rejectionLogContent(BuildContext context, int index) {
    var logValue = controller.arrRejectLog[index];
    return GestureDetector(
      onTap: () {
        // controller.selectedScriptIndex = index;
        controller.update();
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            valueBox(
              shortFullDateTime(logValue.createdAt!),
              140,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
            valueBox(
              logValue.status ?? "",
              90,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
            valueBox(logValue.userName ?? "", 90, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index, isUnderlined: true),
            valueBox(
              logValue.symbolTitle ?? "",
              150,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
            valueBox(logValue.tradeTypeValue ?? "", 60, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
            valueBox(logValue.quantity.toString(), 80, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
            valueBox(logValue.price!.toStringAsFixed(2), 80, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
            // valueBox("58 980.00", 60, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index,
            //     ),
            valueBox(logValue.ipAddress ?? "", 110, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
            valueBox(
              logValue.deviceId ?? "",
              150,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
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
        titleBox("Date", width: 140),
        titleBox("Message", width: 90),
        titleBox("Username", width: 90),
        titleBox("Sumbol", width: 150),
        titleBox("Type", width: 60),
        titleBox("Quanity", width: 80),
        titleBox("Price", width: 80),
        titleBox("IPAddress", width: 110),
        titleBox("DeviceId", width: 150),
      ],
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
      // locale: Locale('en', 'US'),
    );

    if (picked != null) {
      // Format the DateTime to display only the date portion
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      print(formattedDate);
      controller.startDate = formattedDate;
      controller.update();
      _selectToDate(context, DateTime.parse(controller.startDate));
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
      controller.endDate = formattedDate;
      controller.update();
    }
  }
}
