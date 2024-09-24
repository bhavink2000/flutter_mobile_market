import 'dart:io';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/modelClass/myUserListModelClass.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../customWidgets/appTextField.dart';
import '../../../modelClass/constantModelClass.dart';
import '../../../../../constant/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../constant/assets.dart';
import '../../../constant/font_family.dart';
import '../../../customWidgets/appButton.dart';
import '../../../customWidgets/appNavigationBar.dart';
import '../../../modelClass/allSymbolListModelClass.dart';
import '../../BaseViewController/baseController.dart';
import '../tabScreen/MainTabController.dart';
import 'tradeController.dart';

class tradeScreen extends BaseView<tradeController> {
  const tradeScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: appNavigationBar(
          isTrailingDisplay: true,
          isMarketDisplay: true,
          leadingTitleText: "Trade",
          onMoreButtonPress: () {
            controller.isHedaderDropdownSelected.value = !controller.isHedaderDropdownSelected.value;
            if (controller.isHedaderDropdownSelected.value) {
              Future.delayed(const Duration(milliseconds: 300), () {
                controller.isHedaderDropdownOpen.value = true;
              });
            } else {
              controller.isHedaderDropdownOpen.value = false;
            }
          },
          backGroundColor: AppColors().headerBgColor,
          trailingIcon: Image.asset(
            AppImages.notificationIcon,
            width: 20,
            height: 20,
            color: AppColors().fontColor,
          ),
          isMoreDisplay: true,
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
          // headerDropDown(),
          // SizedBox(
          //   // height: 5.h,
          //   width: 100.w,
          //   child: buildTabView(context),
          // ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors().blueColor,
              onRefresh: () async {
                try {
                  controller.getTradeList();
                } catch (e) {}
              },
              child: Container(
                  // margin: EdgeInsets.only(top: 3.h),
                  width: 100.w,
                  decoration: BoxDecoration(color: AppColors().bgColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(10))),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 90.w,
                          height: 6.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors().bgColor, boxShadow: const []),
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.searchIcon,
                                width: 20,
                                height: 20,
                                color: AppColors().blueColor,
                              ),
                              SizedBox(
                                width: 2.w,
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
                                  textInputAction: TextInputAction.search,
                                  minLines: 1,
                                  maxLines: 1,
                                  onSubmitted: (value) {
                                    controller.getTradeList();
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
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  filterPopupDialog();
                                },
                                child: Image.asset(
                                  AppImages.filterIcon,
                                  width: 20,
                                  height: 20,
                                  color: AppColors().blueColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 90.w,
                        color: AppColors().grayLightLine,
                      ),
                      Expanded(
                          child: controller.arrTrade.isNotEmpty
                              ? ListView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  clipBehavior: Clip.hardEdge,
                                  itemCount: controller.arrTrade.length,
                                  controller: controller.listcontroller,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return listContentView(context, index);
                                  })
                              : controller.isApicall
                                  ? displayIndicator()
                                  : Container(
                                      child: Center(
                                      child: Text(
                                        "Data not found".tr,
                                        style: TextStyle(fontSize: 15, fontFamily: Appfonts.family1Regular, color: AppColors().fontColor),
                                      ),
                                    ))),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget listContentView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        print(controller.arrTrade[index]);
        controller.selectedOrderIndex = index;
        controller.selectedTrade = controller.arrTrade[index];
        tradeDetailBottomSheet();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text((controller.arrTrade[index].exchangeName ?? "") + ", ", style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1SemiBold, color: AppColors().DarkText)),
                      Text((controller.arrTrade[index].symbolName ?? "") + ", ", style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                      Text((controller.arrTrade[index].exchangeName!.toLowerCase() == "mcx" ? controller.arrTrade[index].quantity.toString() + " " : controller.arrTrade[index].totalQuantity.toString() + " "),
                          style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1Medium, color: controller.arrTrade[index].tradeType == "buy" ? AppColors().blueColor : AppColors().redColor)),
                      Text(controller.arrTrade[index].tradeTypeValue!.toUpperCase() + " ", style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1Medium, color: controller.arrTrade[index].tradeType == "buy" ? AppColors().blueColor : AppColors().redColor)),
                      Text(controller.arrTrade[index].productTypeValue!, style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1Medium, color: controller.arrTrade[index].tradeType == "buy" ? AppColors().blueColor : AppColors().redColor)),
                      Spacer(),
                      Text(controller.arrTrade[index].price.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: controller.arrTrade[index].tradeType == "buy" ? AppColors().blueColor : AppColors().redColor)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      if (userData?.role != UserRollList.user)
                        Image.asset(
                          AppImages.profileIcon,
                          width: 15,
                          height: 15,
                          color: AppColors().fontColor,
                        ),
                      if (userData?.role != UserRollList.user)
                        const SizedBox(
                          width: 5,
                        ),
                      if (userData?.role != UserRollList.user) Text(controller.arrTrade[index].userName ?? "", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                      Spacer(),
                      Text(shortFullDateTime(controller.arrTrade[index].createdAt!), style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              width: 90.w,
              color: AppColors().grayLightLine,
            )
          ],
        ),
      ),
    );
  }

  Widget detailTopView() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(color: controller.selectedTrade!.tradeType! == "buy" ? AppColors().blueColor.withOpacity(0.1) : AppColors().redColor.withOpacity(0.1), borderRadius: BorderRadius.circular(2)),
                        child: Text(controller.selectedTrade!.tradeType!.toUpperCase(), style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: controller.selectedTrade!.tradeType! == "buy" ? AppColors().blueColor : AppColors().redColor)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(controller.selectedTrade!.symbolName ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.profileIcon,
                            width: 15,
                            height: 15,
                            color: AppColors().fontColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(controller.selectedTrade?.userName ?? "", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.profileIcon,
                            width: 15,
                            height: 15,
                            color: AppColors().fontColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(shortFullDateTime(controller.selectedTrade!.createdAt!), style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(controller.selectedTrade!.price.toString(),
                          style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: controller.getPriceColor(controller.selectedTrade!.tradeType!, controller.selectedTrade!.currentPriceFromScoket ?? 0, controller.selectedTrade!.price!.toDouble()))),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("${controller.selectedTrade!.quantity.toString()}/${controller.selectedTrade!.totalQuantity.toString()}", textAlign: TextAlign.end, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 90.w,
            color: AppColors().lightText,
            height: 0.5,
          ),
        ],
      ),
    );
  }

  tradeDetailBottomSheet() {
    Get.bottomSheet(
        PopScope(
          canPop: false,
          onPopInvoked: (canpop) {},
          child: StatefulBuilder(builder: (context, stateSetter) {
            return Column(
              children: [
                Expanded(child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                )),
                Container(
                    height: 68.h,
                    decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: AppColors().bgColor),
                    child: Column(
                      children: [
                        detailTopView(),
                        SizedBox(
                          height: 1.h,
                        ),
                        ListView(
                          physics: const ClampingScrollPhysics(),
                          clipBehavior: Clip.hardEdge,
                          shrinkWrap: true,
                          children: [
                            sheetList("Username", controller.selectedTrade?.userName ?? "", 0),
                            sheetList("Order Time", shortFullDateTime(controller.selectedTrade!.createdAt!), 1),
                            sheetList("Symbol", controller.selectedTrade?.symbolName ?? "", 2),
                            sheetList("Order Type", controller.selectedTrade?.productTypeValue ?? "", 3),
                            sheetList("Quantity", controller.selectedTrade!.quantity!.toString(), 4),
                            sheetList("Price", controller.selectedTrade!.price.toString(), 5),
                            sheetList("Brk", controller.selectedTrade!.brokerageAmount!.toStringAsFixed(2), 6),
                            // sheetList("Reference Price", "389.8", 7),
                            sheetList(controller.selectedTrade!.orderMethod!, "IOS", 7),
                            sheetList("Ipaddress", controller.selectedTrade!.ipAddress!, 8),
                            sheetList("Device Id", controller.selectedTrade!.deviceId!, 9),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            );
          }),
        ),
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: true);
  }

  Widget sheetList(String name, String value, int index) {
    Color backgroundColor = index % 2 == 1 ? AppColors().headerBgColor : AppColors().contentBg;
    return Container(
      width: 100.w,
      height: 38,
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: Row(
          children: [
            Text(name.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
            const Spacer(),
            Text(value.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
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
                  vertical: userData!.role != UserRollList.user
                      ? Platform.isAndroid
                          ? controller.selectStatusdropdownValue.value == "Custom Period"
                              ? 12.h
                              : 13.h
                          : controller.selectStatusdropdownValue.value == "Custom Period"
                              ? 10.h
                              : 8.h
                      : Platform.isAndroid
                          ? controller.selectStatusdropdownValue.value == "Custom Period"
                              ? 14.h
                              : 16.h
                          : controller.selectStatusdropdownValue.value == "Custom Period"
                              ? 12.h
                              : 16.h,
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      message ?? "Filter",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors().DarkText,
                        fontFamily: Appfonts.family1SemiBold,
                      ),
                    ),
                    weekSelectiondropDownView(),
                    if (controller.selectStatusdropdownValue.value == "Custom Period") toAndFromDateBtnView(),
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
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
                            child: DropdownButton2<Type>(
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
                                'Select Type',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: Appfonts.family1Medium,
                                  color: AppColors().DarkText,
                                ),
                              ),
                              items: constantValues!.tradeStatusFilter!
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
                                return constantValues!.tradeStatusFilter!
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
                              value: controller.selectedOrderType.value.id != null ? controller.selectedOrderType.value : null,
                              onChanged: (Type? value) {
                                // setState(() {
                                controller.selectedOrderType.value = value!;
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
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
                            child: DropdownButton2<Type>(
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
                                'Select Status',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: Appfonts.family1Medium,
                                  color: AppColors().DarkText,
                                ),
                              ),
                              items: constantValues!.tradeTypeFilter!
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
                                return constantValues!.tradeTypeFilter!
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
                              value: controller.selectedOrderStatus.value.id != null ? controller.selectedOrderStatus.value : null,
                              onChanged: (Type? value) {
                                // setState(() {
                                controller.selectedOrderStatus.value = value!;
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
                          width: 35.w,
                          child: CustomButton(
                            isEnabled: true,
                            shimmerColor: AppColors().whiteColor,
                            title: "Reset",
                            textSize: 16,
                            onPress: () {
                              controller.startDate.value = "";
                              controller.endDate.value = "";
                              controller.selectStatusdropdownValue.value = "";
                              controller.selectUserDropdownValue.value = UserData();
                              controller.selectedOrderStatus.value = Type();
                              controller.selectedOrderType.value = Type();
                              controller.selectExchangedropdownValue.value = ExchangeData();
                              controller.selectedScriptDropDownValue.value = GlobalSymbolData();
                              controller.update();
                              Get.back();
                              controller.getTradeList();
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
                          width: 35.w,
                          child: CustomButton(
                            isEnabled: true,
                            shimmerColor: AppColors().whiteColor,
                            title: "Done",
                            textSize: 16,
                            // buttonWidth: 36.w,
                            onPress: () {
                              controller.getTradeList();
                              // controller.selectUserDropdownValue.value = UserData();
                              // controller.selectExchangedropdownValue.value = ExchangeData();
                              // controller.selectedScriptDropDownValue.value = GlobalSymbolData();
                              // controller.fromDateStr.value = "Start Date";
                              // controller.endDateStr.value = "End Date";
                              // controller.fromDate = null;
                              // controller.toDate = null;
                              // controller.update();
                              Get.back();
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
            }));
  }

  Widget weekSelectiondropDownView() {
    return Container(
      height: 6.5.h,
      width: 85.w,
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
                if (controller.selectStatusdropdownValue.value == "Custom Period") {
                  controller.startDate.value = "";
                  controller.endDate.value = "";
                }
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
      padding: EdgeInsets.only(
        top: 2.h,
      ),
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
                title: controller.startDate.value == "" ? "From Date" : controller.startDate.value,
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
                title: controller.endDate.value == "" ? "To Date" : controller.endDate.value,
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
      helpText: 'Select End Date',
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

  displyMoreOptionBootomSheet() {
    // GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
    controller.buySellBottomSheetKey = GlobalKey();
    // Future.delayed(const Duration(milliseconds: 100), () {
    //   controller.buySellBottomSheetKey?.currentState?.contract();
    // });

    Get.bottomSheet(StatefulBuilder(builder: (context, stateSetter) {
      return Obx(() {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 480,
          width: 100.w,
          decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: AppColors().bgColor),
          child: SingleChildScrollView(
              controller: controller.buySellBottomSheetScrollcontroller,
              physics: controller.isInfoClick.value ? ClampingScrollPhysics() : NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(controller.arrTrade[controller.selectedOrderIndex].symbolTitle ?? "", style: TextStyle(fontSize: 22, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                Text(controller.arrTrade[controller.selectedOrderIndex].expiry != null ? shortDate(controller.arrTrade[controller.selectedOrderIndex].expiry!) : "", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                AppImages.crossIcon,
                                width: 35,
                                height: 35,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      if (userData!.role == UserRollList.user)
                        Container(
                          height: 12.5.h,
                          color: AppColors().grayLightLine,
                          child: Column(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 5.h,
                                  child: ListView.builder(
                                      physics: const AlwaysScrollableScrollPhysics(),
                                      clipBehavior: Clip.hardEdge,
                                      itemCount: constantValues?.orderType?.length ?? 0,
                                      controller: controller.orderTypeListcontroller,
                                      scrollDirection: Axis.horizontal,
                                      // shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return orderTypeInBottomSheet(context, index, constantValues!.orderType![index]);
                                      }),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      if (userData!.role == UserRollList.user)
                        Center(
                            child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            qtyPriceView(),
                          ],
                        )),
                    ],
                  ),
                  if (userData!.role == UserRollList.user)
                    const SizedBox(
                      height: 20,
                    ),
                  if (userData!.role == UserRollList.user)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 42.w,
                          child: CustomButton(
                            isEnabled: true,
                            buttonHeight: 7.h,
                            TitleFontFamily: Appfonts.family1SemiBold,
                            shimmerColor: AppColors().whiteColor,
                            title: "BUY \n ${controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.ask.toString()}",
                            textSize: 16,
                            // prefixHeight: 22,
                            onPress: () {
                              if (controller.arrTrade[controller.selectedOrderIndex].tradeType == "buy") {
                                var msg = controller.validateForm();
                                if (msg.isEmpty) {
                                  Get.back();
                                  controller.isForBuy = true;

                                  controller.initiateTrade(true);
                                } else {
                                  showWarningToast(msg, controller.globalContext!);
                                }
                              }
                            },
                            bgColor: controller.arrTrade[controller.selectedOrderIndex].tradeType == "buy" ? AppColors().blueColor : AppColors().lightText,
                            isFilled: true,
                            textColor: AppColors().whiteColor,
                            isTextCenter: true,
                            isLoading: false,
                          ),
                        ),
                        SizedBox(
                          width: 42.w,
                          child: CustomButton(
                            buttonHeight: 7.h,
                            isEnabled: true,
                            shimmerColor: AppColors().whiteColor,
                            title: "SELL \n ${controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.bid.toString()}",
                            textSize: 16,
                            // prefixHeight: 22,
                            onPress: () {
                              if (controller.arrTrade[controller.selectedOrderIndex].tradeType == "sell") {
                                var msg = controller.validateForm();
                                if (msg.isEmpty) {
                                  Get.back();
                                  controller.isForBuy = false;
                                  // buySellBottomSheet(false);
                                  controller.initiateTrade(false);
                                } else {
                                  showWarningToast(msg, controller.globalContext!);
                                }
                              }
                            },
                            bgColor: controller.arrTrade[controller.selectedOrderIndex].tradeType == "sell" ? AppColors().redColor : AppColors().lightText,
                            isFilled: true,
                            textColor: AppColors().whiteColor,
                            isTextCenter: true,
                            isLoading: false,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    child: Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              //
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  AppImages.chartIcon,
                                  width: 20,
                                  height: 20,
                                  color: AppColors().DarkText,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("View Chart", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  AppImages.arrowRight,
                                  width: 20,
                                  height: 20,
                                  color: AppColors().DarkText,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          // GestureDetector(
                          //   onTap: () {
                          //     // controller.isInfoClick.value = !controller.isInfoClick.value;
                          //     // controller.buySellBottomSheetScrollcontroller
                          //     //     .animateTo(0, duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
                          //     // controller.buySellBottomSheetKey?.currentState?.expand();
                          //     // Get.toNamed(RouterName.homeInfoScreen);
                          //   },
                          //   child: Container(
                          //     color: Colors.transparent,
                          //     child: Row(
                          //       children: [
                          //         Image.asset(
                          //           AppImages.infoIcon,
                          //           width: 20,
                          //           height: 20,
                          //           color: AppColors().DarkText,
                          //         ),
                          //         const SizedBox(
                          //           width: 10,
                          //         ),
                          //         Text("Info", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                          //         const SizedBox(
                          //           width: 10,
                          //         ),
                          //         Image.asset(
                          //           AppImages.arrowRight,
                          //           width: 20,
                          //           height: 20,
                          //           color: AppColors().DarkText,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    child: Container(
                      height: 1,
                      width: 100.w,
                      color: AppColors().grayLightLine,
                    ),
                  ),
                  Container(
                    // height: 45.h,
                    color: AppColors().bgColor,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            child: Obx(() {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text("High", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                      Text(controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.high.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                    ],
                                  ),
                                  Container(
                                    color: AppColors().grayLightLine,
                                    width: 1,
                                    height: 60,
                                  ),
                                  Column(
                                    children: [
                                      Text("Low", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                      Text(controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.low.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                    ],
                                  ),
                                  Container(
                                    color: AppColors().grayLightLine,
                                    width: 1,
                                    height: 60,
                                  ),
                                  Column(
                                    children: [
                                      Text("Open", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                      Text(controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.open.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                    ],
                                  ),
                                  Container(
                                    color: AppColors().grayLightLine,
                                    width: 1,
                                    height: 60,
                                  ),
                                  Column(
                                    children: [
                                      Text("Close", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                      Text(controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.close.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                    ],
                                  ),
                                ],
                              );
                            }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            child: Container(
                              height: 1,
                              width: 100.w,
                              color: AppColors().grayLightLine,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  )
                ],
              )),
        );
        // return BottomSheet(
        //   key: controller.buySellBottomSheetKey,
        //   // background: GestureDetector(
        //   //   onTap: () {
        //   //     Get.back();
        //   //   },
        //   //   child: Container(
        //   //     color: Colors.transparent,
        //   //     child: const Center(
        //   //       child: Text(''),
        //   //     ),
        //   //   ),
        //   // ),
        //   onClosing: () {},
        //   builder: (context) =>
        //   // expandableContent:
        // );
      });
    }), isDismissible: true, isScrollControlled: true, enableDrag: true);
  }

  Widget bottomSheetList(String bid, String order, String Qty, Color fontColors, int index) {
    return Container(
      // width: 100.w,
      height: 20,
      child: Row(
        children: [
          Text(bid.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: fontColors)),
          const Spacer(),
          Text(order.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: fontColors)),
          const Spacer(),
          Text(Qty.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: fontColors)),
        ],
      ),
    );
  }

  Widget qtyPriceView() {
    return Container(
      // height: 40.h,
      width: 89.w,
      height: 11.3.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors().bgColor, boxShadow: [
        BoxShadow(
          color: AppColors().fontColor.withOpacity(0.2),
          offset: Offset.zero,
          spreadRadius: 2,
          blurRadius: 7,
        ),
      ]),
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 7, left: 15, right: controller.selectedOptionBottomSheetTab != 0 && controller.selectedOptionBottomSheetTab != 3 ? 7.5 : 15),
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      return Obx(() {
                        return Row(
                          children: [
                            Text(
                                controller.arrTrade[controller.selectedOrderIndex].exchangeName!.toLowerCase() == "mcx"
                                    ? "Lot"
                                    : controller.isValidQty.value
                                        ? "Qty"
                                        : "Invalid Qty",
                                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: controller.isValidQty.value ? AppColors().DarkText : AppColors().redColor)),
                            const Spacer(),
                            Text(controller.arrTrade[controller.selectedOrderIndex].exchangeName!.toLowerCase() == "mcx" ? "Qty ${controller.lotSizeConverted.toStringAsFixed(2)}" : "Lot ${controller.lotSizeConverted.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                          ],
                        );
                      });
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      type: 'Quantity',
                      regex: '[0-9]',
                      onTap: () {
                        if (controller.buySellBottomSheetKey?.currentState?.expansionStatus == ExpansionStatus.contracted) {
                          controller.buySellBottomSheetKey?.currentState?.expand();
                        }
                      },
                      onChange: () {
                        if (controller.qtyController.text.isNotEmpty) {
                          if (controller.arrTrade[controller.selectedOrderIndex].oddLotTrade == 1) {
                            if (controller.arrTrade[controller.selectedOrderIndex].exchangeName!.toLowerCase() == "mcx") {
                              var temp = (num.parse(controller.qtyController.text) * controller.arrTrade[controller.selectedOrderIndex].lotSize!);
                              controller.lotSizeConverted.value = temp.toDouble();
                              var temp1 = (controller.lotSizeConverted / controller.arrTrade[controller.selectedOrderIndex].lotSize!.toDouble());

                              controller.totalQuantity = temp1;
                              controller.isValidQty.value = true;
                            } else {
                              var temp = (num.parse(controller.qtyController.text) / controller.arrTrade[controller.selectedOrderIndex].lotSize!);
                              controller.lotSizeConverted.value = temp;
                              controller.isValidQty.value = true;

                              var temp1 = num.parse(controller.qtyController.text);
                              controller.totalQuantity = temp1;
                              ();
                            }
                          } else {
                            if (controller.arrTrade[controller.selectedOrderIndex].exchangeName!.toLowerCase() == "mcx") {
                              var temp = (num.parse(controller.qtyController.text) * controller.arrTrade[controller.selectedOrderIndex].lotSize!);

                              print(temp);
                              if ((num.parse(controller.qtyController.text) % controller.arrTrade[controller.selectedOrderIndex].lotSize!) == 0) {
                                controller.lotSizeConverted.value = temp.toDouble();
                                controller.isValidQty.value = true;
                                var temp1 = (num.parse(controller.qtyController.text) / controller.arrTrade[controller.selectedOrderIndex].lotSize!);
                                controller.totalQuantity = temp1;
                              } else {
                                controller.isValidQty.value = false;
                              }
                            } else {
                              var temp = (num.parse(controller.qtyController.text) / controller.arrTrade[controller.selectedOrderIndex].lotSize!);

                              print(temp);

                              if ((num.parse(controller.qtyController.text) % controller.arrTrade[controller.selectedOrderIndex].lotSize!) == 0) {
                                controller.lotSizeConverted.value = temp;

                                var temp1 = num.parse(controller.qtyController.text);
                                controller.totalQuantity = temp1;
                                controller.isValidQty.value = true;
                              } else {
                                controller.isValidQty.value = false;
                              }
                            }
                          }
                        }
                      },
                      // fillColor: AppColors().headerBgColor,
                      keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                      isEnabled: true,
                      isOptional: false,
                      inValidMsg: AppString.emptyPassword,
                      placeHolderMsg: "",
                      labelMsg: "",
                      emptyFieldMsg: AppString.emptyPassword,
                      controller: controller.qtyController,
                      focus: controller.qtyFocus,
                      isSecure: false,
                      maxLength: 6,
                      keyboardButtonType: TextInputAction.done,
                    )
                  ],
                ),
              ),
            ),
            if (controller.selectedOptionBottomSheetTab != 0 && controller.selectedOptionBottomSheetTab != 3)
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 7, right: 15, left: 7.5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Price", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                          const Spacer(),
                          Text("Tick Size ${controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.ts.toString()}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // margin: const EdgeInsets.only(top: 10),
                        height: 6.h,
                        // width: 100.w,
                        child: CustomTextField(
                          type: 'Price',
                          regex: '[0-9.]',
                          onTap: () {
                            if (controller.buySellBottomSheetKey?.currentState?.expansionStatus == ExpansionStatus.contracted) {
                              controller.buySellBottomSheetKey?.currentState?.expand();
                            }
                          },
                          keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                          isEnabled: true,
                          isOptional: false,
                          inValidMsg: AppString.emptyPassword,
                          placeHolderMsg: "",
                          labelMsg: "",
                          emptyFieldMsg: AppString.emptyPassword,
                          controller: controller.priceController,
                          focus: controller.priceFocus,
                          isSecure: false,
                          maxLength: 8,
                          keyboardButtonType: TextInputAction.done,
                        ),
                      )
                    ],
                  ),
                ),
              )
          ],
        );
      }),
    );
  }

  Widget orderTypeInBottomSheet(BuildContext context, int index, Type value) {
    return Container(
      // height: 40.h,
      width: 22.w,
      height: 5.h,
      margin: EdgeInsets.only(left: index == 0 ? 10 : 0, right: index == constantValues!.orderType!.length - 1 ? 0 : 0),
      child: Obx(() {
        return Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 5.h,
                  // width: 10.w,
                  color: Colors.transparent,
                  margin: EdgeInsets.only(right: constantValues!.orderType!.length - 1 == index ? 10 : 5),
                  // decoration: BoxDecoration(
                  //     color: controller.selectedOptionBottomSheetTab == index ? AppColors().blueColor : Colors.transparent,
                  //     borderRadius: BorderRadius.circular(4),
                  //     border: Border.all(
                  //       color: controller.selectedOptionBottomSheetTab == index ? AppColors().blueColor : AppColors().grayBorderColor,
                  //       width: 1,
                  //     )),
                  child: Center(
                    child: Text(value.name ?? "", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: controller.selectedOptionBottomSheetTab == index ? AppColors().blueColor : AppColors().DarkText)),
                  ),
                ),
              ),
            ),
            if (controller.selectedOptionBottomSheetTab == index)
              Container(
                margin: EdgeInsets.only(right: constantValues!.orderType!.length - 1 == index ? 10 : 5),
                color: AppColors().blueColor,
                height: 2,
              )
          ],
        );
      }),
    );
  }
}
