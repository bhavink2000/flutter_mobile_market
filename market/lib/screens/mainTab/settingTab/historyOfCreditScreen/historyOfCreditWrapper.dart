import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:market/constant/font_family.dart';
import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constant/color.dart';
import '../../../../constant/commonWidgets.dart';
import '../../../../constant/utilities.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../BaseViewController/baseController.dart';
import 'historyOfCreditController.dart';

class HistoryOfCreditScreen extends BaseView<HistoryOfCreditController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
        appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
          },
          headerTitle: "Credit History",
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
                    child: controller.isApiCallRunning == false && controller.arrCreditList.isEmpty
                        ? dataNotFoundView("Credit history not found")
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
                            itemCount: controller.isApiCallRunning || controller.isResetCall ? 50 : controller.arrCreditList.length,
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
          height: 30,
          decoration: BoxDecoration(color: AppColors().whiteColor, border: Border(top: BorderSide(color: AppColors().lightOnlyText, width: 1))),
          child: Center(
              child: Row(
            children: [
              totalContent(value: "Total Amount", textColor: AppColors().DarkText, width: 66.7.w),
              totalContent(value: controller.arrCreditList.isNotEmpty ? controller.arrCreditList.last.balance.toStringAsFixed(2) : "0", textColor: AppColors().DarkText, width: 110),
            ],
          )),
        ),
        Container(
          height: 2.h,
          color: AppColors().headerBgColor,
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
              // valueBox(shortFullDateTime(controller.arrAccountSummary[index].createdAt!), 33, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              // valueBox(controller.arrAccountSummary[index].userName ?? "", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index, isUnderlined: true, onClickValue: () {
              //   showUserDetailsPopUp(userId: controller.arrAccountSummary[index].userId!, userName: controller.arrAccountSummary[index].userName ?? "");
              // }),
              // valueBox(controller.arrAccountSummary[index].symbolName ?? "", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index, isLarge: true),
              // valueBox(controller.arrAccountSummary[index].quantity.toString(), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              // valueBox(controller.arrAccountSummary[index].tradeType ?? "", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              // valueBox(controller.arrAccountSummary[index].price!.toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              // valueBox(controller.arrAccountSummary[index].positionDataAveragePrice!.toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              // valueBox(controller.arrAccountSummary[index].type ?? "", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              // valueBox(controller.arrAccountSummary[index].transactionType ?? "", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index, isForDate: true),
              // valueBox(controller.arrAccountSummary[index].amount!.toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index, onClickValue: () {
              //   controller.tradeID = controller.arrAccountSummary[index].tradeId!;
              //   controller.getTradeDetail();
              // }),
              // valueBox(controller.arrAccountSummary[index].closing!.toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              // valueBox(controller.arrAccountSummary[index].positionDataQuantity!.toString(), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(controller.arrCreditList[index].fromUserName ?? "", 100, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(shortFullDateTime(controller.arrCreditList[index].createdAt!), 160, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),

              valueBox((controller.arrCreditList[index].transactionType ?? ""), 150, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),

              valueBox(controller.arrCreditList[index].amount!.toStringAsFixed(2), 150, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),

              valueBox(controller.arrCreditList[index].balance.toStringAsFixed(2), 150, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
              valueBox(controller.arrCreditList[index].comment ?? "", 150, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().DarkText, index),
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

        // titleBox("Date Time"),
        // titleBox("Username"),
        // titleBox("Symbol Name", isLarge: true),
        // titleBox("Qty"),
        // titleBox("Trade Type"),
        // titleBox("Price"),
        // titleBox("Average Price"),

        // titleBox("Type"),
        // titleBox("Transaction Type", isForDate: true),
        // titleBox("Amount"),
        // titleBox("Closing"),
        // titleBox("Open Qty"),
        titleBox("Username", width: 100),
        titleBox("Date Time", width: 160),

        titleBox("Type", width: 150),
        titleBox("Amount", width: 150),
        titleBox("Balance", width: 150),
        titleBox("Comments", width: 150),
      ],
    );
  }
}
