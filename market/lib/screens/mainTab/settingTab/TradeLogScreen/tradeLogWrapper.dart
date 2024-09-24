import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/color.dart';
import '../../../../constant/commonWidgets.dart';
import '../../../../constant/font_family.dart';
import '../../../../constant/utilities.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../BaseViewController/baseController.dart';
import 'tradeLogController.dart';

class TradeLogScreen extends BaseView<TradeLogController> {
  const TradeLogScreen({Key? key}) : super(key: key);

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
        headerTitle: "Trade Logs",
        backGroundColor: AppColors().headerBgColor,
      ),
      body: GestureDetector(
        onTap: () {
          // controller.focusNode.requestFocus();
        },
        child: Column(
          children: [
            searchView(),
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

  Widget searchView() {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors().bgColor,
        ),
        child: Column(
          children: [
            Container(
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
                      controller: controller.searchController,
                      focusNode: controller.searchFocus,
                      keyboardType: TextInputType.text,
                      minLines: 1,
                      maxLines: 1,
                      textInputAction: TextInputAction.search,
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
                          hintText: "Search"),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 1,
            //   width: 100.w,
            //   color: AppColors().grayLightLine,
            // ),
          ],
        ),
      ),
    );
  }

  Widget mainContent(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 220.w,
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
              child: controller.isApiCallRunning == false && controller.arrTrade.isEmpty
                  ? dataNotFoundView("Trade Logs not found")
                  : PaginableListView.builder(
                      loadMore: () async {
                        if (controller.totalPage >= controller.currentPage) {
                          //print(controller.currentPage);
                          controller.getTradeList();
                        }
                      },
                      errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                      progressIndicatorWidget: displayIndicator(),
                      physics: const ClampingScrollPhysics(),
                      clipBehavior: Clip.hardEdge,
                      itemCount: controller.isApiCallRunning ? 50 : controller.arrTrade.length,
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
    );
  }

  Widget tradeContent(BuildContext context, int index) {
    // var scriptValue = controller.arrUserOderList[index];
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
      return GestureDetector(
        onTap: () {
          controller.selectedOrderIndex = index;
          controller.update();
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent, border: Border.all(width: 1, color: controller.selectedOrderIndex == index ? AppColors().DarkText : Colors.transparent)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              valueBox(controller.arrTrade[index].userName ?? "", 25.w, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(controller.arrTrade[index].exchangeName ?? "", 25.w, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(controller.arrTrade[index].symbolTitle ?? "", 35.w, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(controller.arrTrade[index].oldOrderTypeValue ?? "", 35.w, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(controller.arrTrade[index].orderTypeValue ?? "", 30.w, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(shortFullDateTime(controller.arrTrade[index].updatedAt!), 38.w, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(controller.arrTrade[index].userUpdatedName ?? "", 30.w, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
            ],
          ),
        ),
      );
    }
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
                horizontal: 0.w,
                vertical: 16.h,
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
                  GestureDetector(
                    onTap: () {
                      _selectFromDate(Get.context!);
                    },
                    child: Obx(() {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15, top: 15),
                        height: 6.5.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors().grayLightLine,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(3)),
                        // color: AppColors().whiteColor,
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              controller.fromDateStr.value,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: Appfonts.family1Medium,
                                color: AppColors().DarkText,
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              AppImages.calendarIcon,
                              width: 25,
                              height: 25,
                              color: AppColors().fontColor,
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectToDate(Get.context!);
                    },
                    child: Obx(() {
                      return Container(
                        // margin: EdgeInsets.only(bottom: 15),
                        height: 6.5.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors().grayLightLine,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(3)),
                        // color: AppColors().whiteColor,
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              controller.endDateStr.value,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: Appfonts.family1Medium,
                                color: AppColors().DarkText,
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              AppImages.calendarIcon,
                              width: 25,
                              height: 25,
                              color: AppColors().fontColor,
                            )
                          ],
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
                  ),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 15),
                  //   height: 6.5.h,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: AppColors().grayLightLine,
                  //         width: 1.5,
                  //       ),
                  //       borderRadius: BorderRadius.circular(3)),
                  //   // color: AppColors().whiteColor,
                  //   padding: const EdgeInsets.only(right: 10),
                  //   child: Obx(() {
                  //     return Center(
                  //       child: DropdownButtonHideUnderline(
                  //         child: DropdownButton2<Type>(
                  //           isExpanded: true,
                  //           iconStyleData: IconStyleData(
                  //             icon: Image.asset(
                  //               AppImages.arrowDown,
                  //               height: 25,
                  //               width: 25,
                  //               color: AppColors().fontColor,
                  //             ),
                  //           ),
                  //           hint: Text(
                  //             'Select Order Type',
                  //             style: TextStyle(
                  //               fontSize: 14,
                  //               fontFamily: Appfonts.family1Medium,
                  //               color: AppColors().DarkText,
                  //             ),
                  //           ),
                  //           items: constantValues!.orderTypeFilter!
                  //               .map((Type item) => DropdownMenuItem<Type>(
                  //                     value: item,
                  //                     child: Text(
                  //                       item.name ?? "",
                  //                       style: TextStyle(
                  //                         fontSize: 14,
                  //                         fontFamily: Appfonts.family1Medium,
                  //                         color: AppColors().DarkText,
                  //                       ),
                  //                     ),
                  //                   ))
                  //               .toList(),
                  //           selectedItemBuilder: (context) {
                  //             return constantValues!.orderTypeFilter!
                  //                 .map((Type item) => DropdownMenuItem<Type>(
                  //                       value: item,
                  //                       child: Text(
                  //                         item.name ?? "",
                  //                         style: TextStyle(
                  //                           fontSize: 14,
                  //                           fontFamily: Appfonts.family1Medium,
                  //                           color: AppColors().DarkText,
                  //                         ),
                  //                       ),
                  //                     ))
                  //                 .toList();
                  //           },
                  //           value: controller.selectedOrderType.value.id != null ? controller.selectedOrderType.value : null,
                  //           onChanged: (Type? value) {
                  //             // setState(() {
                  //             controller.selectedOrderType.value = value!;
                  //             controller.update();
                  //             // });
                  //           },
                  //           buttonStyleData: const ButtonStyleData(
                  //             padding: EdgeInsets.symmetric(horizontal: 0),
                  //             height: 40,
                  //             // width: 140,
                  //           ),
                  //           menuItemStyleData: const MenuItemStyleData(
                  //             height: 40,
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   }),
                  // ),
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
                            controller.fromDateStr.value = "Start Date";
                            controller.endDateStr.value = "End Date";
                            controller.fromDate = null;
                            controller.toDate = null;
                            controller.selectUserDropdownValue.value = UserData();
                            controller.selectExchangedropdownValue.value = ExchangeData();
                            controller.selectedScriptDropDownValue.value = GlobalSymbolData();
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
                            controller.arrTrade.clear();
                            controller.getTradeList();
                            controller.selectUserDropdownValue.value = UserData();
                            controller.selectExchangedropdownValue.value = ExchangeData();
                            controller.selectedScriptDropDownValue.value = GlobalSymbolData();
                            controller.fromDateStr.value = "Start Date";
                            controller.endDateStr.value = "End Date";
                            controller.fromDate = null;
                            controller.toDate = null;
                            controller.update();
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
            ));
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.fromDate != null
          ? controller.fromDate!
          : controller.toDate != null
              ? controller.toDate!
              : DateTime.now(),
      lastDate: controller.toDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      helpText: 'Select From Date',
      cancelText: 'Cancel',
      confirmText: 'Done',
      // locale: Locale('en', 'US'),
    );

    if (picked != null) {
      // Format the DateTime to display only the date portion
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      print(formattedDate);

      controller.fromDate = picked;
      controller.fromDateStr.value = formattedDate;
      controller.update();
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: controller.toDate != null
            ? controller.toDate!
            : controller.fromDate != null
                ? controller.fromDate!
                : DateTime.now(),
        lastDate: DateTime.now(),
        firstDate: controller.fromDate != null ? controller.fromDate! : DateTime.now().subtract(Duration(days: 365)),
        helpText: 'Select To Date',
        cancelText: 'Cancel',
        confirmText: 'Done',
        // locale: Locale('en', 'US'),
      );

      if (picked != null) {
        // Format the DateTime to display only the date portion
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        print(formattedDate);
        controller.toDate = picked.add(Duration(days: 1));

        controller.endDateStr.value = formattedDate;
        controller.update();
      }
    } catch (e) {
      print(e);
    }
  }

  Widget listTitleContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // titleBox("", 0),
        titleBox("User Name", width: 25.w),
        titleBox("Exchange", width: 25.w),
        titleBox("Symbol", width: 35.w),
        titleBox("Old Update Type", width: 35.w),
        titleBox("Update Type", width: 30.w),
        titleBox("Update Time", width: 38.w),
        titleBox("Modify By", width: 30.w),
      ],
    );
  }
}
