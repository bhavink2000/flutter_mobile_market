import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/IntradayHistoryScreen/IntradayHistoryScreenController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constant/color.dart';
import 'dart:math' as math;

import '../../../../modelClass/allSymbolListModelClass.dart';

class IntradayHistoryScreen extends BaseView<IntradayHistoryController> {
  const IntradayHistoryScreen({Key? key}) : super(key: key);

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
          headerTitle: "Intraday History",
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
      backgroundColor: AppColors().bgColor,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: AppColors().bgColor,
        ),
        child: Column(
          children: [
            SelectedView(),
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
            backgroundColor: AppColors().bgColor,
            surfaceTintColor: AppColors().bgColor,
            insetPadding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 26.h,
            ),
            content: Column(
              children: [
                exchangeDropDownView(),
                selectScriptdropDownView(),
                selectMinutesDropDownView(),
                btnField(),
              ],
            )));
  }

  Widget exchangeDropDownView() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      height: 6.5.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().grayLightLine,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3)),
      // color: AppColors().whiteColor,
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
                  height: 25,
                  width: 25,
                  color: AppColors().fontColor,
                ),
              ),
              hint: Text(
                'Exchange',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: Appfonts.family1Medium,
                  color: AppColors().lightText,
                ),
              ),
              items: controller.arrExchangeList
                  .map((ExchangeData item) => DropdownMenuItem<String>(
                        value: item.name ?? "",
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
                    .map((ExchangeData item) => DropdownMenuItem<String>(
                          value: item.name ?? "",
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
              value: controller.exchangedropdownValue.value.isNotEmpty ? controller.exchangedropdownValue.value : null,
              onChanged: (String? value) {
                // setState(() {
                controller.exchangedropdownValue.value = value.toString();
                controller.update();
                // });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                // height: 40,
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

  Widget selectScriptdropDownView() {
    return Container(
      height: 6.5.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
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
                  height: 25,
                  width: 25,
                  color: AppColors().fontColor,
                ),
              ),
              hint: Text(
                'Select Script',
                maxLines: 1,
                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
              ),
              items: controller.arrScriptListDropdown
                  .map((GlobalSymbolData item) => DropdownMenuItem<String>(
                        value: item.symbolTitle ?? "",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.symbolTitle ?? "",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: Appfonts.family1Medium,
                                color: AppColors().DarkText,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 1,
                              width: 100.w,
                              color: AppColors().grayLightLine,
                            )
                          ],
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return controller.arrScriptListDropdown
                    .map((GlobalSymbolData item) => DropdownMenuItem<String>(
                          value: item.symbolTitle ?? "",
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
              value: controller.selectScriptdropdownValue.value.isNotEmpty ? controller.selectScriptdropdownValue.value : null,
              onChanged: (String? value) {
                controller.selectScriptdropdownValue.value = value.toString();
                controller.update();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                // height: 100,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),

              dropdownSearchData: DropdownSearchData(
                searchController: controller.searchtextEditingController,
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
                    placeHolderMsg: "Search Script",
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

  Widget selectMinutesDropDownView() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
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
            child: DropdownButton2<String>(
              isExpanded: true,
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                decoration: BoxDecoration(
                  color: AppColors().grayBg,
                ),
              ),
              iconStyleData: IconStyleData(
                icon: Image.asset(
                  AppImages.arrowDown,
                  height: 25,
                  width: 25,
                  color: AppColors().fontColor,
                ),
              ),
              hint: Text(
                'Minutes',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: Appfonts.family1Medium,
                  color: AppColors().lightText,
                ),
              ),
              items: controller.minuteslistdata
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
                return controller.minuteslistdata
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
              value: controller.minutesdropdownValue.value.isNotEmpty ? controller.minutesdropdownValue.value : null,
              onChanged: (String? value) {
                // setState(() {
                controller.minutesdropdownValue.value = value.toString();
                controller.update();
                // });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                // height: 40,
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
              buttonHeight: 6.5.h,
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
              title: "Reset",
              textSize: 16,
              buttonHeight: 6.5.h,
              onPress: () {
                Get.back();
                controller.exchangedropdownValue.value = "";
                controller.selectScriptdropdownValue.value = "";
                controller.minutesdropdownValue.value = "";
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

  Widget SelectedView() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                )),
                child: Row(
                  children: [
                    Container(
                      width: 85,
                      height: 54,
                      decoration: BoxDecoration(
                          border: Border(
                        right: BorderSide(
                          color: AppColors().grayLightLine,
                          width: 1.5,
                        ),
                      )),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Timing", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                          Transform.rotate(
                            angle: math.pi,
                            child: Image.asset(
                              AppImages.arrowup,
                              height: 18,
                              width: 18,
                              color: AppColors().fontColor,
                            ),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      width: 85,
                      height: 54,
                      decoration: BoxDecoration(
                          border: Border(
                        right: BorderSide(
                          color: AppColors().grayLightLine,
                          width: 1.5,
                        ),
                      )),
                      child: Center(child: Text("High", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                    ),
                    Container(
                      width: 85,
                      height: 54,
                      decoration: BoxDecoration(
                          border: Border(
                        right: BorderSide(
                          color: AppColors().grayLightLine,
                          width: 1.5,
                        ),
                      )),
                      child: Center(child: Text("Low", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                    ),
                    Container(
                      width: 85,
                      height: 54,
                      decoration: BoxDecoration(
                          border: Border(
                        right: BorderSide(
                          color: AppColors().grayLightLine,
                          width: 1.5,
                        ),
                      )),
                      child: Center(child: Text("Volume", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                    ),
                    Container(
                      width: 85,
                      height: 54,
                      decoration: BoxDecoration(
                          border: Border(
                        right: BorderSide(
                          color: AppColors().grayLightLine,
                          width: 1.5,
                        ),
                      )),
                      child: Center(child: Text("Open", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                    ),
                    SizedBox(
                      width: 85,
                      height: 54,
                      child: Center(child: Text("Close", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 513,
                  child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      clipBehavior: Clip.hardEdge,
                      itemCount: controller.arrData.length,
                      controller: controller.listcontroller,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return clientSelectedView(context, index);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget clientSelectedView(BuildContext context, int index) {
    return Container(
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
        children: [
          Container(
            width: 85,
            height: 36,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text(controller.arrData[index].timing ?? "", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          Container(
            width: 85,
            height: 36,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text(controller.arrData[index].high ?? "", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          Container(
            width: 85,
            height: 36,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text(controller.arrData[index].low ?? "", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          Container(
            width: 85,
            height: 36,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text(controller.arrData[index].volume ?? "", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          Container(
            width: 85,
            height: 36,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text(controller.arrData[index].open ?? "", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          SizedBox(
            width: 85,
            height: 36,
            child: Center(child: Text(controller.arrData[index].close ?? "", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
        ],
      ),
    );
  }
}
