import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:shimmer/shimmer.dart';
import '../../../../modelClass/constantModelClass.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/color.dart';
import '../../../../constant/commonWidgets.dart';
import '../../../../constant/const_string.dart';
import '../../../../constant/font_family.dart';
import '../../../../constant/utilities.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../../customWidgets/appTextField.dart';
import '../../../../main.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../BaseViewController/baseController.dart';
import 'clientAccountReportController.dart';

class ClientAccountReportScreen extends BaseView<ClientAccountReportController> {
  const ClientAccountReportScreen({Key? key}) : super(key: key);

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
        headerTitle: "Account Report",
        backGroundColor: AppColors().headerBgColor,
      ),
      backgroundColor: AppColors().headerBgColor,
      body: Container(
        child: Column(
          children: [
            // summaryDetailsTopView(),
            Expanded(
              child: mainContent(context),
            ),
          ],
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
              // vertical: 21.7.h,
            ),
            content: summaryDetailsTopView()));
  }

  Widget summaryDetailsTopView() {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 5.w),
      width: 100.w,
      // height: controller.selectStatusdropdownValue == "Custom Period" ? 40.5.h : 32.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          // weekSelectiondropDownView(),
          // if (controller.selectStatusdropdownValue == "Custom Period") toAndFromDateBtnView(),
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
            decoration: BoxDecoration(color: AppColors().bgColor, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                if (userData!.role != UserRollList.user) selectUserdropDownView(),
                exchangeDropDownView(),
                scriptDropDownView(),
                productTypeDropDownView(),
                plTypeDropDownView(),
                viewAndClearBtnView(),
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
      ),
    );
  }

  Widget exchangeDropDownView() {
    return Container(
      height: 6.5.h,
      margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.h),
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
            child: DropdownButton2<ExchangeData>(
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
                'Exchange',
                maxLines: 1,
                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
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
              value: controller.selectExchangeDropdownValue.value.name != null ? controller.selectExchangeDropdownValue.value : null,
              onChanged: (ExchangeData? value) {
                // setState(() {
                controller.selectExchangeDropdownValue.value = value!;
                controller.arrMainScript.clear();
                controller.selectedScriptDropDownValue.value = GlobalSymbolData();
                controller.update();
                controller.getScriptList();
                // });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 54,
                // width: 140,
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

  Widget scriptDropDownView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
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
        var dropdownButton2 = DropdownButton2<GlobalSymbolData>(
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
        );
        return Center(
          child: DropdownButtonHideUnderline(
            child: dropdownButton2,
          ),
        );
      }),
    );
  }

  Widget productTypeDropDownView() {
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
            child: DropdownButton2<Type>(
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
                'Type',
                maxLines: 1,
                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
              ),
              items: constantValues!.productTypeForAccount!
                  .map((Type item) => DropdownMenuItem<Type>(
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
                return constantValues!.productTypeForAccount!
                    .map((Type item) => DropdownMenuItem<Type>(
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
              value: controller.selectedProductType.value.id != null ? controller.selectedProductType.value : null,
              onChanged: (Type? value) {
                // setState(() {
                controller.selectedProductType.value = value!;

                // });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 54,
                // width: 140,
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

  Widget plTypeDropDownView() {
    return Container(
      height: 6.5.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
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
                'Type',
                maxLines: 1,
                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
              ),
              items: controller.arrPLTypeforAccount
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
                return constantValues!.productTypeForAccount!
                    .map((Type item) => DropdownMenuItem<Type>(
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
              value: controller.selectedplType.value != "null" ? controller.selectedplType.value : null,
              onChanged: (String? value) {
                // setState(() {
                controller.selectedplType.value = value!;

                // });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 54,
                // width: 140,
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

  Widget weekSelectiondropDownView() {
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

  Widget toAndFromDateBtnView() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.only(bottom: 2.h, right: 5.w, left: 5.w),
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
                title: controller.startDate == "" ? "From Date" : controller.startDate.toString(),
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
                  _selectToDate(Get.context!, DateTime.parse(controller.startDate.value));
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
      controller.startDate.value = formattedDate;
      controller.update();
      _selectToDate(context, DateTime.parse(controller.startDate.value));
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
      controller.endDate.value = formattedDate;
      controller.update();
    }
  }

  Widget selectUserdropDownView() {
    return Container(
      height: 6.5.h,
      margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 15),
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
              items: controller.arrUserListOnlyClient
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
                return controller.arrUserListOnlyClient
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

              dropdownStyleData: DropdownStyleData(
                maxHeight: 300,
                decoration: BoxDecoration(
                  color: AppColors().grayBg,
                ),
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: controller.textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 60,
                  padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
                  child: CustomTextField(
                    type: '',
                    keyBoardType: TextInputType.text,
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: "",
                    placeHolderMsg: "Search User",
                    emptyFieldMsg: "",
                    controller: controller.textEditingController,
                    focus: controller.textEditingFocus,
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
                          controller.textEditingController.clear();
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
                  return item.value!.userName.toString().toLowerCase().contains(searchValue.toLowerCase());
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  controller.textEditingController.clear();
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Widget viewAndClearBtnView() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20),
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
                controller.getAccountSummaryNewList("", isFromfilter: true);

                controller.update();
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
                controller.currentPage = 1;
                controller.startDate = "".obs;
                controller.endDate = "".obs;
                controller.arrSummaryList.clear();
                controller.selectExchangeDropdownValue.value = ExchangeData();
                controller.selectedScriptDropDownValue.value = GlobalSymbolData();
                controller.selectedProductType.value = Type();
                Get.back();

                controller.getAccountSummaryNewList("", isFromClear: true);
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

  Widget mainContent(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 2200,
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
              child: controller.isApiCallRunning == false && controller.isResetCall == false && controller.arrSummaryList.isEmpty
                  ? dataNotFoundView("Account Summary not found")
                  : PaginableListView.builder(
                      loadMore: () async {
                        if (controller.totalPage >= controller.currentPage) {
                          //print(controller.currentPage);
                          controller.getAccountSummaryNewList("");
                        }
                      },
                      errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                      progressIndicatorWidget: displayIndicator(),
                      physics: const ClampingScrollPhysics(),
                      clipBehavior: Clip.hardEdge,
                      itemCount: controller.isApiCallRunning || controller.isResetCall ? 50 : controller.arrSummaryList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return tradeContent(context, index);
                      }),
            ),
            Obx(() {
              return Container(
                height: 3.h,
                decoration: BoxDecoration(color: AppColors().whiteColor, border: Border(top: BorderSide(color: AppColors().lightOnlyText, width: 1))),
                child: Center(
                    child: Row(
                  children: [
                    totalContent(value: "Total :", textColor: AppColors().DarkText, width: 1850),
                    totalContent(value: "Total : " + controller.grandTotal.value.toStringAsFixed(2), textColor: AppColors().DarkText, width: 150),
                    totalContent(value: "Our % : " + controller.outPerGrandTotal.toStringAsFixed(2), textColor: AppColors().DarkText, width: 150),
                    // totalContent(value: controller.totalValues!.profitGrandTotal.toStringAsFixed(2), textColor: AppColors().DarkText, width: 110),
                  ],
                )),
              );
            }),
            Container(
              height: 2.h,
              color: AppColors().headerBgColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget totalContent({String? value, Color? textColor, double? width}) {
    return Container(
      width: width ?? 6.w,
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(color: AppColors().whiteColor, border: Border(top: BorderSide(color: AppColors().lightOnlyText, width: 1), bottom: BorderSide(color: AppColors().lightOnlyText, width: 1), right: BorderSide(color: AppColors().lightOnlyText, width: 1))),
      child: Text(value ?? "",
          style: TextStyle(
            fontSize: 12,
            fontFamily: Appfonts.family1Medium,
            color: textColor ?? AppColors().redColor,
          )),
    );
  }

  Widget tradeContent(BuildContext context, int index) {
    if (controller.isApiCallRunning || controller.isResetCall) {
      return Container(
        margin: EdgeInsets.only(bottom: 3.h),
        child: Shimmer.fromColors(
            child: Container(
              height: 3.h,
              color: Colors.white,
            ),
            baseColor: AppColors().whiteColor,
            highlightColor: AppColors().grayBg),
      );
    } else {
      var scriptValue = controller.arrSummaryList[index];
      return GestureDetector(
        onTap: () {
          // controller.selectedScriptIndex = index;
          controller.update();
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (userData!.role != UserRollList.user) valueBox(controller.arrSummaryList[index].userName ?? "", 100, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              if (userData!.role != UserRollList.user) valueBox(controller.arrSummaryList[index].parentUserName ?? "", 100, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.exchangeName ?? "", 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.symbolTitle ?? "", 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.buyTotalQuantity!.toString(), 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.buyTotalPrice!.toStringAsFixed(2), 150, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.sellTotalQuantity!.toString(), 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.sellTotalPrice!.toStringAsFixed(2), 150, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.totalQuantity!.toString(), 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.avgPrice!.toStringAsFixed(2), 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.totalQuantity! < 0 ? scriptValue.ask!.toStringAsFixed(2) : scriptValue.bid!.toStringAsFixed(2), 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                  scriptValue.currentPriceFromSocket! > scriptValue.avgPrice! ? AppColors().redColor : AppColors().blueColor, index),
              valueBox(scriptValue.brokerageTotal!.toStringAsFixed(2), 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              if (controller.selectedplType.value == "All" || controller.selectedplType.value == "Only Release") valueBox(scriptValue.profitLoss!.toStringAsFixed(2), 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              // valueBox((double.parse(scriptValue.profitLoss!.toStringAsFixed(2)) + double.parse(scriptValue.brokerageTotal!.toStringAsFixed(2))).toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index, isLarge: true),
              if (controller.selectedplType.value != "Only Release") valueBox(scriptValue.profitLossValue!.toStringAsFixed(2), 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),

              if (controller.selectedplType.value != "Only Release")
                valueBox((double.parse(scriptValue.profitLossValue!.toStringAsFixed(2)) - double.parse(scriptValue.brokerageTotal!.toStringAsFixed(2))).toStringAsFixed(2), 180, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),

              if (controller.selectedplType.value == "All" && controller.selectedplType.value != "Only Release") valueBox(scriptValue.total.toStringAsFixed(2), 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              if (userData!.role != UserRollList.user) valueBox(scriptValue.ourPer.toStringAsFixed(2), 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              // valueBox((((((scriptValue.profitLossValue! + scriptValue.profitLoss!) * scriptValue.profitAndLossSharing!) / 100) + scriptValue.adminBrokerageTotal!) * -1).toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
            ],
          ),
        ),
      );
    }
  }

  Widget listTitleContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (userData!.role != UserRollList.user) titleBox("User Name", width: 100),
        if (userData!.role != UserRollList.user) titleBox("Parent User", width: 100),
        titleBox("Exchange", width: 120),
        titleBox("symbol", width: 120),
        titleBox("Total Buy Qty", width: 120),
        titleBox("Total Buy A Price", width: 150),
        titleBox("Total Sell Qty", width: 120),
        titleBox("Total Sell A Price", width: 150),
        titleBox("Net Qty", width: 120),
        titleBox("Net A Price", width: 120),
        titleBox("CMP", width: 120),
        titleBox("BROKRAGE", width: 120),
        if (controller.selectedplType.value == "All" || controller.selectedplType.value == "Only Release") titleBox("RELEAS P/L", width: 120),
        // titleBox("RELEAS P/L WITH BROKRAGE", isLarge: true),
        if (controller.selectedplType.value != "Only Release") titleBox("MTM", width: 120),
        if (controller.selectedplType.value != "Only Release") titleBox("MTM WITH BORKRAGE", width: 180),
        if (controller.selectedplType.value == "All" && controller.selectedplType.value != "Only Release") titleBox("TOTAL", width: 120),
        if (userData!.role != UserRollList.user) titleBox("our %", width: 120),
      ],
    );
  }
}
