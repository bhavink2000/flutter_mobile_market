import 'dart:async';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/openPositionScreen/openPositionController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../modelClass/constantModelClass.dart';
import '../../../../constant/font_family.dart';
import '../../../../main.dart';

class OpenPositionScreen extends BaseView<OpenPositionController> {
  const OpenPositionScreen({Key? key}) : super(key: key);

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
        headerTitle: "Open Position",
        backGroundColor: AppColors().headerBgColor,
      ),
      backgroundColor: AppColors().headerBgColor,
      body: Column(
        children: [
          // headerDropDown(),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 100.w,
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.only(top: controller.isTotalViewExpanded ? 27.h : 5.h),
                    width: 100.w,
                    decoration: BoxDecoration(color: AppColors().bgColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(10))),
                    child: Container(
                      margin: EdgeInsets.only(top: 0.h),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.isTotalViewExpanded = !controller.isTotalViewExpanded;
                      controller.update();
                    },
                    child: Column(
                      children: [
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.only(
                              top: 0.h,
                            ),
                            width: 90.w,
                            height: controller.isTotalViewExpanded ? 32.h : 11.h,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: AppColors().fontColor.withOpacity(0.12),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 2), // changes position of shadow
                              ),
                            ], color: AppColors().footerColor, borderRadius: const BorderRadius.all(Radius.circular(5))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 2.2.h,
                                ),
                                Text("Total", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                Text("${controller.totalPosition.value.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: Appfonts.family1Medium,
                                        color: controller.totalPosition.value > 0
                                            ? AppColors().blueColor
                                            : controller.totalPosition.value < 0
                                                ? AppColors().redColor
                                                : AppColors().fontColor)),
                                SizedBox(
                                  height: 3.5.h,
                                ),
                                Expanded(
                                  child: ListView(
                                    physics: const ClampingScrollPhysics(),
                                    clipBehavior: Clip.hardEdge,
                                    shrinkWrap: true,
                                    children: [
                                      sheetList("M2M P&L", "${controller.totalPosition.value.toStringAsFixed(2)}", 0),
                                      sheetList("Realised P&L", "${userData!.profitLoss!.toStringAsFixed(2)}", 1),
                                      sheetList("Credit", "${userData!.credit!.toStringAsFixed(2)}", 2),
                                      // sheetList("Equity", "74405.44", 3),
                                      sheetList("Margin Used", "${userData!.tradeBalance!.toStringAsFixed(2)}", 4),
                                      sheetList("Free Margin", "72845.44", 5),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Container(
                        //     width: 90.w,
                        //     height: 4.h,
                        //     margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(5), color: AppColors().bgColor, boxShadow: const []),
                        //     child: Row(
                        //       children: [
                        //         Image.asset(
                        //           AppImages.searchIcon,
                        //           width: 20,
                        //           height: 20,
                        //           color: AppColors().blueColor,
                        //         ),
                        //         SizedBox(
                        //           width: 2.w,
                        //         ),
                        //         SizedBox(
                        //           width: 70.w,
                        //           child: TextField(
                        //             onTapOutside: (event) {
                        //               // FocusScope.of(context).unfocus();
                        //             },
                        //             textCapitalization: TextCapitalization.sentences,
                        //             controller: controller.textController,
                        //             focusNode: controller.textFocus,
                        //             keyboardType: TextInputType.text,
                        //             textInputAction: TextInputAction.search,
                        //             minLines: 1,
                        //             maxLines: 1,
                        //             onSubmitted: (value) {
                        //               controller.getPositionList(value);
                        //             },
                        //             style: TextStyle(
                        //                 fontSize: 16.0, color: AppColors().fontColor, fontFamily: Appfonts.family1Medium),
                        //             decoration: InputDecoration(
                        //                 fillColor: Colors.transparent,
                        //                 filled: true,
                        //                 border: OutlineInputBorder(
                        //                     borderRadius: BorderRadius.circular(0.w), borderSide: BorderSide.none),
                        //                 contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        //                 focusedBorder:
                        //                     const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        //                 hintStyle: TextStyle(color: AppColors().placeholderColor),
                        //                 hintText: ""),
                        //           ),
                        //         ),
                        //         const Spacer(),
                        //         GestureDetector(
                        //           onTap: () {},
                        //           child: Image.asset(
                        //             AppImages.refreshIcon,
                        //             width: 20,
                        //             height: 20,
                        //             color: AppColors().blueColor,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Container(
                          height: 1,
                          width: 90.w,
                          color: AppColors().grayLightLine,
                        ),
                        Expanded(
                            child: controller.isApiCall
                                ? displayIndicator()
                                : controller.isApiCall == false && controller.arrPositionScriptList.isEmpty
                                    ? dataNotFoundView("Data not found")
                                    : ListView.builder(
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        clipBehavior: Clip.hardEdge,
                                        itemCount: controller.arrPositionScriptList.length,
                                        controller: controller.listcontroller,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return listContentView(context, index);
                                        })),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget listContentView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        // controller.selectedScript = controller.arrPositionScriptList[index].obs;
        // displyMoreOptionBootomSheet();
      },
      child: Container(
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
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("${controller.arrPositionScriptList[index].exchangeName} ${controller.arrPositionScriptList[index].symbolName}, ", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family2, color: AppColors().DarkText)),
                            Text(controller.arrPositionScriptList[index].tradeTypeValue!.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: Appfonts.family2,
                                  color: controller.arrPositionScriptList[index].tradeType == "buy" ? AppColors().blueColor : AppColors().redColor,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            "${double.parse(controller.arrPositionScriptList[index].price!.toStringAsFixed(2))} -> ${controller.arrPositionScriptList[index].tradeType == "buy" ? controller.arrPositionScriptList[index].scriptDataFromSocket.value.ask! : controller.arrPositionScriptList[index].scriptDataFromSocket.value.bid!}",
                            style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText))
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(double.parse(controller.arrPositionScriptList[index].profitLossValue!.toStringAsFixed(2)).toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: Appfonts.family1Medium,
                                color: controller.getPriceColor(
                                  controller.arrPositionScriptList[index].profitLossValue!,
                                ))),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        Text("", textAlign: TextAlign.end, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                        // Text(
                        //     controller.arrPositionScriptList[index].quantity
                        //         .toString(),
                        //     textAlign: TextAlign.end,
                        //     style: TextStyle(
                        //         fontSize: 12,
                        //         fontFamily: Appfonts.family1Regular,
                        //         color: AppColors().DarkText)),
                      ],
                    ),
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

  Widget sheetList(String name, String value, int index) {
    Color backgroundColor = AppColors().contentBg;
    return Container(
      width: 100.w,
      height: 38,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: Row(
          children: [
            Text(name.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Text(value.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
          ],
        ),
      ),
    );
  }

  Widget orderTypeInBottomSheet(BuildContext context, int index, Type value) {
    return Container(
      // height: 40.h,
      width: 31.5.w,
      height: 5.h,
      margin: EdgeInsets.only(left: index == 0 ? 20 : 0, right: index == constantValues!.orderType!.length - 1 ? 20 : 0),
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.selectedOrderType = constantValues!.orderType![index];
                  controller.selectedOptionBottomSheetTab.value = index;
                },
                child: Container(
                  height: 5.h,
                  // width: 10.w,
                  margin: EdgeInsets.only(right: constantValues!.orderType!.length - 1 == index ? 20 : 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: controller.selectedOptionBottomSheetTab == index ? AppColors().blueColor : AppColors().grayBorderColor, width: 1)),
                  child: Center(
                    child: Text(value.name ?? "", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: controller.selectedOptionBottomSheetTab == index ? AppColors().blueColor : AppColors().lightOnlyText)),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget qtyPriceView() {
    return Container(
      // height: 40.h,
      width: 89.w,
      height: 12.h,
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
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Quantity", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                        const Spacer(),
                        Text("Lot Size ${controller.selectedScript!.value!.lotSize!.toString()}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 5.h,
                      child: CustomTextField(
                        type: 'Quantity',
                        regex: '[0-9]',
                        onTap: () {
                          if (controller.buySellBottomSheetKey?.currentState?.expansionStatus == ExpansionStatus.contracted) {
                            controller.buySellBottomSheetKey?.currentState?.expand();
                          }
                        },
                        // fillColor: AppColors().headerBgColor,
                        keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                        isEnabled: true,
                        isOptional: false,
                        inValidMsg: AppString.emptyPassword,
                        placeHolderMsg: "Quantity",
                        labelMsg: "Quantity",
                        emptyFieldMsg: AppString.emptyPassword,
                        controller: controller.qtyController,
                        focus: controller.qtyFocus,
                        isSecure: false,
                        maxLength: 6,
                        keyboardButtonType: TextInputAction.done,
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (controller.selectedOptionBottomSheetTab > 0)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Price", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                          const Spacer(),
                          Text(
                              // "Tick Size ${controller.selectedScript!.value!.ts!.toString()}",
                              "Tick Val",
                              style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 5.h,
                        width: 100.w,
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
                          placeHolderMsg: "Price",
                          labelMsg: "Price",
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

  displyMoreOptionBootomSheet() {
    // GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
    controller.buySellBottomSheetKey = GlobalKey();
    Future.delayed(Duration(milliseconds: 100), () {
      controller.buySellBottomSheetKey?.currentState?.expand();
    });
    Get.bottomSheet(
        PopScope(
          canPop: false,
          onPopInvoked: (canpop) {},
          child: StatefulBuilder(builder: (context, stateSetter) {
            return Container(
              height: 90.h,
              width: 100.w,
              decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: AppColors().bgColor),
              child: SingleChildScrollView(
                // physics: ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(controller.selectedScript?.value?.symbolName ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                Spacer(),
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
                            Row(
                              children: [
                                Text(controller.selectedScript!.value!.price.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Appfonts.family1Medium,
                                        color: controller.selectedScript!.value!.scriptDataFromSocket.value.ch != null
                                            ? controller.getPriceColor(
                                                controller.selectedScript!.value!.scriptDataFromSocket.value.ch!.toDouble(),
                                              )
                                            : AppColors().DarkText)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("${controller.selectedScript!.value!.scriptDataFromSocket.value.ch ?? ""}(${controller.selectedScript!.value!.scriptDataFromSocket.value.chp ?? ""}%)", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                    Container(
                      height: 1,
                      width: 100.w,
                      color: AppColors().grayLightLine,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: SizedBox(
                        height: 5.h,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
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
                    const SizedBox(
                      height: 15,
                    ),
                    Center(child: qtyPriceView()),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 42.w,
                          child: CustomButton(
                            isEnabled: true,
                            shimmerColor: AppColors().whiteColor,
                            title: "Buy",
                            textSize: 16,
                            prefixHeight: 22,
                            onPress: () {
                              // controller.qtyController.text = "";
                              // controller.priceController.text = "";
                              var msg = controller.validateForm();
                              if (msg.isEmpty) {
                                Get.back();
                                controller.isForBuy = true;
                                // buySellBottomSheet(true);
                                controller.initiateTrade(stateSetter);
                              } else {
                                showWarningToast(msg, controller.globalContext!);
                              }
                            },
                            bgColor: AppColors().blueColor,
                            isFilled: true,
                            textColor: AppColors().whiteColor,
                            isTextCenter: true,
                            isLoading: false,
                          ),
                        ),
                        SizedBox(
                          width: 42.w,
                          child: CustomButton(
                            isEnabled: true,
                            shimmerColor: AppColors().whiteColor,
                            title: "Sell",
                            textSize: 16,
                            prefixHeight: 22,
                            onPress: () {
                              // controller.qtyController.text = "";
                              // controller.priceController.text = "";
                              var msg = controller.validateForm();
                              if (msg.isEmpty) {
                                Get.back();
                                controller.isForBuy = false;
                                // buySellBottomSheet(false);
                                controller.initiateTrade(stateSetter);
                              } else {
                                showWarningToast(msg, controller.globalContext!);
                              }
                            },
                            bgColor: AppColors().redColor,
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
                                    color: AppColors().blueColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("View Chart", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    AppImages.arrowRight,
                                    width: 20,
                                    height: 20,
                                    color: AppColors().blueColor,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
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
                    const SizedBox(
                      height: 15,
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
                                        Text("Open", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                        Text("${controller.selectedScript!.value!.scriptDataFromSocket.value.open ?? "-"}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("High", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                        Text("${controller.selectedScript!.value!.scriptDataFromSocket.value.high ?? "-"}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("Low", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                        Text("${controller.selectedScript!.value!.scriptDataFromSocket.value.low ?? "-"}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("Prev. close", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                        Text("${controller.selectedScript!.value!.scriptDataFromSocket.value.close ?? "-"}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Obx(() {
                              return controller.selectedScript!.value!.scriptDataFromSocket.value.depth == null
                                  ? SizedBox()
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 43.w,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Bid", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                    Spacer(),
                                                    Text("Order", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                    Spacer(),
                                                    Text("Qty", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  child: ListView.builder(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    clipBehavior: Clip.hardEdge,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    itemCount: controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.buy!.length,
                                                    itemBuilder: (context, index) {
                                                      return bottomSheetList((controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.buy![index].price ?? 0).toString(), (controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.buy![index].orders ?? 0).toString(),
                                                          (controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.buy![index].quantity ?? 0).toString(), AppColors().blueColor, 0);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Text("Total", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                                                      Spacer(),
                                                      Text(controller.getTotal(true).toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 43.w,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Offer", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                    Spacer(),
                                                    Text("Order", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                    Spacer(),
                                                    Text("Qty", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  child: ListView.builder(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    clipBehavior: Clip.hardEdge,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    itemCount: controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.sell!.length,
                                                    itemBuilder: (context, index) {
                                                      return bottomSheetList((controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.sell![index].price ?? 0).toString(), (controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.sell![index].orders ?? 0).toString(),
                                                          (controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.sell![index].quantity ?? 0).toString(), AppColors().blueColor, 0);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Text("Total", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().redColor)),
                                                      Spacer(),
                                                      Text(controller.getTotal(false).toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().redColor)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            }),
                            const SizedBox(
                              height: 0,
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
                            Obx(() {
                              return ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                clipBehavior: Clip.hardEdge,
                                shrinkWrap: true,
                                controller: controller.sheetController,
                                children: [
                                  sheetList("Lot Size", controller.selectedScript!.value!.lotSize!.toString(), 0),
                                  sheetList("LTP", controller.selectedScript!.value!.price!.toString(), 1),
                                  sheetList("Volume", controller.selectedScript!.value!.quantity!.toString(), 2),
                                  sheetList("Avg. Price", "Key Not found", 3),
                                  sheetList("Time", shortTime(DateTime.now()), 4)
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    )
                  ],
                ),
              ),
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
          }),
        ),
        isDismissible: true,
        isScrollControlled: true,
        enableDrag: true);
  }

  Widget bottomSheetList(String bid, String order, String Qty, Color fontColors, int index) {
    return Container(
      // width: 100.w,
      height: 20,
      child: Row(
        children: [
          Text(bid.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: fontColors)),
          Spacer(),
          Text(order.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: fontColors)),
          Spacer(),
          Text(Qty.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: fontColors)),
        ],
      ),
    );
  }
}
