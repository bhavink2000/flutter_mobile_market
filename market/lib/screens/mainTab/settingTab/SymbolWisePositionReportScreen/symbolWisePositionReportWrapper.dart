import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/screens/mainTab/settingTab/SymbolWisePositionReportScreen/symbolWisePositionReportController.dart';

import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constant/color.dart';
import '../../../../constant/commonWidgets.dart';
import '../../../../constant/utilities.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../BaseViewController/baseController.dart';

class SymbolWisePositionReportScreen extends BaseView<SymbolWisePositionReportController> {
  const SymbolWisePositionReportScreen({Key? key}) : super(key: key);

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
        headerTitle: "Symbol Wise Position Report",
        backGroundColor: AppColors().headerBgColor,
      ),
      body: mainContent(context),
    );
  }

  Widget mainContent(BuildContext context) {
    return Column(
      children: [
        // weekSelectiondropDownView(),
        // if (controller.selectStatusdropdownValue == "Custom Period") toAndFromDateBtnView(),
        SizedBox(
          height: 20,
        ),
        exchangeSelection(),
        scriptSelection(),
        buttonsView(),
        Expanded(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 1500,
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
                          totalContent(value: "Total :", textColor: AppColors().DarkText, width: 330),
                          totalContent(value: "Net Qty % Wise : " + controller.netQtyPerTotal.value.toStringAsFixed(2), textColor: AppColors().DarkText, width: 180),
                          totalContent(value: "", textColor: AppColors().DarkText, width: 50),
                          totalContent(value: "Brokerage : " + controller.brkTotal.value.toStringAsFixed(2), textColor: AppColors().DarkText, width: 150),
                          totalContent(value: "", textColor: AppColors().DarkText, width: 240),
                          totalContent(value: "P/L : " + controller.plTotal.value.toStringAsFixed(2), textColor: AppColors().DarkText, width: 150),
                          totalContent(value: "P/L (%) :" + controller.plPerTotal.toStringAsFixed(2), textColor: AppColors().DarkText, width: 150),
                          totalContent(value: "Brokerage % : " + controller.brkPerTotal.toStringAsFixed(2), textColor: AppColors().DarkText, width: 170),
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
          ),
        ),
      ],
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
              valueBox(scriptValue.exchangeName ?? "", 100, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(
                scriptValue.symbolTitle ?? "",
                150,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(scriptValue.totalQuantity!.toString(), 80, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index, onClickValue: () {
                // isCommonScreenPopUpOpen = true;
                // Get.find<MainContainerController>().isInitCallRequired = false;
                // currentOpenedScreen = ScreenViewNames.clientAccountReport;
                // var tradeVC = Get.put(ClientAccountReportController());
                // tradeVC.selectedExchange.value = ExchangeData(exchangeId: controller.arrSummaryList[index].exchangeId, name: controller.arrSummaryList[index].exchangeName);
                // tradeVC.selectedScriptFromFilter.value = GlobalSymbolData(symbolId: controller.arrSummaryList[index].symbolId, symbolName: controller.arrSummaryList[index].symbolName, symbolTitle: controller.arrSummaryList[index].symbolTitle);
                // // tradeVC.update();
                // // tradeVC.getTradeList();

                // tradeVC.isPagingApiCall = false;
                // tradeVC.getAccountSummaryNewList("");
                // tradeVC.isPagingApiCall = true;
                // Get.find<MainContainerController>().isInitCallRequired = true;
                // Get.delete<SymbolWisePositionReportController>();
                // Get.back();

                // generalContainerPopup(view: ClientAccountReportScreen(), title: ScreenViewNames.clientAccountReport);
              }),
              valueBox(scriptValue.totalShareQuantity!.toStringAsFixed(2), 130, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.totalQuantity! != 0 ? scriptValue.avgPrice!.toStringAsFixed(2) : "0.00", 100, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.brokerageTotal!.toStringAsFixed(2), 100, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(
                scriptValue.totalQuantity! != 0
                    ? scriptValue.brokerageTotal! > 0
                        ? (scriptValue.avgPrice! + (scriptValue.brokerageTotal! / scriptValue.totalQuantity!)).toStringAsFixed(2)
                        : scriptValue.avgPrice!.toStringAsFixed(2)
                    : "0.00",
                210,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(scriptValue.currentPriceFromSocket!.toStringAsFixed(2), 80, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.profitLossValue!.toStringAsFixed(2), 100, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox((((scriptValue.profitLossValue! * scriptValue.profitAndLossSharing!) / 100) * -1).toStringAsFixed(2), 80, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(scriptValue.adminBrokerageTotal!.toStringAsFixed(2), 120, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
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
        titleBox("EXCHANGE", width: 100),
        titleBox("SYMBOL", width: 150),
        titleBox("NET QTY", width: 80),
        titleBox("NET QTY % WISE", width: 130),
        titleBox("NET A PRICE", width: 100),
        titleBox("BROKERAGE", width: 100),
        titleBox("WITH BROKERAGE A PRICE", width: 210),
        titleBox("CMP", width: 80),
        titleBox("P/L", width: 100),
        titleBox("P/L (%)", width: 80),
        titleBox("BROKERAGE %", width: 120),
      ],
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
                title: controller.fromDate == "" ? "From Date" : controller.fromDate.toString(),
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
                title: controller.toDate == "" ? "To Date" : controller.toDate.toString(),
                textSize: 14,
                onPress: () {
                  // _selectToDate(Get.context!);
                  _selectToDate(Get.context!, DateTime.parse(controller.fromDate));
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
      controller.fromDate = formattedDate;
      controller.update();
      _selectToDate(context, DateTime.parse(controller.fromDate));
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
            width: 35.w,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Reset",
              textSize: 16,
              onPress: () {
                controller.fromDate = "";
                controller.toDate = "";
                controller.currentPage = 1;
                controller.selectExchangedropdownValue.value = ExchangeData();
                controller.selectedScriptDropDownValue.value = GlobalSymbolData();
                controller.update();
                controller.getAccountSummaryNewList("", isFromClear: true, isFromfilter: true);
              },
              bgColor: AppColors().grayLightLine,
              isFilled: true,
              textColor: AppColors().DarkText,
              isTextCenter: true,
              isLoading: controller.isResetCall,
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
                controller.getAccountSummaryNewList("", isFromfilter: true);
              },
              bgColor: AppColors().blueColor,
              isFilled: true,
              textColor: AppColors().whiteColor,
              isTextCenter: true,
              isLoading: controller.isApiCallRunning,
            ),
          ),
          // SizedBox(width: 5.w,),
        ],
      ),
    );
  }
}
