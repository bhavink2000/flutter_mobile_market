import 'package:flutter/material.dart';
import 'package:flutter_super_html_viewer/flutter_super_html_viewer.dart';
import 'package:get/get.dart';

import 'package:market/constant/color.dart';

import 'package:market/customWidgets/appNavigationBar.dart';

import 'package:market/screens/BaseViewController/baseController.dart';

import 'generateBillController.dart';

// ignore: must_be_immutable
class HtmlViewerScreen extends BaseView<GenerateBillController> {
  HtmlViewerScreen({Key? key}) : super(key: key);

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
        headerTitle: "View Bill",
        backGroundColor: AppColors().headerBgColor,
      ),
      backgroundColor: AppColors().headerBgColor,
      body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: AppColors().bgColor,
          ),
          child: HtmlContentViewer(
            htmlContent: controller.billHtml,
            initialContentHeight: MediaQuery.of(context).size.height - 20,
            initialContentWidth: MediaQuery.of(context).size.width,
          )),
    );
  }
}
