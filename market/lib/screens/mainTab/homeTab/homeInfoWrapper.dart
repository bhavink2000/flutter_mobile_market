import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constant/color.dart';
import '../../../constant/font_family.dart';
import '../../BaseViewController/baseController.dart';
import 'homeController.dart';

class HomeInfoScreen extends BaseView<HomeController> {
  const HomeInfoScreen({Key? key}) : super(key: key);

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
                Text(controller.selectedScript.value?.symbol ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                const Spacer(),
                Container(
                  child: Row(
                    children: [
                      Container(
                        color: controller.arrScript[controller.currentSelectedIndex].bid! < controller.arrPreScript[controller.currentSelectedIndex].bid! ? AppColors().redColor : AppColors().blueColor,
                        width: 17.w,
                        height: 5.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(controller.selectedScript.value!.bid.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: AppColors().whiteColor)),
                            Text("H: ${controller.selectedScript.value!.high.toString()}", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Container(
                        color: controller.arrScript[controller.currentSelectedIndex].ask! < controller.arrPreScript[controller.currentSelectedIndex].ask! ? AppColors().redColor : AppColors().blueColor,
                        width: 17.w,
                        height: 5.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(controller.selectedScript.value!.ask.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: AppColors().whiteColor)),
                            Text("L: ${controller.selectedScript.value!.low.toString()}", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
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
                  // sheetList("Script", controller.selectedScript.value!.symbol.toString(), 0),
                  sheetList("Expiry", shortFullDateTime(controller.selectedScript.value!.expiry!), 0),
                  sheetList("Strike Price", controller.selectedSymbol!.strikePrice != 0 ? controller.selectedSymbol!.instrumentType! + " - " + controller.selectedSymbol!.strikePrice!.toString() : "--", 1),
                  sheetList("Lot Size", controller.selectedScript.value!.ls!.toString(), 2),

                  sheetList("Trade Margin", controller.selectedSymbol!.tradeMargin!.toString(), 3),
                  sheetList("Trade Attribute", controller.selectedSymbol!.tradeAttribute!.toString().toUpperCase(), 4),
                  sheetList("Allow Trade", controller.selectedSymbol!.allowTradeValue!.toString(), 5),
                  sheetList("Max Qty", controller.selectedSymbol!.quantityMax!.toString(), 6),
                  sheetList("Breakup Qty", controller.selectedSymbol!.breakQuantity!.toString(), 7),
                  sheetList("Max Lot", controller.selectedSymbol!.lotMax!.toString(), 8),
                  sheetList("Berakup Lot", controller.selectedSymbol!.breakUpLot!.toString(), 9),
                  sheetList("Volume", controller.selectedSymbol!.volume!.toString(), 10),
                  sheetList("Time", fullTime(DateTime.now()), 11)
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
