import 'package:flutter/material.dart';
import 'package:market/screens/mainTab/homeTab/notificationScreen/notificationListController.dart';
import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constant/color.dart';

import '../../../../constant/assets.dart';
import '../../../../constant/font_family.dart';
import '../../../../constant/utilities.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../BaseViewController/baseController.dart';

class NotificaitonListScreen extends BaseView<notificationListController> {
  const NotificaitonListScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
        appBar: appNavigationBar(
          headerTitle: "Notifications",
          isBackDisplay: false,
          backGroundColor: AppColors().bgColor,
        ),
        backgroundColor: AppColors().bgColor,
        body: SafeArea(
          child: controller.isApiCallRunning == false && controller.arrNotification.isEmpty
              ? dataNotFoundView("Notification not found")
              : controller.isApiCallRunning
                  ? displayIndicator()
                  : PaginableListView.builder(
                      loadMore: () async {
                        if (controller.totalPage >= controller.currentPage) {
                          //print(controller.currentPage);

                          controller.notificationList();
                        }
                      },
                      errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                      progressIndicatorWidget: displayIndicator(),
                      physics: const ClampingScrollPhysics(),
                      clipBehavior: Clip.hardEdge,
                      itemCount: controller.isApiCallRunning ? 50 : controller.arrNotification.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return listContentView(context, index);
                      }),
        ));
  }

  Widget listContentView(BuildContext context, int index) {
    var notificationValue = controller.arrNotification[index];
    Color backgroundColor = index % 2 == 0 ? AppColors().contentBg : AppColors().footerColor;
    Color boxBGColor = index % 2 == 1 ? AppColors().headerBgColor : AppColors().contentBg;
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(10),
              width: 90.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: backgroundColor, border: Border.all(color: AppColors().grayBorderColor, width: 1)),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: boxBGColor,
                    ),
                    child: Image.asset(
                      AppImages.notificationIcon,
                      color: AppColors().fontColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 70.w,
                        child: Text(notificationValue.message ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70.w,
                        child: Text(shortFullDateTime(notificationValue.createdAt!), textAlign: TextAlign.right, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightOnlyText)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 10,
            //   width: 90.w,
            //   color: AppColors().headerBgColor,
            // )
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
}
