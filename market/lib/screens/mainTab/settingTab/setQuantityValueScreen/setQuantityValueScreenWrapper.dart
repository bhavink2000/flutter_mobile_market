import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/screens/mainTab/settingTab/SetQuantityValueScreen/SetQuantityValueScreenController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constant/color.dart';
import '../../../../constant/const_string.dart';

import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../../customWidgets/appTextField.dart';
import '../../../BaseViewController/baseController.dart';
import '../../tabScreen/MainTabController.dart';

class SetQuantityValueScreen extends BaseView<SetQuantityValueController> {
  const SetQuantityValueScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
          },
          isTrailingDisplay: true,
          trailingIcon: SizedBox(
            width: 45,
          ),
          headerTitle: "Set Quantity Value",
          backGroundColor: AppColors().headerBgColor,
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
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: AppColors().bgColor,
        ),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              textField1(),
              textField2(),
              textField3(),
              textField4(),
              textField5(),
              textField6(),
              textField7(),
              textField8(),
              btnView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField1() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: CustomTextField(
        type: '',
        keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyServer,
        placeHolderMsg: "0",
        emptyFieldMsg: AppString.emptyServer,
        controller: controller.text1Controller,
        focus: controller.text1Focus,
        isSecure: false,
        borderColor: AppColors().grayLightLine,
        keyboardButtonType: TextInputAction.next,
        maxLength: 64,
        sufixIcon: null,
      ),
    );
  }

  Widget textField2() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      child: CustomTextField(
        type: '',
        keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyServer,
        placeHolderMsg: "0",
        emptyFieldMsg: AppString.emptyServer,
        controller: controller.text2Controller,
        focus: controller.text2Focus,
        isSecure: false,
        borderColor: AppColors().grayLightLine,
        keyboardButtonType: TextInputAction.next,
        maxLength: 64,
        sufixIcon: null,
      ),
    );
  }

  Widget textField3() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: CustomTextField(
        type: '',
        keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyServer,
        placeHolderMsg: "0",
        emptyFieldMsg: AppString.emptyServer,
        controller: controller.text3Controller,
        focus: controller.text3Focus,
        isSecure: false,
        borderColor: AppColors().grayLightLine,
        keyboardButtonType: TextInputAction.next,
        maxLength: 64,
        sufixIcon: null,
      ),
    );
  }

  Widget textField4() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      child: CustomTextField(
        type: '',
        keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyServer,
        placeHolderMsg: "0",
        emptyFieldMsg: AppString.emptyServer,
        controller: controller.text4Controller,
        focus: controller.text4Focus,
        isSecure: false,
        borderColor: AppColors().grayLightLine,
        keyboardButtonType: TextInputAction.next,
        maxLength: 64,
        sufixIcon: null,
      ),
    );
  }

  Widget textField5() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: CustomTextField(
        type: '',
        keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyServer,
        placeHolderMsg: "0",
        emptyFieldMsg: AppString.emptyServer,
        controller: controller.text5Controller,
        focus: controller.text5Focus,
        isSecure: false,
        borderColor: AppColors().grayLightLine,
        keyboardButtonType: TextInputAction.next,
        maxLength: 64,
        sufixIcon: null,
      ),
    );
  }

  Widget textField6() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      child: CustomTextField(
        type: '',
        keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyServer,
        placeHolderMsg: "0",
        emptyFieldMsg: AppString.emptyServer,
        controller: controller.text6Controller,
        focus: controller.text6Focus,
        isSecure: false,
        borderColor: AppColors().grayLightLine,
        keyboardButtonType: TextInputAction.next,
        maxLength: 64,
        sufixIcon: null,
      ),
    );
  }

  Widget textField7() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: CustomTextField(
        type: '',
        keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyServer,
        placeHolderMsg: "0",
        emptyFieldMsg: AppString.emptyServer,
        controller: controller.text7Controller,
        focus: controller.text7Focus,
        isSecure: false,
        borderColor: AppColors().grayLightLine,
        keyboardButtonType: TextInputAction.next,
        maxLength: 64,
        sufixIcon: null,
      ),
    );
  }

  Widget textField8() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      child: CustomTextField(
        type: '',
        keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyServer,
        placeHolderMsg: "0",
        emptyFieldMsg: AppString.emptyServer,
        controller: controller.text8Controller,
        focus: controller.text8Focus,
        isSecure: false,
        borderColor: AppColors().grayLightLine,
        keyboardButtonType: TextInputAction.done,
        maxLength: 64,
        sufixIcon: null,
      ),
    );
  }

  Widget btnView() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Reset",
              textSize: 16,
              onPress: () {
                controller.text1Controller.clear();
                controller.text2Controller.clear();
                controller.text3Controller.clear();
                controller.text4Controller.clear();
                controller.text5Controller.clear();
                controller.text6Controller.clear();
                controller.text7Controller.clear();
                controller.text8Controller.clear();
              },
              bgColor: AppColors().grayLightLine,
              isFilled: true,
              textColor: AppColors().DarkText,
              isTextCenter: true,
              isLoading: false,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            // flex: 1,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Update",
              textSize: 16,
              onPress: () {},
              bgColor: AppColors().blueColor,
              isFilled: true,
              textColor: AppColors().whiteColor,
              isTextCenter: true,
              isLoading: false,
            ),
          ),
        ],
      ),
    );
  }
}
