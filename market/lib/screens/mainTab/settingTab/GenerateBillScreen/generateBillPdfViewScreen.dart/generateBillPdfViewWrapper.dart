import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/screens/mainTab/settingTab/GenerateBillScreen/generateBillPdfViewScreen.dart/generateBillPdfViewController.dart';
import '../../../../../constant/color.dart';
import '../../../../../customWidgets/appNavigationBar.dart';
import '../../../../BaseViewController/baseController.dart';
import '../../../tabScreen/MainTabController.dart';

class GenerateBillPdfViewScreen extends BaseView<GenerateBillPdfViewController> {
  const GenerateBillPdfViewScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
          },
          headerTitle: "Generate Bill",
          backGroundColor: AppColors().headerBgColor,
          isTrailingDisplay: true,
          trailingIcon: Image.asset(
            AppImages.shareicon,
            height: 24,
            width: 24,
            color: AppColors().fontColor,
          ),
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
        child: Text("data"),
      ),
    );
  }

  // Widget pdfview1() {
  //   return Container(
  //     child: PDFView(
  //       filePath: "https://www.africau.edu/images/default/sample.pdf",
  //       enableSwipe: true,
  //       swipeHorizontal: false,
  //       autoSpacing: true,
  //       pageFling: true,
  //       pageSnap: true,
  //       fitEachPage: false,
  //       onRender: (_pages) {
  //         controller.pages = _pages;
  //         controller.isReady = true;
  //       },
  //       onError: (error) {
  //         print(error.toString());
  //       },
  //       onPageError: (page, error) {
  //         print('$page: ${error.toString()}');
  //       },
  //       onViewCreated: (PDFViewController pdfViewController) {
  //         controller.pdfcontroller.complete(pdfViewController);
  //       },
  //     ),
  //   );
  // }
}
