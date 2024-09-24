import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:market/screens/mainTab/settingTab/BulkTradeScreen/bulkTradeController.dart';
import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constant/color.dart';
import '../../../../constant/commonWidgets.dart';
import '../../../../constant/utilities.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../BaseViewController/baseController.dart';

class BulkTradeScreen extends BaseView<BulkTradeController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
        appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
          },
          headerTitle: "Bulk Trades",
          backGroundColor: AppColors().headerBgColor,
        ),
        body: SafeArea(child: mainContent(context)));
  }

  Widget mainContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 960,
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
                    child: controller.isApiCallRunning == false && controller.arrBulkTrade.isEmpty
                        ? dataNotFoundView("Bulk Trade not found")
                        : PaginableListView.builder(
                            loadMore: () async {
                              if (controller.totalPage >= controller.currentPage) {
                                //print(controller.currentPage);
                                // controller.accountSummaryList();
                              }
                            },
                            errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                            progressIndicatorWidget: displayIndicator(),
                            physics: const ClampingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            itemCount: controller.isApiCallRunning || controller.isResetCall ? 50 : controller.arrBulkTrade.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return tradeContent(context, index);
                            }),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 2.h,
          color: AppColors().headerBgColor,
        ),
      ],
    );
  }

  Widget tradeContent(BuildContext context, int index) {
    // var scriptValue = controller.arrUserOderList[index];
    if (controller.isApiCallRunning) {
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
          // controller.selectedScriptIndex = index;
          controller.update();
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              valueBox(controller.arrBulkTrade[index].exchangeName ?? "", 100, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(controller.arrBulkTrade[index].symbolTitle ?? "", 160, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(controller.arrBulkTrade[index].buyTotalQuantity!.toString(), 150, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(controller.arrBulkTrade[index].sellTotalQuantity!.toString(), 150, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(controller.arrBulkTrade[index].totalQuantity!.toString(), 150, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(shortFullDateTime(controller.arrBulkTrade[index].endDate!), 180, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
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
        titleBox("Exchange", width: 100),
        titleBox("Symbol", width: 160),
        titleBox("Buy Total Qty", width: 150),
        titleBox("Sell Total Qty", width: 150),
        titleBox("Total Qty", width: 150),
        titleBox("Date & Time", width: 180),
      ],
    );
  }
}
