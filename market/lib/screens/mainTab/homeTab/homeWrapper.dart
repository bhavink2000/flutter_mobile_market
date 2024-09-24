import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/modelClass/getScriptFromSocket.dart';
import 'package:market/navigation/routename.dart';
import 'package:market/screens/mainTab/homeTab/editWatchlist/editWatchlistWrapper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';

import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../../../constant/color.dart';
import '../../../constant/const_string.dart';
import '../../../modelClass/constantModelClass.dart';
import '../../../constant/font_family.dart';
import '../../../customWidgets/appTextField.dart';
import '../../BaseViewController/baseController.dart';
import 'homeController.dart';

class HomeScreen extends BaseView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return VisibilityDetector(
      key: Key('my-widget-key'),
      onVisibilityChanged: (visibilityInfo) {
        if (controller.isPlayerOpen.value) {
          if (visibilityInfo.visibleFraction < 1.0) {
            controller.playerController!.pauseVideo();
          } else {
            if (controller.isPlayerOpen.value) {
              controller.playerController!.playVideo();
            }
          }
        }
      },
      child: Scaffold(
        appBar: appNavigationBar(
          isTrailingDisplay: true,
          isMarketDisplay: true,
          onMoreButtonPress: () {
            controller.isPlayerOpen.value = !controller.isPlayerOpen.value;
            if (controller.isPlayerOpen.value) {
              Future.delayed(const Duration(milliseconds: 300), () {
                controller.isHedaderDropdownOpen.value = true;
              });
            } else {
              controller.isHedaderDropdownOpen.value = false;
              controller.playerController!.stopVideo();
              controller.playerController!.close();
              controller.playerController = null;
            }
          },
          isTVDisplay: true,
          onTVButtonPress: () async {
            controller.isPlayerOpen.value = !controller.isPlayerOpen.value;
            if (controller.isPlayerOpen.value) {
              Future.delayed(const Duration(milliseconds: 300), () {
                controller.isHedaderDropdownOpen.value = true;
                controller.playerController!.playVideo();
              });
            } else {
              controller.isHedaderDropdownOpen.value = false;
              controller.playerController!.pauseVideo();
            }
            // controller.update();
            // Get.toNamed(RouterName.videoPlayerscreen);
          },
          isAddDisplay: true,
          onAddButtonPress: () {
            if (controller.selectedTab.value.title == "ALL") {
              Get.toNamed(RouterName.filterExchangeScreen, arguments: {"onSelectedCallBack": controller.getSymbolListTabWise, "tabId": controller.selectedTab.value.userTabId, "currentSymbol": controller.arrSymbol});
            } else {
              Get.toNamed(RouterName.filterscreen, arguments: {"onSelectedCallBack": controller.getSymbolListTabWise, "tabId": controller.selectedTab.value.userTabId, "currentSymbol": controller.arrSymbol, "selectedExchange": ExchangeData(exchangeId: controller.selectedTab.value.exchangeId ?? "")});
            }
          },
          backGroundColor: AppColors().marketWatchBgColor,
          trailingIcon: Image.asset(
            AppImages.notificationIcon,
            width: 20,
            height: 20,
            color: AppColors().fontColor,
          ),
        ),
        backgroundColor: AppColors().marketWatchBgColor,
        body: Column(
          children: [
            headerDropDown(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         if (controller.selectedTab?.title == "ALL") {
            //           Get.toNamed(RouterName.filterExchangeScreen, arguments: {"onSelectedCallBack": controller.getSymbolListTabWise, "tabId": controller.selectedTab?.userTabId, "currentSymbol": controller.arrSymbol});
            //         } else {
            //           Get.toNamed(RouterName.filterscreen, arguments: {"onSelectedCallBack": controller.getSymbolListTabWise, "tabId": controller.selectedTab?.userTabId, "currentSymbol": controller.arrSymbol, "selectedExchange": ExchangeData(exchangeId: controller.selectedTab?.exchangeId ?? "")});
            //         }
            //       },
            //       child: Container(
            //         width: 78.5.w,
            //         height: 6.h,
            //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors().searchBGColor, boxShadow: []),
            //         child: Row(
            //           children: [
            //             SizedBox(
            //               width: 5.w,
            //             ),
            //             Image.asset(
            //               AppImages.searchIcon,
            //               width: 20,
            //               height: 20,
            //             ),
            //             SizedBox(
            //               width: 2.w,
            //             ),
            //             Text("Search & Add", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().placeholderColor)),
            //             const Spacer(),
            //             Text("${controller.arrSymbol.length}/100", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().placeholderColor)),
            //             SizedBox(
            //               width: 2.w,
            //             ),
            //             SizedBox(
            //               width: 5.w,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 2.w,
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Get.toNamed(RouterName.filterExchangeScreen, arguments: {"onSelectedCallBack": controller.getSymbolListTabWise, "tabId": controller.selectedTab?.userTabId, "currentSymbol": controller.arrSymbol});
            //       },
            //       child: Container(
            //         height: 6.h,
            //         width: 6.h,
            //         decoration: BoxDecoration(color: AppColors().blueColor, borderRadius: BorderRadius.circular(15)),
            //         child: Icon(
            //           Icons.add,
            //           color: Colors.white,
            //         ),
            //       ),
            //     )
            //   ],
            // ),

            Obx(() {
              return Expanded(
                flex: 12,
                child: SizedBox(
                  width: 100.w,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.only(top: 2.h),
                        child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            itemCount: controller.arrCategory.length,
                            controller: controller.listcontroller,
                            scrollDirection: Axis.horizontal,
                            // shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return categorylistContent(context, index);
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 6.h),
                        width: 100.w,
                        decoration: BoxDecoration(color: AppColors().marketWatchBgColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(10))),
                        child: Container(
                          margin: EdgeInsets.only(top: 2.h),
                          child: controller.isApiCallRunning.value
                              ? Center(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: AppColors().blueColor,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : ReorderableListView.builder(
                                  // padding: const EdgeInsets.symmetric(horizontal: 40),
                                  itemCount: controller.arrScript.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ColoredBox(
                                      key: Key('$index'),
                                      color: Colors.transparent,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            color: Colors.transparent,
                                            child: controller.isDetailSciptOn ? mt5ScriptlistContent(context, index) : bigScriptlistContent(context, index),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  onReorder: (int oldIndex, int newIndex) {
                                    if (oldIndex < newIndex) {
                                      newIndex -= 1;
                                    }
                                    final ScriptData item = controller.arrScript.removeAt(oldIndex);
                                    controller.arrScript.insert(newIndex, item);
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget headerDropDown() {
    GlobalKey globalKey = GlobalKey();
    return Obx(() {
      return AnimatedContainer(
        width: 100.w,
        height: controller.isPlayerOpen.value ? 26.h : 0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        key: globalKey,
        child: Offstage(
          offstage: !controller.isPlayerOpen.value,
          child: YoutubePlayer(
            controller: controller.playerController!,
            aspectRatio: 16 / 9,
          ),
        ),
      );
    });
  }

  Widget categorylistContent(BuildContext context, int index) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.selectedTab.value = controller.arrCategory[index];
          // controller.update();
          controller.scrollToIndex(index);
          controller.getSymbolListTabWise();
        },
        child: Padding(
          padding: index == 0
              ? const EdgeInsets.only(right: 10)
              : index == controller.arrCategory.length - 1
                  ? const EdgeInsets.only(left: 10)
                  : const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                // width: 50,

                decoration: BoxDecoration(
                    color: controller.selectedTab.value.userTabId == controller.arrCategory[index].userTabId ? AppColors().blueColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: controller.selectedTab.value.userTabId == controller.arrCategory[index].userTabId ? AppColors().blueColor : AppColors().lightOnlyText, width: 1)),
                child: Center(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        controller.arrCategory[index].title ?? "",
                        style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1Regular, color: controller.selectedTab.value.userTabId == controller.arrCategory[index].userTabId ? Colors.white : AppColors().fontColor),
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget mt5ScriptlistContent(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        controller.currentSelectedIndex = index;
        controller.selectedScript.value = controller.arrScript[index];
        var indexOfSymbol = controller.arrSymbol.indexWhere((element) => controller.arrScript[index].symbol == element.symbol);
        controller.selectedSymbol = controller.arrSymbol[indexOfSymbol];

        if (controller.selectedScript.value!.exchange!.toLowerCase() == "mcx") {
          controller.lotSizeConverted.value = controller.selectedScript.value!.ls!.toDouble();
          controller.isValidQty.value = true;
          controller.quantity = 1;
          controller.totalQuantity = 1;
          controller.qtyController.text = "1";
        } else {
          controller.lotSizeConverted.value = 1.0;
          controller.isValidQty.value = true;
          controller.quantity = controller.selectedScript.value!.ls!.toInt();
          controller.totalQuantity = controller.selectedScript.value!.ls!.toInt();
          controller.qtyController.text = controller.arrScript[index].ls.toString();
        }

        displyMoreOptionBootomSheet();
        // controller.update();
      },
      onLongPress: () {
        Get.to(const EditWatchListScreen());
      },
      child: Container(
        width: 99.w,
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(controller.arrScript[index].ch.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: controller.arrScript[index].ch! < 0 ? AppColors().redColor : AppColors().blueColor)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("(${controller.arrScript[index].chp.toString()}%)", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: controller.arrScript[index].ch! < 0 ? AppColors().redColor : AppColors().blueColor)),
                        ],
                      ),
                      Container(
                        width: 48.w,
                        child: Row(
                          children: [
                            // Image.asset(
                            //   controller.arrScript[index].ch! < 0 ? AppImages.arrowDownRed : AppImages.arrowDownGreen,
                            //   width: 9,
                            //   height: 9,
                            //   color: controller.arrScript[index].ch! < 0 ? AppColors().redColor : AppColors().blueColor,
                            // ),
                            // const SizedBox(
                            //   width: 5,
                            // ),
                            // Text(controller.arrScript[index].exchange.toString(), style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                            // const SizedBox(
                            //   width: 5,
                            // ),
                            Container(
                              // width: 36.w,
                              child: Text(controller.arrScript[index].name.toString(), style: TextStyle(fontSize: 16, fontFamily: Appfonts.family2, color: AppColors().DarkText, overflow: TextOverflow.ellipsis)),
                            ),
                          ],
                        ),
                      ),
                      Text(controller.arrScript[index].expiry == null ? "" : veryShortDate(controller.arrScript[index].expiry!), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: AppColors().lightText)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          // color: controller.arrScript[index].bid! < controller.arrPreScript[index].bid!
                          //     ? AppColors().redColor
                          //     : controller.arrScript[index].bid! > controller.arrPreScript[index].bid!
                          //         ? AppColors().blueColor
                          //         : AppColors().marketBoxBG,
                          width: 20.w,
                          height: 5.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              controller.modifyPriceStyle(index, controller.arrScript[index].bid!, controller.arrPreScript[index].bid!),
                              // Text(controller.arrScript[index].bid.toString(),
                              //     style: TextStyle(

                              //       fontSize: 14,
                              //       fontFamily: Appfonts.family2,
                              //       color: controller.arrScript[index].bid! == controller.arrPreScript[index].bid! ? AppColors().DarkText : Colors.white,
                              //     )),
                              Text("H: ${controller.arrScript[index].high.toString()}",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: Appfonts.family1Medium,
                                      color: controller.arrScript[index].bid! == controller.arrPreScript[index].bid!
                                          ? AppColors().DarkText
                                          : controller.arrScript[index].bid! < controller.arrPreScript[index].bid!
                                              ? AppColors().redColor
                                              : AppColors().blueColor)),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Container(
                          // color: controller.arrScript[index].ask! < controller.arrPreScript[index].ask!
                          //     ? AppColors().redColor
                          //     : controller.arrScript[index].ask! > controller.arrPreScript[index].ask!
                          //         ? AppColors().blueColor
                          //         : AppColors().marketBoxBG,
                          width: 20.w,
                          height: 5.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              controller.modifyPriceStyle(index, controller.arrScript[index].ask!, controller.arrPreScript[index].ask!),
                              // Text(controller.arrScript[index].ask.toString(),
                              //     style: TextStyle(
                              //       fontSize: 14,
                              //       fontFamily: Appfonts.family2,
                              //       color: controller.arrScript[index].ask! == controller.arrPreScript[index].ask! ? AppColors().DarkText : Colors.white,
                              //     )),
                              Text("L: ${controller.arrScript[index].low.toString()}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: Appfonts.family1Medium,
                                      color: controller.arrScript[index].ask! == controller.arrPreScript[index].ask!
                                          ? AppColors().DarkText
                                          : controller.arrScript[index].ask! < controller.arrPreScript[index].ask!
                                              ? AppColors().redColor
                                              : AppColors().blueColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //   height: 1,
            //   color: AppColors().lightOnlyText.withOpacity(0.2),
            // )
          ],
        ),
      ),
    );
  }

  Widget bigScriptlistContent(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        controller.currentSelectedIndex = index;
        controller.selectedScript.value = controller.arrScript[index];
        var indexOfSymbol = controller.arrSymbol.indexWhere((element) => controller.arrScript[index].symbol == element.symbol);
        controller.selectedSymbol = controller.arrSymbol[indexOfSymbol];

        if (controller.selectedScript.value!.exchange!.toLowerCase() == "mcx") {
          controller.lotSizeConverted.value = controller.selectedScript.value!.ls!.toDouble();
          controller.isValidQty.value = true;
          controller.quantity = 1;
          controller.totalQuantity = 1;
          controller.qtyController.text = "1";
        } else {
          controller.lotSizeConverted.value = 1.0;
          controller.isValidQty.value = true;
          controller.quantity = controller.selectedScript.value!.ls!.toInt();
          controller.totalQuantity = controller.selectedScript.value!.ls!.toInt();
          controller.qtyController.text = controller.arrScript[index].ls.toString();
        }

        displyMoreOptionBootomSheet();
        // controller.update();
      },
      onLongPress: () {
        Get.to(const EditWatchListScreen());
      },
      child: Container(
        width: 99.w,
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48.w,
                        child: Row(
                          children: [
                            Image.asset(
                              controller.arrScript[index].ch! < 0 ? AppImages.arrowDownRed : AppImages.arrowDownGreen,
                              width: 9,
                              height: 9,
                              color: controller.arrScript[index].ch! < 0 ? AppColors().redColor : AppColors().blueColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            // Text(controller.arrScript[index].exchange.toString(), style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),

                            Container(
                              // width: 36.w,
                              child: Text(controller.arrScript[index].name.toString(), style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText, overflow: TextOverflow.ellipsis)),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(controller.arrScript[index].expiry == null ? "" : veryShortDate(controller.arrScript[index].expiry!), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: AppColors().lightText)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(controller.arrScript[index].ch.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: controller.arrScript[index].ch! < 0 ? AppColors().redColor : AppColors().blueColor)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("(${controller.arrScript[index].chp.toString()}%)", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: controller.arrScript[index].ch! < 0 ? AppColors().redColor : AppColors().blueColor)),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          color: controller.arrScript[index].bid! < controller.arrPreScript[index].bid!
                              ? AppColors().redColor
                              : controller.arrScript[index].bid! > controller.arrPreScript[index].bid!
                                  ? AppColors().blueColor
                                  : AppColors().marketBoxBG,
                          width: 20.w,
                          height: 5.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(controller.arrScript[index].bid.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: Appfonts.family2,
                                    color: controller.arrScript[index].bid! == controller.arrPreScript[index].bid! ? AppColors().DarkText : Colors.white,
                                  )),
                              Text("H: ${controller.arrScript[index].high.toString()}", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Medium, color: controller.arrScript[index].bid! == controller.arrPreScript[index].bid! ? AppColors().DarkText : Colors.white)),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Container(
                          color: controller.arrScript[index].ask! < controller.arrPreScript[index].ask!
                              ? AppColors().redColor
                              : controller.arrScript[index].ask! > controller.arrPreScript[index].ask!
                                  ? AppColors().blueColor
                                  : AppColors().marketBoxBG,
                          width: 20.w,
                          height: 5.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(controller.arrScript[index].ask.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: Appfonts.family2,
                                    color: controller.arrScript[index].ask! == controller.arrPreScript[index].ask! ? AppColors().DarkText : Colors.white,
                                  )),
                              Text("L: ${controller.arrScript[index].low.toString()}", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Medium, color: controller.arrScript[index].ask! == controller.arrPreScript[index].ask! ? AppColors().DarkText : Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              color: AppColors().lightOnlyText.withOpacity(0.2),
            )
          ],
        ),
      ),
    );
  }

  displyMoreOptionBootomSheet() {
    // GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
    controller.buySellBottomSheetKey = GlobalKey();
    // Future.delayed(const Duration(milliseconds: 100), () {
    //   controller.buySellBottomSheetKey?.currentState?.contract();
    // });

    Get.bottomSheet(
      StatefulBuilder(builder: (context, stateSetter) {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.selectedScript.value?.name ?? "", style: TextStyle(fontSize: 22, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                  Text(controller.selectedScript.value!.expiry == null ? "" : shortDate(controller.selectedScript.value!.expiry!), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                ],
                              ),
                              const Spacer(),
                              // Container(
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         color: controller.arrScript[controller.currentSelectedIndex].bid! < controller.arrPreScript[controller.currentSelectedIndex].bid! ? AppColors().redColor : AppColors().blueColor,
                              //         width: 17.w,
                              //         height: 5.h,
                              //         child: Column(
                              //           mainAxisAlignment: MainAxisAlignment.center,
                              //           crossAxisAlignment: CrossAxisAlignment.center,
                              //           children: [
                              //             Text("H", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: AppColors().whiteColor)),
                              //             Text(controller.selectedScript.value!.high.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                              //           ],
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         width: 1.w,
                              //       ),
                              //       Container(
                              //         color: controller.arrScript[controller.currentSelectedIndex].ask! < controller.arrPreScript[controller.currentSelectedIndex].ask! ? AppColors().redColor : AppColors().blueColor,
                              //         width: 17.w,
                              //         height: 5.h,
                              //         child: Column(
                              //           mainAxisAlignment: MainAxisAlignment.center,
                              //           crossAxisAlignment: CrossAxisAlignment.center,
                              //           children: [
                              //             Text("L", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: AppColors().whiteColor)),
                              //             Text(controller.selectedScript.value!.low.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),

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
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 42.w,
                              child: CustomButton(
                                isEnabled: true,
                                buttonHeight: 7.h,
                                TitleFontFamily: Appfonts.family1SemiBold,
                                shimmerColor: AppColors().whiteColor,
                                title: "BUY \n ${controller.selectedScript.value!.ask.toString()}",
                                textSize: 16,
                                // prefixHeight: 10,
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
                                buttonHeight: 7.h,
                                isEnabled: true,
                                shimmerColor: AppColors().whiteColor,
                                title: "SELL \n ${controller.selectedScript.value!.bid.toString()}",
                                textSize: 16,
                                // prefixHeight: 22,
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
                        );
                      }),
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
                                Get.toNamed(RouterName.homeInfoScreen);
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
                                        Text(controller.selectedScript.value!.high.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
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
                                        Text(controller.selectedScript.value!.low.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
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
                                        Text(controller.selectedScript.value!.open.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
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
                                        Text(controller.selectedScript.value!.close.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
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
      }),
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
    ).then((value) {
      controller.updateBottomSheet = null;
    });
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

  Widget sheetList(String name, String value, int index) {
    Color backgroundColor = index % 2 == 0 ? AppColors().headerBgColor : AppColors().contentBg;
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
                                controller.selectedScript.value!.exchange!.toLowerCase() == "mcx"
                                    ? "Lot"
                                    : controller.isValidQty.value
                                        ? "Qty"
                                        : "Invalid Qty",
                                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: controller.isValidQty.value ? AppColors().DarkText : AppColors().redColor)),
                            const Spacer(),
                            Text(controller.selectedScript.value!.exchange!.toLowerCase() == "mcx" ? "Qty ${controller.lotSizeConverted.toStringAsFixed(2)}" : "Lot ${controller.lotSizeConverted.toStringAsFixed(2)}",
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
                          if (controller.selectedSymbol?.oddLotTrade == 1) {
                            if (controller.selectedScript.value!.exchange!.toLowerCase() == "mcx") {
                              var temp = (num.parse(controller.qtyController.text) * controller.selectedScript.value!.ls!);
                              controller.lotSizeConverted.value = temp.toDouble();
                              var temp1 = (controller.lotSizeConverted / controller.selectedScript.value!.ls!.toDouble());

                              controller.totalQuantity = temp1;
                              controller.isValidQty.value = true;
                            } else {
                              var temp = (num.parse(controller.qtyController.text) / controller.selectedScript.value!.ls!);
                              controller.lotSizeConverted.value = temp;
                              controller.isValidQty.value = true;

                              var temp1 = num.parse(controller.qtyController.text);
                              controller.totalQuantity = temp1;
                              ();
                            }
                          } else {
                            if (controller.selectedScript.value!.exchange!.toLowerCase() == "mcx") {
                              var temp = (num.parse(controller.qtyController.text) * controller.selectedScript.value!.ls!);

                              print(temp);
                              if (controller.hasNonZeroDecimalPart(temp) == false) {
                                controller.lotSizeConverted.value = temp.toDouble();
                                controller.isValidQty.value = true;
                                var temp1 = temp / controller.selectedScript.value!.ls!;
                                controller.totalQuantity = temp1;
                              } else {
                                controller.isValidQty.value = false;
                              }
                            } else {
                              var temp = (num.parse(controller.qtyController.text) / controller.selectedScript.value!.ls!);

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
                          Text("Tick Size ${controller.selectedScript.value!.ts!.toString()}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
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
                  controller.selectedOrderType = constantValues!.orderType![index];
                  controller.selectedOptionBottomSheetTab.value = index;
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

  Widget intraLongInBottomSheet(BuildContext context, int index, Type value) {
    return Container(
      // height: 40.h,
      width: 47.5.w,
      height: 5.h,
      margin: EdgeInsets.only(left: index == 0 ? 20 : 0, right: index == constantValues!.productType!.length - 1 ? 20 : 0),
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.selectedProductType = constantValues!.productType![index];
                  controller.selectedIntraLongBottomSheetTab.value = index;
                },
                child: Container(
                  height: 5.h,
                  // width: 10.w,
                  margin: EdgeInsets.only(right: constantValues!.productType!.length - 1 == index ? 20 : 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: controller.selectedIntraLongBottomSheetTab == index ? AppColors().blueColor : AppColors().grayBorderColor, width: 1)),
                  child: Center(
                    child: Text(value.name ?? "", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: controller.selectedIntraLongBottomSheetTab == index ? AppColors().blueColor : AppColors().lightOnlyText)),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget intradayLongTermTabInBottomSheet(BuildContext context, int index) {
    return SizedBox(
      // height: 40.h,
      width: 90.w,
      height: 5.h,

      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.selectedIntraLongBottomSheetTab.value = 0;
                },
                child: Container(
                  height: 5.h,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: controller.selectedIntraLongBottomSheetTab == 0 ? AppColors().blueColor : AppColors().grayBorderColor, width: 1)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Intraday", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: controller.selectedIntraLongBottomSheetTab == 0 ? AppColors().blueColor : AppColors().fontColor)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("MIS", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().lightOnlyText)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.selectedIntraLongBottomSheetTab.value = 1;
                },
                child: Container(
                  height: 5.h,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: controller.selectedIntraLongBottomSheetTab == 1 ? AppColors().blueColor : AppColors().grayBorderColor, width: 1)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Longterm", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: controller.selectedIntraLongBottomSheetTab == 1 ? AppColors().blueColor : AppColors().fontColor)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("CNC", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().lightOnlyText)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
