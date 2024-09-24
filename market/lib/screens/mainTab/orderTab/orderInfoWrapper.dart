import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/screens/mainTab/orderTab/orderController.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constant/color.dart';
import '../../../constant/font_family.dart';
import '../../BaseViewController/baseController.dart';

class OrderInfoScreen extends BaseView<orderController> {
  const OrderInfoScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
        appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
          },
          headerTitle: "Script Information",
          backGroundColor: AppColors().headerBgColor,
          trailingIcon: Image.asset(
            AppImages.notificationIcon,
            width: 20,
            height: 20,
            color: AppColors().fontColor,
          ),
        ),
        backgroundColor: AppColors().headerBgColor,
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(controller.arrTrade[controller.selectedOrderIndex].symbolTitle ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                const Spacer(),
                Container(
                  child: Row(
                    children: [
                      Container(
                        color: controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.bid! < controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.bid! ? AppColors().redColor : AppColors().blueColor,
                        width: 17.w,
                        height: 5.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.bid.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: AppColors().whiteColor)),
                            Text("H: ${controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.high.toString()}", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Container(
                        color: controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.ask! < controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.ask! ? AppColors().redColor : AppColors().blueColor,
                        width: 17.w,
                        height: 5.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.ask.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: AppColors().whiteColor)),
                            Text("L: ${controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.low.toString()}", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() {
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.hardEdge,
                shrinkWrap: true,
                controller: controller.sheetController,
                children: [
                  // sheetList("Script", controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.symbol.toString(), 0),
                  sheetList("Expiry", shortFullDateTime(controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.expiry!), 1),
                  sheetList("Lot Size", controller.arrTrade[controller.selectedOrderIndex].scriptDataFromSocket.value.ls!.toString(), 2),

                  // sheetList("Trade Margin", controller.arrTrade[controller.selectedOrderIndex].tradeMargin!.toString(), 3),
                  // sheetList("Trade Attribute", controller.arrTrade[controller.selectedOrderIndex].tradeAttribute!.toString().toUpperCase(), 4),
                  // sheetList("Allow Trade", controller.arrTrade[controller.selectedOrderIndex].allowTradeValue!.toString(), 5),
                  // sheetList("Max Qty", controller.arrTrade[controller.selectedOrderIndex].quantityMax!.toString(), 6),
                  // sheetList("Breakup Qty", controller.arrTrade[controller.selectedOrderIndex].breakQuantity!.toString(), 7),
                  // sheetList("Max Lot", controller.arrTrade[controller.selectedOrderIndex].lotMax!.toString(), 8),
                  // sheetList("Berakup Lot", controller.arrTrade[controller.selectedOrderIndex].breakUpLot!.toString(), 9),
                  // sheetList("Volume", controller.arrTrade[controller.selectedOrderIndex].volume!.toString(), 10),
                  sheetList("Time", shortTime(DateTime.now()), 11)
                ],
              );
            }),
          ],
        ));
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
}
