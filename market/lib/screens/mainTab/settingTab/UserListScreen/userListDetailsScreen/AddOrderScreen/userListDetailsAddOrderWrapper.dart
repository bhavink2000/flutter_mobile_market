import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/commonFunction.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/modelClass/allSymbolListModelClass.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../UserListDetailsScreen/AddOrderScreen/UserListDetailsAddOrderController.dart';

class UserListDetailsAddOrderScreen extends BaseView<UserListDetailsAddOrderController> {
  const UserListDetailsAddOrderScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          isTrailingDisplay: true,
          trailingIcon: SizedBox(
            width: 45,
          ),
          headerTitle: "Add Manual Order",
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
          child: Column(
            children: [
              userDetailsView(),
              buySellRadioView(),
              exchangeDetailView(),
              scriptDetailView(),
              rateDetailsView(),
              // typeDetailView(),
              // orderTypeDetailView(),
              QuantityDetailsView(),
              // rateByDetailView(),
              submitBtnView(),
              clearBtnView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buySellRadioView() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text("Order Type : ",
                style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            Spacer(),
            GestureDetector(
              onTap: () {
                if (controller.isBuy.value == true) {
                  controller.isBuy.value = false;
                } else {
                  controller.isBuy.value = true;
                }
                controller.update();
              },
              child: Container(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(
                        controller.isBuy.value == true ? AppImages.checkBoxSelectedRound : AppImages.checkBoxRound,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Buy", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                if (controller.isBuy.value == false) {
                  controller.isBuy.value = true;
                } else {
                  controller.isBuy.value = false;
                }

                controller.update();
              },
              child: Container(
                child: Row(
                  children: [
                    Container(
                      child: Image.asset(
                        controller.isBuy.value == false ? AppImages.checkBoxSelectedRound : AppImages.checkBoxRound,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Sell", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }

  Widget userDetailsView() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Row(
        children: [
          Text("User : ", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
          Spacer(),
          Container(
            height: 5.6.h,
            width: 60.w,
            child: CustomTextField(
              type: 'User Name',
              keyBoardType: TextInputType.text,
              isEnabled: false,
              isOptional: false,
              roundCornder: 0.00,
              borderColor: AppColors().grayLightLine,
              inValidMsg: AppString.emptyServer,
              placeHolderMsg: "",
              emptyFieldMsg: AppString.emptyServer,
              controller: controller.nameController,
              focus: controller.nameFocus,
              isSecure: false,
              keyboardButtonType: TextInputAction.done,
              maxLength: 64,
              sufixIcon: null,
            ),
          ),
        ],
      ),
    );
  }

  Widget exchangeDetailView() {
    return Container(
      // height: 10.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          Text("Exchange : ", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
          Spacer(),
          Container(
            height: 5.6.h,
            width: 60.w,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(3)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Obx(() {
                return Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<ExchangeData>(
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 300,
                        decoration: BoxDecoration(
                          color: AppColors().grayBg,
                        ),
                      ),
                      iconStyleData: IconStyleData(
                          icon: Image.asset(
                            AppImages.arrowDown,
                            height: 25,
                            width: 25,
                            color: AppColors().fontColor,
                          ),
                          openMenuIcon: AnimatedRotation(
                            turns: 0.5,
                            duration: const Duration(milliseconds: 400),
                            child: Image.asset(
                              AppImages.arrowDown,
                              width: 25,
                              height: 25,
                              color: AppColors().fontColor,
                            ),
                          )),
                      hint: Text(
                        'Select Exchange',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: Appfonts.family1Medium,
                            color: AppColors().lightText,
                            overflow: TextOverflow.ellipsis),
                      ),
                      items: arrExchangeList
                          .map((ExchangeData item) => DropdownMenuItem<ExchangeData>(
                                value: item,
                                child: Text(
                                  item.name ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: Appfonts.family1Medium,
                                    color: AppColors().DarkText,
                                  ),
                                ),
                              ))
                          .toList(),
                      selectedItemBuilder: (context) {
                        return arrExchangeList
                            .map((ExchangeData item) => DropdownMenuItem<ExchangeData>(
                                  value: item,
                                  child: Text(
                                    item.name ?? "",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: Appfonts.family1Medium,
                                      color: AppColors().DarkText,
                                    ),
                                  ),
                                ))
                            .toList();
                      },
                      value: controller.selectExchangedropdownValue.value.exchangeId != null
                          ? controller.selectExchangedropdownValue.value
                          : null,
                      onChanged: (ExchangeData? value) async {
                        // setState(() {
                        controller.selectExchangedropdownValue.value = value!;
                        controller.selectedScriptDropDownValue = GlobalSymbolData().obs;
                        controller.arrMainScript.clear();
                        controller.update();
                        await controller.getScriptList();
                        // });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        height: 40,
                        // width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget scriptDetailView() {
    return Container(
      // height: 10.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Row(
        children: [
          Text("Script : ", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
          Spacer(),
          Container(
            height: 5.6.h,
            width: 60.w,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(3)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Obx(() {
                return Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<GlobalSymbolData>(
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 300,
                        decoration: BoxDecoration(
                          color: AppColors().grayBg,
                        ),
                      ),
                      iconStyleData: IconStyleData(
                          icon: Image.asset(
                            AppImages.arrowDown,
                            height: 25,
                            width: 25,
                            color: AppColors().fontColor,
                          ),
                          openMenuIcon: AnimatedRotation(
                            turns: 0.5,
                            duration: const Duration(milliseconds: 400),
                            child: Image.asset(
                              AppImages.arrowDown,
                              width: 25,
                              height: 25,
                              color: AppColors().fontColor,
                            ),
                          )),
                      hint: Text(
                        'Select Script',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: Appfonts.family1Medium,
                            color: AppColors().lightText,
                            overflow: TextOverflow.ellipsis),
                      ),
                      items: controller.arrMainScript
                          .map((GlobalSymbolData item) => DropdownMenuItem<GlobalSymbolData>(
                                value: item,
                                child: Text(
                                  item.symbolTitle ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: Appfonts.family1Medium,
                                    color: AppColors().DarkText,
                                  ),
                                ),
                              ))
                          .toList(),
                      selectedItemBuilder: (context) {
                        return controller.arrMainScript
                            .map((GlobalSymbolData item) => DropdownMenuItem<GlobalSymbolData>(
                                  value: item,
                                  child: Text(
                                    item.symbolTitle ?? "",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: Appfonts.family1Medium,
                                      color: AppColors().DarkText,
                                    ),
                                  ),
                                ))
                            .toList();
                      },
                      value: controller.selectedScriptDropDownValue.value.symbolId != null
                          ? controller.selectedScriptDropDownValue.value
                          : null,
                      onChanged: (GlobalSymbolData? value) {
                        // setState(() {
                        controller.selectedScriptDropDownValue.value = value!;
                        controller.update();
                        // });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        height: 40,
                        // width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget rateDetailsView() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          Text("Rate : ", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
          Spacer(),
          SizedBox(
            height: 5.6.h,
            width: 60.w,
            child: CustomTextField(
              type: 'User Name',
              regex: "[0-9.]",
              keyBoardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
              isEnabled: true,
              isOptional: false,
              inValidMsg: AppString.emptyServer,
              placeHolderMsg: "00.00",
              emptyFieldMsg: AppString.emptyServer,
              controller: controller.rateBoxOneController,
              focus: controller.rateBoxOneFocus,
              isSecure: false,
              keyboardButtonType: TextInputAction.next,
              maxLength: 10,
              sufixIcon: null,
            ),
          ),
        ],
      ),
    );
  }

  Widget QuantityDetailsView() {
    return Container(
      // height: 10.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Row(
        children: [
          Text("Qty : ", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
          Spacer(),
          Container(
            height: 5.6.h,
            width: 60.w,
            child: CustomTextField(
              type: 'Quantity',
              regex: "[0-9]",
              keyBoardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
              isEnabled: true,
              isOptional: false,
              inValidMsg: AppString.emptyServer,
              placeHolderMsg: "",
              labelMsg: "",
              emptyFieldMsg: AppString.emptyServer,
              controller: controller.quantityController,
              focus: controller.quantityFocus,
              isSecure: false,
              keyboardButtonType: TextInputAction.done,
              maxLength: 10,
              sufixIcon: null,
            ),
          ),
        ],
      ),
    );
  }

  Widget submitBtnView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: CustomButton(
        isEnabled: true,
        shimmerColor: AppColors().whiteColor,
        title: "Submit",
        textSize: 16,
        buttonHeight: 6.5.h,
        onPress: () {
          controller.initiateManualTrade();
        },
        bgColor: AppColors().blueColor,
        isFilled: true,
        textColor: AppColors().whiteColor,
        isTextCenter: true,
        isLoading: controller.isApicall,
      ),
    );
  }

  Widget clearBtnView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      child: CustomButton(
        isEnabled: true,
        shimmerColor: AppColors().whiteColor,
        title: "Clear",
        textSize: 16,
        buttonHeight: 6.5.h,
        onPress: () {
          controller.nameController.text = "";
          controller.rateBoxOneController.text = "";
          controller.rateBoxTwoController.text = "";
          controller.quantityController.text = "";
          controller.selectExchangedropdownValue = ExchangeData().obs;
          controller.selectedScriptDropDownValue = GlobalSymbolData().obs;
          controller.typedropdownValue.value = "";
          controller.orderTypedropdownValue.value = "";
          controller.rateaBydropdownValue.value = "";
          controller.update();
        },
        borderColor: AppColors().blueColor,
        bgColor: Colors.transparent,
        isFilled: true,
        textColor: AppColors().blueColor,
        isTextCenter: true,
        isLoading: false,
      ),
    );
  }
}
