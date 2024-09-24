import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/GroupQuantitySettingScreen/quantitySettingController.dart';
import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../constant/commonWidgets.dart';

class QuantitySettingScreen extends BaseView<QuantitySettingController> {
  const QuantitySettingScreen({Key? key}) : super(key: key);

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
        headerTitle: "Quantity Settings",
        backGroundColor: AppColors().headerBgColor,
      ),
      backgroundColor: AppColors().bgColor,
      body: Column(
        children: [
          searchView(),
          UpdateQuantityContent(context),
          Expanded(
              // flex: 8,
              child: mainContent(context)
              // child: BouncingScrollWrapper.builder(context, mainContent(context), dragWithMouse: true),
              ),
        ],
      ),
    );
  }

  Widget searchView() {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors().bgColor,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Image.asset(
                    AppImages.searchIcon,
                    width: 20,
                    height: 20,
                    color: AppColors().blueColor,
                  ),
                  SizedBox(
                    width: 70.w,
                    child: TextField(
                      onTapOutside: (event) {
                        // FocusScope.of(context).unfocus();
                      },
                      textCapitalization: TextCapitalization.sentences,
                      controller: controller.textController,
                      focusNode: controller.textFocus,
                      keyboardType: TextInputType.text,
                      minLines: 1,
                      maxLines: 1,
                      // onChanged: (value) {
                      //   controller.arrUserListData.clear();
                      //   controller.arrUserListData.addAll(controller.arrMainScript);
                      //   controller.arrUserListData.retainWhere((scriptObj) {
                      //     return scriptObj.userName!.toLowerCase().contains(value.toLowerCase());
                      //   });
                      //   controller.update();
                      // },
                      textInputAction: TextInputAction.search,

                      onChanged: (value) {
                        controller.currentPage = 1;
                        controller.arrQuantitySetting.clear();
                        controller.quantitySettingList();
                      },
                      style: TextStyle(fontSize: 16.0, color: AppColors().fontColor, fontFamily: Appfonts.family1Medium),
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.w), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                          hintStyle: TextStyle(color: AppColors().placeholderColor),
                          hintText: ""),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              width: 100.w,
              color: AppColors().grayLightLine,
            ),
          ],
        ),
      ),
    );
  }

  Widget mainContent(BuildContext context) {
    return controller.isApiCallRunning
        ? displayIndicator()
        : controller.isApiCallRunning == false && controller.arrQuantitySetting.isEmpty
            ? dataNotFoundView("Data not found")
            : SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 730,
                  // margin: EdgeInsets.only(right: 1.w),
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        height: 3.h,
                        color: AppColors().bgColor,
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
                        child: PaginableListView.builder(
                            loadMore: () async {
                              if (controller.totalPage >= controller.currentPage) {
                                print(controller.currentPage);
                                controller.quantitySettingList();
                              }
                            },
                            errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                            progressIndicatorWidget: displayIndicator(),
                            physics: const ClampingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            itemCount: controller.arrQuantitySetting.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return groupContent(context, index);
                            }),
                      ),
                    ],
                  ),
                ),
              );
  }

  Widget UpdateQuantityContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      decoration: BoxDecoration(
          // color: AppColors().whiteColor,
          border: Border(
        bottom: BorderSide(color: AppColors().lightOnlyText, width: 1),
      )),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        // height: 3.h,
        // width: 90.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 20.w,
                  child: Text("Lot Max:",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: Appfonts.family1Regular,
                        color: AppColors().fontColor,
                      )),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextField(
                      regex: "[0-9]",
                      type: '',
                      keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                      isEnabled: true,
                      isOptional: false,
                      isNoNeededCapital: true,
                      inValidMsg: AppString.emptyName,
                      placeHolderMsg: "Enter Lot Max",
                      labelMsg: "",
                      emptyFieldMsg: AppString.emptyName,
                      controller: controller.lotMaxController,
                      focus: controller.lotMaxFocus,
                      isSecure: false,
                      keyboardButtonType: TextInputAction.next,
                      maxLength: 20,
                      // isShowPrefix: false,
                      // isShowSufix: false,
                      sufixIcon: null,
                      prefixIcon: null,
                      borderColor: AppColors().lightText,
                      roundCornder: 0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 20.w,
                  child: Text("Qty Max:",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: Appfonts.family1Regular,
                        color: AppColors().fontColor,
                      )),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextField(
                      regex: "[0-9]",
                      type: '',
                      keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                      isEnabled: true,
                      isOptional: false,
                      isNoNeededCapital: true,
                      inValidMsg: AppString.emptyName,
                      placeHolderMsg: "Enter Qty Max",
                      labelMsg: "",
                      emptyFieldMsg: AppString.emptyName,
                      controller: controller.qtyMaxController,
                      focus: controller.qtyMaxFocus,
                      isSecure: false,
                      keyboardButtonType: TextInputAction.next,
                      maxLength: 20,
                      // isShowPrefix: false,
                      // isShowSufix: false,
                      sufixIcon: null,
                      prefixIcon: null,
                      borderColor: AppColors().lightText,
                      roundCornder: 0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 20.w,
                  child: Text("Breakup Qty:",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: Appfonts.family1Regular,
                        color: AppColors().fontColor,
                      )),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextField(
                      regex: "[0-9]",
                      type: '',

                      keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                      isEnabled: true,
                      isOptional: false,
                      isNoNeededCapital: true,
                      inValidMsg: AppString.emptyName,
                      placeHolderMsg: "Enter Breakup Qty",
                      labelMsg: "",
                      emptyFieldMsg: AppString.emptyName,
                      controller: controller.brkQtyController,
                      focus: controller.brkQtyFocus,
                      isSecure: false,
                      keyboardButtonType: TextInputAction.next,
                      maxLength: 20,
                      // isShowPrefix: false,
                      // isShowSufix: false,
                      sufixIcon: null,
                      prefixIcon: null,
                      borderColor: AppColors().lightText,
                      roundCornder: 0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 20.w,
                  child: Text("Breakup Lot:",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: Appfonts.family1Regular,
                        color: AppColors().fontColor,
                      )),
                ),
                Expanded(
                  child: Container(
                    // width: 150,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextField(
                      regex: "[0-9]",
                      type: '',
                      keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                      isEnabled: true,
                      isOptional: false,
                      isNoNeededCapital: true,
                      inValidMsg: AppString.emptyName,
                      placeHolderMsg: "Enter Breakup Lot",
                      labelMsg: "",
                      emptyFieldMsg: AppString.emptyName,
                      controller: controller.brkLotController,
                      focus: controller.brkLotFocus,
                      isSecure: false,
                      keyboardButtonType: TextInputAction.next,
                      maxLength: 20,
                      // isShowPrefix: false,
                      // isShowSufix: false,
                      sufixIcon: null,
                      prefixIcon: null,
                      borderColor: AppColors().lightText,
                      roundCornder: 0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 95.w,
              child: CustomButton(
                isEnabled: controller.isAllNotEmpty(),
                // noNeedBorderRadius: true,
                shimmerColor: AppColors().whiteColor,
                title: "Update",
                textSize: 14,
                onPress: () {
                  if (controller.isAllNotEmpty()) {
                    controller.updateQuantity();
                  }
                },
                bgColor: controller.isAllNotEmpty() ? AppColors().blueColor : AppColors().grayLightLine,
                isFilled: true,
                textColor: controller.isAllNotEmpty() ? AppColors().whiteColor : AppColors().DarkText,
                isTextCenter: true,
                isLoading: controller.isApiCallRunning,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget groupContent(BuildContext context, int index) {
    var quantityValue = controller.arrQuantitySetting[index];
    return GestureDetector(
      onTap: () {
        // controller.selectedScriptIndex = index;
        controller.update();
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            valueBox("", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, Colors.transparent, index,
                isImage: true,
                strImage: quantityValue.isSelected ? AppImages.checkBoxSelected : AppImages.checkBox, onClickImage: () {
              controller.arrQuantitySetting[index].isSelected = !controller.arrQuantitySetting[index].isSelected;
              for (var element in controller.arrQuantitySetting) {
                if (element.isSelected) {
                  controller.isAllSelected = true;
                } else {
                  controller.isAllSelected = false;
                  break;
                }
              }
              controller.update();
            }),
            valueBox(
              quantityValue.symbolName ?? "",
              150,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
            valueBox(quantityValue.lotMax.toString(), 80, index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText, index),
            valueBox(
              quantityValue.quantityMax.toString(),
              80,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
            valueBox(
              quantityValue.breakQuantity.toString(),
              110,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
            valueBox(
              quantityValue.breakUpLot.toString(),
              110,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
            valueBox(
              quantityValue.updatedAt != null ? shortFullDateTime(quantityValue.updatedAt!) : "",
              150,
              index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              AppColors().DarkText,
              index,
            ),
          ],
        ),
      ),
    );
  }

  Widget listTitleContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleBox("",
            width: 45,
            isImage: true,
            strImage: controller.isAllSelected ? AppImages.checkBoxSelected : AppImages.checkBox, onClickImage: () {
          if (controller.isAllSelected) {
            controller.arrQuantitySetting.forEach((element) {
              element.isSelected = false;
            });
            controller.isAllSelected = false;
            controller.update();
          } else {
            controller.arrQuantitySetting.forEach((element) {
              element.isSelected = true;
            });
            controller.isAllSelected = true;
            controller.update();
          }
        }),
        titleBox("Script", width: 150),
        titleBox("Lot Max", width: 80),
        titleBox("Qty Max", width: 80),
        titleBox("Breakup Qty", width: 110),
        titleBox("Breakup Lot", width: 110),
        titleBox("Last Updated", width: 150),
      ],
    );
  }
}
