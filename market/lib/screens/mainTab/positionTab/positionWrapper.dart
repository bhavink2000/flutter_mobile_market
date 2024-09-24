import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/main.dart';
import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../modelClass/constantModelClass.dart';
import '../../../../../constant/color.dart';

import '../../../constant/assets.dart';
import '../../../constant/font_family.dart';
import '../../../customWidgets/appNavigationBar.dart';
import '../../../modelClass/squareOffPositionRequestModelClass.dart';
import '../../../navigation/routename.dart';
import '../../BaseViewController/baseController.dart';
import 'positionController.dart';

class positionScreen extends BaseView<positionController> {
  const positionScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: appNavigationBar(
        isTrailingDisplay: true,
        isMarketDisplay: true,
        leadingTitleText: "Position",
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
      ),
      backgroundColor: AppColors().headerBgColor,
      body: RefreshIndicator(
        color: AppColors().blueColor,
        onRefresh: () async {
          try {
            controller.currentPage = 1;
            controller.getPositionList("", isFromRefresh: true);
          } catch (e) {}
        },
        child: Column(
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
                          totalView(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 90.w,
                              height: 4.h,
                              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
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
                                    width: 50.w,
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
                                        controller.currentPage = 1;
                                        controller.getPositionList(value, isFromRefresh: true);
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
                                      controller.currentPage = 1;
                                      controller.getPositionList("", isFromRefresh: true);
                                    },
                                    child: Image.asset(
                                      AppImages.refreshIcon,
                                      width: 20,
                                      height: 20,
                                      color: AppColors().blueColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      customButton: Icon(
                                        Icons.more_vert_outlined,
                                        size: 30,
                                        color: AppColors().blueColor,
                                      ),
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: "Squareoff",
                                          child: Text("Squareoff", style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1SemiBold, color: controller.isSelectedForSquareOff.value ? AppColors().redColor : AppColors().blueColor)),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "Rollover",
                                          child: Text("Rollover", style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1SemiBold, color: controller.isSelectedForRollOver.value ? AppColors().redColor : AppColors().blueColor)),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        switch (value) {
                                          case "Squareoff":
                                            controller.isSelectedForSquareOff.value = !controller.isSelectedForSquareOff.value;
                                            controller.isSelectedForRollOver.value = false;
                                            controller.arrPositionScriptList.forEach((element) {
                                              element.isSelected = true;
                                            });
                                            controller.update();
                                            break;
                                          case "Rollover":
                                            controller.isSelectedForRollOver.value = !controller.isSelectedForRollOver.value;
                                            controller.isSelectedForSquareOff.value = false;
                                            controller.arrPositionScriptList.forEach((element) {
                                              element.isSelected = true;
                                            });
                                            controller.update();
                                            break;
                                          default:
                                        }
                                      },
                                      dropdownStyleData: DropdownStyleData(
                                        width: 160,
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: AppColors().whiteColor,
                                        ),
                                        offset: const Offset(0, 8),
                                      ),
                                    ),
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
                              child: controller.isRefreshCall
                                  ? displayIndicator()
                                  : controller.arrPositionScriptList.isEmpty
                                      ? dataNotFoundView("Positions not found")
                                      : controller.isRefreshCall
                                          ? displayIndicator()
                                          : PaginableListView.builder(
                                              loadMore: () async {
                                                if (controller.totalPage >= controller.currentPage) {
                                                  print(controller.currentPage);
                                                  controller.getPositionList("");
                                                }
                                              },
                                              errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                                              progressIndicatorWidget: displayIndicator(),
                                              physics: const AlwaysScrollableScrollPhysics(),
                                              clipBehavior: Clip.hardEdge,
                                              itemCount: controller.arrPositionScriptList.length,
                                              controller: controller.listcontroller,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return listContentView(context, index);
                                              })),
                          if (controller.isSelectedForRollOver.value || controller.isSelectedForSquareOff.value)
                            Container(
                              height: 30,
                              width: 90.w,
                              color: AppColors().contentBg,
                              child: GestureDetector(
                                onTap: () {
                                  if (controller.isSelectedForSquareOff.value) {
                                    showPermissionDialog(
                                        message: "Are you sure you want to square off selected position?",
                                        acceptButtonTitle: "Yes",
                                        rejectButtonTitle: "No",
                                        yesClick: () {
                                          List<SymbolRequestData> arrSquare = [];
                                          for (var element in controller.arrPositionScriptList) {
                                            if (element.isSelected) {
                                              var price = element.totalQuantity! < 0 ? element.bid!.toStringAsFixed(2).toString() : element.ask!.toStringAsFixed(2).toString();
                                              var temp = SymbolRequestData(exchangeId: element.exchangeId!, symbolId: element.symbolId!, price: price);
                                              arrSquare.add(temp);
                                            }
                                          }

                                          if (arrSquare.length > 0) {
                                            Get.back();
                                            controller.squareOffPosition(arrSquare);
                                          } else {
                                            showWarningToast("Please select position", controller.globalContext!);
                                          }
                                        },
                                        noclick: () {
                                          Get.back();
                                        });
                                  } else if (controller.isSelectedForRollOver.value) {
                                    showPermissionDialog(
                                        message: "Are you sure you want to Roll over selected position?",
                                        acceptButtonTitle: "Yes",
                                        rejectButtonTitle: "No",
                                        yesClick: () {
                                          Get.back();
                                          List<SymbolRequestData> arrSquare = [];
                                          for (var element in controller.arrPositionScriptList) {
                                            if (element.isSelected) {
                                              var price = element.totalQuantity! < 0 ? element.ask!.toStringAsFixed(2).toString() : element.bid!.toStringAsFixed(2).toString();
                                              var temp = SymbolRequestData(exchangeId: element.exchangeId!, symbolId: element.symbolId!, price: price);
                                              arrSquare.add(temp);
                                            }
                                          }
                                          if (arrSquare.length > 0) {
                                            controller.rollOverPosition(arrSquare);
                                          } else {
                                            showWarningToast("Please select position", controller.globalContext!);
                                          }
                                        },
                                        noclick: () {
                                          Get.back();
                                        });
                                  }
                                },
                                child: Center(child: Text(controller.isSelectedForRollOver.value ? "Rollover Selected Position" : "Squareoff Selected Position", style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1SemiBold, color: AppColors().redColor))),
                              ),
                            ),
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget totalView() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: controller.isTotalViewExpanded ? 210 : 62,
      width: 92.5.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(color: AppColors().postionTotalBox, borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: ClipRRect(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                controller.isTotalViewExpanded = !controller.isTotalViewExpanded;
                controller.update();
              },
              child: Container(
                width: 100.w,
                color: AppColors().postionTotalDetailsBox,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text("Total", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                        ),
                        Spacer(),
                        Container(
                          child: RotatedBox(
                            quarterTurns: controller.isTotalViewExpanded ? 90 : 180,
                            child: Icon(
                              Icons.expand_more,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("${(((userData!.profitLoss! - userData!.brokerageTotal!) + controller.totalPosition.value).toStringAsFixed(2))}",
                          // userData?.role == UserRollList.user
                          //     ? "${(((userData!.profitLoss! - userData!.brokerageTotal!) + controller.totalPosition.value).toStringAsFixed(2))}"
                          //     : "${(((userData!.profitLoss! + userData!.brokerageTotal!) + controller.totalPositionPercentWise.value).toStringAsFixed(2))}",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: Appfonts.family1Medium,
                              color: controller.totalPosition.value > 0
                                  ? Colors.white
                                  : controller.totalPosition.value < 0
                                      ? AppColors().redColor
                                      : Colors.white)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            //   height: 0.5,
            //   color: AppColors().DarkText.withOpacity(0.5),
            // ),
            Offstage(
              offstage: controller.isTotalViewExpanded == false,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Realised P&L", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              if (userData!.role == UserRollList.user) Text((userData!.profitLoss! - userData!.brokerageTotal!).toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                              if (userData!.role != UserRollList.user) Text((userData!.profitLoss! + userData!.brokerageTotal!).toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Unrealised P&L", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              Text(
                                // userData!.role == UserRollList.user ? controller.totalPosition.toStringAsFixed(2) : controller.totalPositionPercentWise.toStringAsFixed(2),
                                controller.totalPosition.toStringAsFixed(2),
                                style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Margin Used", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              Text((userData!.marginBalance! - userData!.tradeMarginBalance!).toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Free margin", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              Text(userData!.tradeMarginBalance!.toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Equity", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              Text(((userData!.credit! + controller.totalPosition.value + userData!.profitLoss!) - userData!.brokerageTotal!).toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                            ],
                          ),
                        ),
                        // Spacer(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Credit", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              Text(userData!.credit!.toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget listContentView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (controller.isSelectedForSquareOff.value || controller.isSelectedForRollOver.value) {
          if (controller.arrPositionScriptList[index].isSelected) {
            controller.arrPositionScriptList[index].isSelected = false;
          } else {
            controller.arrPositionScriptList[index].isSelected = true;
          }
          controller.update();
        } else {
          if (userData!.role == UserRollList.user) {
            controller.selectedScript = controller.arrPositionScriptList[index].obs;
            controller.selectedIndex = index;
            controller.qtyController.text = controller.arrPositionScriptList[index].quantity!.toString();
            // controller.lotSizeConverted.value = (controller.arrPositionScriptList[index].quantity! / controller.arrPositionScriptList[index].lotSize!).toDouble();
            // controller.isValidQty.value = true;
            if (controller.arrPositionScriptList[controller.selectedIndex].exchangeName!.toLowerCase() == "mcx") {
              if (controller.arrPositionScriptList[controller.selectedIndex].quantity! < 0) {
                var temp = controller.arrPositionScriptList[controller.selectedIndex].quantity! * -1;
                controller.qtyController.text = temp.toString();

                controller.lotSizeConverted.value = controller.arrPositionScriptList[controller.selectedIndex].totalQuantity!.toDouble();
                if (controller.lotSizeConverted.value < 0) {
                  controller.lotSizeConverted.value = controller.lotSizeConverted.value * -1;
                }
              } else {
                controller.qtyController.text = controller.arrPositionScriptList[controller.selectedIndex].quantity.toString();
                controller.lotSizeConverted.value = controller.arrPositionScriptList[controller.selectedIndex].totalQuantity!.toDouble();
              }
            } else {
              if (controller.arrPositionScriptList[controller.selectedIndex].totalQuantity! < 0) {
                var temp = controller.arrPositionScriptList[controller.selectedIndex].totalQuantity! * -1;
                controller.qtyController.text = temp.toString();

                controller.lotSizeConverted.value = controller.arrPositionScriptList[controller.selectedIndex].totalQuantity! / controller.arrPositionScriptList[controller.selectedIndex].lotSize!;
                if (controller.lotSizeConverted.value < 0) {
                  controller.lotSizeConverted.value = controller.lotSizeConverted.value * -1;
                }
              } else {
                controller.qtyController.text = controller.arrPositionScriptList[controller.selectedIndex].totalQuantity.toString();

                controller.lotSizeConverted.value = controller.arrPositionScriptList[controller.selectedIndex].totalQuantity! / controller.arrPositionScriptList[controller.selectedIndex].lotSize!;
              }
            }
            displyMoreOptionBootomSheet();
          }
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5.w),
              child: Row(
                children: [
                  if (controller.isSelectedForSquareOff.value || controller.isSelectedForRollOver.value)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        controller.arrPositionScriptList[index].isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                        color: AppColors().blueColor,
                      ),
                    ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("${controller.arrPositionScriptList[index].exchangeName} ${controller.arrPositionScriptList[index].symbolTitle}, ", style: TextStyle(fontSize: 13, fontFamily: Appfonts.family2, color: AppColors().DarkText)),
                            Text(controller.arrPositionScriptList[index].totalQuantity! > 0 ? "BUY " : "Sell" + " ",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: Appfonts.family2,
                                  color: controller.arrPositionScriptList[index].totalQuantity! > 0 ? AppColors().blueColor : AppColors().redColor,
                                )),
                            Text(controller.arrPositionScriptList[index].exchangeName!.toLowerCase() == "mcx" ? controller.arrPositionScriptList[index].quantity!.toString() : controller.arrPositionScriptList[index].totalQuantity!.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: Appfonts.family2,
                                  color: controller.arrPositionScriptList[index].totalQuantity! > 0 ? AppColors().blueColor : AppColors().redColor,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            "${double.parse(controller.arrPositionScriptList[index].price!.toStringAsFixed(2))} -> ${controller.arrPositionScriptList[index].totalQuantity! < 0 ? controller.arrPositionScriptList[index].ask!.toStringAsFixed(2).toString() : controller.arrPositionScriptList[index].bid!.toStringAsFixed(2).toString()}",
                            style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText))
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(double.parse(controller.arrPositionScriptList[index].profitLossValue!.toStringAsFixed(2)).toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: Appfonts.family1Medium,
                                color: controller.getPriceColor(
                                  controller.arrPositionScriptList[index].profitLossValue!,
                                ))),
                        const SizedBox(
                          height: 5,
                        ),
                        // if (userData!.role != UserRollList.user)
                        //   Text("( " + controller.getPlPer(percentage: controller.arrPositionScriptList[index].profitAndLossSharing!, pl: controller.arrPositionScriptList[index].profitLossValue!).toStringAsFixed(2) + " )",
                        //       textAlign: TextAlign.end,
                        //       style: TextStyle(
                        //           fontSize: 10,
                        //           fontFamily: Appfonts.family1Regular,
                        //           color: controller.getPlPer(percentage: controller.arrPositionScriptList[index].profitAndLossSharing!, pl: controller.arrPositionScriptList[index].profitLossValue!) > 0 ? AppColors().blueColor : AppColors().redColor)),
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
            Text(name.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().DarkText)),
            const Spacer(),
            Text(value.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().blueColor)),
          ],
        ),
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
                                controller.arrPositionScriptList[controller.selectedIndex].exchangeName!.toLowerCase() == "mcx"
                                    ? "Lot"
                                    : controller.isValidQty.value
                                        ? "Qty"
                                        : "Invalid Qty",
                                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: controller.isValidQty.value ? AppColors().DarkText : AppColors().redColor)),
                            const Spacer(),
                            Text(controller.arrPositionScriptList[controller.selectedIndex].exchangeName!.toLowerCase() == "mcx" ? "Qty ${controller.lotSizeConverted.toStringAsFixed(2)}" : "Lot ${controller.lotSizeConverted.toStringAsFixed(2)}",
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
                          if (controller.arrPositionScriptList[controller.selectedIndex].oddLotTrade == 1) {
                            if (controller.arrPositionScriptList[controller.selectedIndex].exchangeName!.toLowerCase() == "mcx") {
                              var temp = (num.parse(controller.qtyController.text) * controller.arrPositionScriptList[controller.selectedIndex].lotSize!);
                              controller.lotSizeConverted.value = temp.toDouble();
                              var temp1 = (controller.lotSizeConverted / controller.arrPositionScriptList[controller.selectedIndex].lotSize!.toDouble());

                              controller.totalQuantity = temp1;
                              controller.isValidQty.value = true;
                            } else {
                              var temp = (num.parse(controller.qtyController.text) / controller.arrPositionScriptList[controller.selectedIndex].lotSize!);
                              controller.lotSizeConverted.value = temp;
                              controller.isValidQty.value = true;

                              var temp1 = num.parse(controller.qtyController.text);
                              controller.totalQuantity = temp1;
                              ();
                            }
                          } else {
                            if (controller.arrPositionScriptList[controller.selectedIndex].exchangeName!.toLowerCase() == "mcx") {
                              var temp = (num.parse(controller.qtyController.text) * controller.arrPositionScriptList[controller.selectedIndex].lotSize!);

                              print(temp);
                              if (controller.hasNonZeroDecimalPart(temp) == false) {
                                controller.lotSizeConverted.value = temp.toDouble();
                                controller.isValidQty.value = true;
                                var temp1 = (num.parse(controller.qtyController.text) / controller.arrPositionScriptList[controller.selectedIndex].lotSize!);
                                controller.totalQuantity = temp1;
                              } else {
                                controller.isValidQty.value = false;
                              }
                            } else {
                              var temp = (num.parse(controller.qtyController.text) / controller.arrPositionScriptList[controller.selectedIndex].lotSize!);

                              print(temp);

                              if (controller.hasNonZeroDecimalPart(temp) == false) {
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
                          Text("Tick Size ${controller.arrPositionScriptList[controller.selectedIndex].scriptDataFromSocket.value.ts.toString()}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
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
                onTap: () {
                  // controller.selectedOrderType = constantValues!.orderType![index];
                  // controller.selectedOptionBottomSheetTab.value = index;
                },
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

  displyMoreOptionBootomSheet() {
    // GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
    controller.buySellBottomSheetKey = GlobalKey();
    Future.delayed(const Duration(milliseconds: 100), () {
      controller.buySellBottomSheetKey?.currentState?.expand();
    });
    Get.bottomSheet(StatefulBuilder(builder: (context, stateSetter) {
      controller.updateBottomSheet = stateSetter;
      return Obx(() {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 480,
          width: 100.w,
          decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: AppColors().bgColor),
          child: SingleChildScrollView(
            controller: controller.buySellBottomSheetScrollcontroller,
            physics: controller.isInfoClick.value ? ClampingScrollPhysics() : NeverScrollableScrollPhysics(),
            child: Obx(() {
              return Column(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controller.arrPositionScriptList[controller.selectedIndex].symbolName ?? "", style: TextStyle(fontSize: 22, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                Text(shortDate(controller.arrPositionScriptList[controller.selectedIndex].expiry!), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
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
                  Container(
                    height: 1,
                    width: 100.w,
                    color: AppColors().grayLightLine,
                  ),
                  if (userData!.role == UserRollList.user)
                    const SizedBox(
                      height: 15,
                    ),
                  if (userData!.role == UserRollList.user)
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
                  if (userData!.role == UserRollList.user)
                    const SizedBox(
                      height: 15,
                    ),
                  if (userData!.role == UserRollList.user) Center(child: qtyPriceView()),
                  const SizedBox(
                    height: 15,
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
                            title:
                                "BUY \n ${controller.arrPositionScriptList[controller.selectedIndex].scriptDataFromSocket.value.ask == 0.0 ? controller.arrPositionScriptList[controller.selectedIndex].ask : controller.arrPositionScriptList[controller.selectedIndex].scriptDataFromSocket.value.ask.toString()}",
                            textSize: 16,
                            // prefixHeight: 22,
                            onPress: () {
                              if (controller.arrPositionScriptList[controller.selectedIndex].tradeType == "sell") {
                                var msg = controller.validateForm();
                                if (msg.isEmpty) {
                                  Get.back();
                                  controller.isForBuy = true;

                                  controller.initiateTrade(stateSetter);
                                } else {
                                  showWarningToast(msg, controller.globalContext!);
                                }
                              }
                            },
                            bgColor: controller.arrPositionScriptList[controller.selectedIndex].tradeType == "buy" ? AppColors().lightText : AppColors().blueColor,
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
                            title:
                                "SELL \n ${controller.arrPositionScriptList[controller.selectedIndex].scriptDataFromSocket.value.bid == 0.0 ? controller.arrPositionScriptList[controller.selectedIndex].bid : controller.arrPositionScriptList[controller.selectedIndex].scriptDataFromSocket.value.bid.toString()}",
                            textSize: 16,
                            // prefixHeight: 22,
                            onPress: () {
                              if (controller.arrPositionScriptList[controller.selectedIndex].tradeType == "buy") {
                                var msg = controller.validateForm();
                                if (msg.isEmpty) {
                                  Get.back();
                                  controller.isForBuy = false;
                                  // buySellBottomSheet(false);
                                  controller.initiateTrade(stateSetter);
                                } else {
                                  showWarningToast(msg, controller.globalContext!);
                                }
                              }
                            },
                            bgColor: controller.arrPositionScriptList[controller.selectedIndex].tradeType == "sell" ? AppColors().lightText : AppColors().redColor,
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
                          GestureDetector(
                            onTap: () {
                              // controller.isInfoClick.value = !controller.isInfoClick.value;
                              // controller.buySellBottomSheetScrollcontroller
                              //     .animateTo(0, duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
                              // controller.buySellBottomSheetKey?.currentState?.expand();
                              Get.toNamed(RouterName.positionInfoScreen);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppImages.infoIcon,
                                    width: 20,
                                    height: 20,
                                    color: AppColors().DarkText,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Info", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
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
                          ),
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
                                      Text(controller.selectedScript!.value!.scriptDataFromSocket.value.high.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
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
                                      Text(controller.selectedScript!.value!.scriptDataFromSocket.value.low.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
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
                                      Text(controller.selectedScript!.value!.scriptDataFromSocket.value.open.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
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
                                      Text(controller.selectedScript!.value!.scriptDataFromSocket.value.close.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                    ],
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
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
                ],
              );
            }),
          ),
        );
      });
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
    }), isDismissible: true, isScrollControlled: true, enableDrag: true)
        .then((value) {
      controller.updateBottomSheet = null;
      controller.update();
    });
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
