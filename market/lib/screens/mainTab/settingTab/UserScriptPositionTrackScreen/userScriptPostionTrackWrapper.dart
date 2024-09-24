import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/font_family.dart';

import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant/assets.dart';
import '../../../../constant/commonWidgets.dart';
import '../../../../constant/utilities.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../BaseViewController/baseController.dart';
import 'userScriptPositionTrackController.dart';

class UserScriptPositionTrackScreen extends BaseView<UserScriptPositionTrackController> {
  const UserScriptPositionTrackScreen({Key? key}) : super(key: key);

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
        headerTitle: "User Script Position Tracking",
        backGroundColor: AppColors().headerBgColor,
      ),
      body: mainContent(context),
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
                    vertical: 23.h,
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: 1.w,
                      // ),
                      toAndFromDateBtnView(),
                      exchangeSelection(),
                      scriptSelection(),
                      buttonsView(),
                    ],
                  ));
            }));
  }

  Widget mainContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              width: 600,
              // margin: EdgeInsets.only(right: 1.w),
              color: Colors.white,
              child: Column(
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
                    child: controller.isApiCallRunning == false && controller.arrTracking.isEmpty
                        ? dataNotFoundView("Position track not found")
                        : PaginableListView.builder(
                            loadMore: () async {
                              if (controller.totalPage >= controller.currentPage) {
                                //print(controller.currentPage);
                                controller.trackList();
                              }
                            },
                            errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                            progressIndicatorWidget: displayIndicator(),
                            physics: const ClampingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            itemCount: controller.isApiCallRunning ? 50 : controller.arrTracking.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return tradeContent(context, index);
                            }),
                  ),
                  Container(
                    height: 2.h,
                    color: AppColors().headerBgColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tradeContent(BuildContext context, int index) {
    var scriptValue = controller.arrTracking[index];
    return GestureDetector(
      onTap: () {
        // controller.selectedScriptIndex = index;
        controller.update();
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            valueBox(shortFullDateTime(scriptValue.createdAt!), 160, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
            valueBox(
              scriptValue.userName ?? "",
              100,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
            valueBox(
              scriptValue.symbolTitle ?? "",
              120,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
            valueBox(scriptValue.orderType!.toUpperCase(), 100, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
            valueBox(
              scriptValue.quantity!.toString(),
              120,
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

        titleBox("Position Date", width: 160),
        titleBox("Username", width: 100),
        titleBox("Symbol", width: 120),
        titleBox("position", width: 100),
        titleBox("Open Quantity", width: 120),
      ],
    );
  }

  Widget toAndFromDateBtnView() {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().grayLightLine,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3)),
      child: CustomButton(
        isEnabled: true,
        shimmerColor: AppColors().whiteColor,
        title: controller.endDate.value == "" ? "To Date" : controller.endDate.value.toString(),
        textSize: 14,
        onPress: () {
          // _selectToDate(Get.context!);
          _selectToDate(Get.context!, DateTime.now());
        },
        bgColor: Colors.transparent,
        isFilled: true,
        textColor: AppColors().DarkText,
        isTextCenter: true,
        isLoading: false,
      ),
    );
  }

  Future<void> _selectToDate(BuildContext context, DateTime fromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: 'Select To Date',
      cancelText: 'Cancel',
      confirmText: 'OK',
    );
    if (picked != null) {
      // Format the DateTime to display only the date portion
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      print(formattedDate);
      controller.endDate.value = formattedDate;
      controller.update();
    }
  }

  Widget exchangeSelection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
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
    );
  }

  Widget scriptSelection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
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
    );
  }

  Widget buttonsView() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 32.5.w,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Reset",
              textSize: 16,
              onPress: () {
                Get.back();
                controller.currentPage = 1;
                controller.selectExchangedropdownValue.value = ExchangeData();
                controller.selectedScriptDropDownValue.value = GlobalSymbolData();
                controller.update();
                controller.trackList(isFromClear: true);
                // controller.getAccountSummaryNewList("", isFromClear: true, isFromfilter: true);
              },
              bgColor: AppColors().grayLightLine,
              isFilled: true,
              textColor: AppColors().DarkText,
              isTextCenter: true,
              isLoading: controller.isClearApiCallRunning,
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          SizedBox(
            width: 32.5.w,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Done",
              textSize: 16,
              // buttonWidth: 36.w,
              onPress: () {
                controller.currentPage = 1;
                Get.back();
                controller.trackList(isFromFilter: true);
                // controller.getAccountSummaryNewList("", isFromfilter: true);
              },
              bgColor: AppColors().blueColor,
              isFilled: true,
              textColor: AppColors().whiteColor,
              isTextCenter: true,
              isLoading: controller.isFilterApiCallRunning,
            ),
          ),
          // SizedBox(width: 5.w,),
        ],
      ),
    );
  }
}
