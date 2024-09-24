import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/commonFunction.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/TradeMarginScreen/tradeMarginController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../constant/commonWidgets.dart';
import '../../../../../../constant/utilities.dart';

class TradeMarginScreen extends BaseView<TradeMarginController> {
  const TradeMarginScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          return Future.value(false);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
              headerTitle: "Trade Margin Setting",
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
            child: Column(children: [
              searchView(),
              // exchangeDetailView(),
              // btnField(),
              controller.isFirstCallRunning
                  ? Expanded(child: displayIndicator())
                  : Expanded(
                      flex: 8,
                      child: mainContent(context),
                    )
            ]),
          ),
        ));
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
                      // onChanged: (value) {
                      //   controller.arrUserListData.clear();
                      //   controller.arrUserListData.addAll(controller.arrMainScript);
                      //   controller.arrUserListData.retainWhere((scriptObj) {
                      //     return scriptObj.userName!.toLowerCase().contains(value.toLowerCase());
                      //   });
                      //   controller.update();
                      // },
                      textInputAction: TextInputAction.search,
                      // onEditingComplete: () {
                      //   FocusManager.instance.primaryFocus?.unfocus();
                      //   controller.currentPage = 1;
                      //   controller.userWiseBrkList(isFromFilter: true);
                      // },
                      // onChanged: (value) {
                      //   controller.currentPage = 1;
                      //   controller.userWiseBrkList(isFromFilter: true);
                      // },
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

  Widget exchangeDetailView() {
    return Container(
      width: 100.w,
      // height: 6.5.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Container(
        height: 6.5.h,
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
                alignment: AlignmentDirectional.center,
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
                  'Select Exchange',
                  maxLines: 1,
                  style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
                ),
                items: arrExchangeList
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
                  return arrExchangeList
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
                  // setState(()
                  controller.selectExchangedropdownValue.value = value!;
                  controller.update();
                  // });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  // height: 54,
                  // width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 54,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget btnField() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              isEnabled: true,
              // buttonHeight: 6.5.h,
              shimmerColor: AppColors().whiteColor,
              title: "View",
              textSize: 16,
              onPress: () {
                Get.back();
                controller.tradeMarginList(isFromFilter: true);
              },
              bgColor: AppColors().blueColor,
              isFilled: true,
              textColor: AppColors().whiteColor,
              isTextCenter: true,
              isLoading: controller.isApiCallRunning,
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
              title: "Clear",
              textSize: 16,
              // buttonHeight: 6.5.h,
              onPress: () {
                controller.searchController.clear();
                Get.back();
                controller.selectExchangedropdownValue.value = ExchangeData();
                controller.tradeMarginList(isFromFilter: true, isFromClear: true);
              },
              bgColor: AppColors().grayLightLine,
              isFilled: true,
              textColor: AppColors().DarkText,
              isTextCenter: true,
              isLoading: controller.isClearApiCallRunning,
            ),
          ),
        ],
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
              vertical: 31.h,
            ),
            content: Column(
              children: [
                exchangeDetailView(),
                btnField(),
              ],
            )));
  }

  Widget mainContent(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: 257.w,
        margin: EdgeInsets.only(right: 5.w, left: 5.w),
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
              child: controller.isApiCallRunning == false && controller.isClearApiCallRunning == false && controller.arrTradeMargin.isEmpty
                  ? dataNotFoundView("Trade margin not found")
                  : PaginableListView.builder(
                      loadMore: () async {
                        if (controller.totalPage >= controller.currentPage) {
                          //print(controller.currentPage);
                          controller.tradeMarginList();
                        }
                      },
                      errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                      progressIndicatorWidget: displayIndicator(),
                      physics: const ClampingScrollPhysics(),
                      clipBehavior: Clip.hardEdge,
                      itemCount: controller.isApiCallRunning || controller.isClearApiCallRunning ? 50 : controller.arrTradeMargin.length,
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
    if (controller.isApiCallRunning || controller.isClearApiCallRunning) {
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
      var tradeValue = controller.arrTradeMargin[index];
      return GestureDetector(
        onTap: () {
          // controller.selectedScriptIndex = index;
          controller.update();
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // valueBox("", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, Colors.transparent, index,
              //     isImage: true, strImage: AppImages.checkBox, isSmall: true),

              valueBox(
                tradeValue.exchangeName ?? "",
                22.w,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                tradeValue.symbolTitle ?? "",
                40.w,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                shortFullDateTime(tradeValue.expiryDate!),
                40.w,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                tradeValue.tradeMargin!.toString() + "%",
                30.w,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                tradeValue.tradeMarginAmount!.toString(),
                30.w,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                tradeValue.symbolName ?? "--",
                40.w,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                (tradeValue.tradeAttribute ?? "").toUpperCase(),
                30.w,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox((tradeValue.allowTradeValue ?? "").toUpperCase(), 25.w, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
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
        // titleBox("", 0),

        // titleBox("", isImage: true, strImage: AppImages.checkBox),
        titleBox("Exchange", width: 22.w),
        titleBox("Script", width: 40.w),
        titleBox("Expiry Date", width: 40.w),
        titleBox("Trade Margin", width: 30.w),
        titleBox("Margin Amount", width: 30.w),
        titleBox("Description", width: 40.w),
        titleBox("Trade Attribute", width: 30.w),
        titleBox("Allow Trade", width: 25.w),
      ],
    );
  }
}
