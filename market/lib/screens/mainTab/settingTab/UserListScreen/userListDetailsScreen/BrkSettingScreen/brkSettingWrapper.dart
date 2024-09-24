import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/BrkSettingScreen/brkSettingController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../navigation/routename.dart';

class BrkSettingScreen extends BaseView<BrkSettingController> {
  const BrkSettingScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
          },
          isTrailingDisplay: true,
          trailingIcon: Image.asset(
            AppImages.settingUser6,
            width: 20,
            height: 20,
            color: AppColors().DarkText,
          ),
          onTrailingButtonPress: () {
            Get.offAndToNamed(RouterName.GroupQuantityScreen, arguments: {"userId": controller.selectedUserId});
          },
          headerTitle: "BRK SETTINGS",
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
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: AppColors().bgColor,
        ),
        child: Column(
          children: [
            searchView(),
            BRKtopView(),
            SizedBox(
              height: 20,
            ),
            amountField(),
            btnField(),
            SelectedView(),
            Expanded(
              child: controller.isApiCallRunning
                  ? displayIndicator()
                  : controller.isApiCallRunning == false && controller.arrBrokerage.isEmpty
                      ? dataNotFoundView("Data not found")
                      : PaginableListView.builder(
                          loadMore: () async {
                            if (controller.totalPage >= controller.currentPage) {
                              print(controller.currentPage);
                              controller.userWiseBrkList();
                            }
                          },
                          errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                          progressIndicatorWidget: displayIndicator(),
                          physics: const ClampingScrollPhysics(),
                          clipBehavior: Clip.hardEdge,
                          itemCount: controller.arrBrokerage.length,
                          controller: controller.listcontroller,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return clientSelectedView(context, index);
                          }),
            ),
          ],
        ),
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
              // margin: const EdgeInsets.symmetric(vertical: 15),
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
                      onEditingComplete: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.currentPage = 1;
                        controller.userWiseBrkList(isFromFilter: true);
                      },
                      onChanged: (value) {
                        controller.currentPage = 1;
                        controller.userWiseBrkList(isFromFilter: true);
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
                  const Spacer(),
                  Container(
                    height: 5.h,
                    width: 5.w,
                    child: GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Future.delayed(Duration(milliseconds: 400), () {
                          showPopupDialog(
                              message: "Filter".tr,
                              subMessage: "",
                              DeleteClick: () {
                                controller.update();
                                Get.back();
                              },
                              CancelClick: () {
                                controller.update();
                                Get.back();
                              });
                        });
                      },
                      child: Image.asset(
                        AppImages.filterIcon,
                        width: 20,
                        height: 20,
                        color: AppColors().blueColor,
                      ),
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

  Widget BRKtopView() {
    return Container(
      width: 100.w,
      // height: 5.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      margin: EdgeInsets.only(top: 5.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.isTurnOverBtnSelected == "1" ? AppColors().redColor : AppColors().grayLightLine,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(3)),
              child: CustomButton(
                isEnabled: true,
                shimmerColor: AppColors().whiteColor,
                title: "TURNOVER WISE",
                // buttonWidth: 100.w,
                textSize: 14,
                buttonHeight: 6.5.h,
                onPress: () {
                  if (controller.isTurnOverBtnSelected != "1") {
                    controller.isTurnOverBtnSelected = "1";
                    controller.getExchangeList();
                    controller.update();
                    // controller.selectExchangedropdownValue = ExchangeData().obs;
                    if (controller.selectExchangedropdownValue.value.exchangeId != null || controller.textController.text.isNotEmpty) {
                      controller.currentPage = 1;
                      controller.userWiseBrkList(isFromFilter: true);
                    }
                    // controller.userWiseBrkList();
                  }
                },
                bgColor: AppColors().bgColor,
                isFilled: true,
                textColor: controller.isTurnOverBtnSelected == "1" ? AppColors().redColor : AppColors().DarkText,
                isTextCenter: true,
                isLoading: false,
              ),
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.isTurnOverBtnSelected == "" ? AppColors().redColor : AppColors().grayLightLine,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(3)),
              child: CustomButton(
                isEnabled: true,
                shimmerColor: AppColors().whiteColor,
                title: "SYMBOL WISE",
                // buttonWidth: 100.w,
                textSize: 14,
                buttonHeight: 6.5.h,
                onPress: () {
                  if (controller.isTurnOverBtnSelected != "") {
                    controller.isTurnOverBtnSelected = "";
                    controller.getExchangeList();
                    controller.update();
                    if (controller.selectExchangedropdownValue.value.exchangeId != null || controller.textController.text.isNotEmpty) {
                      controller.currentPage = 1;
                      controller.userWiseBrkList(isFromFilter: true);
                    }
                    // controller.selectExchangedropdownValue = ExchangeData().obs;
                    // controller.userWiseBrkList();
                  }
                },
                bgColor: AppColors().bgColor,
                isFilled: true,
                textColor: controller.isTurnOverBtnSelected == "" ? AppColors().redColor : AppColors().DarkText,
                isTextCenter: true,
                isLoading: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget amountField() {
    return Container(
      height: 6.5.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: CustomTextField(
        type: '',
        keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
        isEnabled: true,
        isOptional: false,
        inValidMsg: AppString.emptyServer,
        placeHolderMsg: "Enter Amount",
        emptyFieldMsg: AppString.emptyServer,
        controller: controller.amountController,
        focus: controller.amountFocus,
        isSecure: false,
        keyboardButtonType: TextInputAction.done,
        maxLength: 64,
        sufixIcon: null,
      ),
    );
  }

  Widget btnField() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      child: Row(
        children: [
          Expanded(
            // flex: 1,
            child: CustomButton(
              isEnabled: controller.amountController.text.isNotEmpty,
              shimmerColor: AppColors().whiteColor,
              title: "Update",
              textSize: 16,
              buttonHeight: 6.5.h,
              onPress: () {
                if (controller.amountController.text.isNotEmpty) {
                  hideKeyboard();
                  controller.updateBrk();
                }
              },
              bgColor: controller.amountController.text.isNotEmpty ? AppColors().blueColor : AppColors().grayLightLine,
              isFilled: true,
              textColor: controller.amountController.text.isNotEmpty ? AppColors().whiteColor : AppColors().DarkText,
              isTextCenter: true,
              isLoading: controller.isupdateCallRunning,
            ),
          ),
        ],
      ),
    );
  }

  Widget SelectedView() {
    return Container(
      margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 0),
      child: Column(
        children: [
          Container(
            height: 5.h,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              color: AppColors().grayLightLine,
              width: 1.5,
            ))),
            child: Row(
              children: [
                Container(
                  // width: 5.h,
                  height: 5.h,
                  decoration: BoxDecoration(
                      border: Border(
                    left: BorderSide(
                      color: AppColors().grayLightLine,
                      width: 1.5,
                    ),
                    bottom: BorderSide(
                      color: AppColors().grayLightLine,
                      width: 1.5,
                    ),
                    right: BorderSide(
                      color: AppColors().grayLightLine,
                      width: 1.5,
                    ),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.isAllSelected) {
                            controller.arrBrokerage.forEach((element) {
                              element.isSelected = false;
                            });
                            controller.isAllSelected = false;
                            controller.update();
                          } else {
                            controller.arrBrokerage.forEach((element) {
                              element.isSelected = true;
                            });
                            controller.isAllSelected = true;
                            controller.update();
                          }
                        },
                        child: SizedBox(
                          width: 40,
                          child: Image.asset(
                            controller.isAllSelected ? AppImages.checkBoxSelected : AppImages.checkBox,
                            height: 21,
                            width: 21,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      right: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                      bottom: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                    )),
                    child: Center(child: Text("Script Name", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText))),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      right: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                      bottom: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                    )),
                    child: Center(child: Text("BRK", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget clientSelectedView(BuildContext context, int index) {
    var brkValue = controller.arrBrokerage[index];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          Container(
            height: 5.h,
            decoration: BoxDecoration(
                border: Border(
                    // top: controller.arrData[index] == 0
                    //     ? BorderSide(
                    //         color: AppColors().grayLightLine,
                    //         width: 1.5,
                    //       )
                    //     : const BorderSide(
                    //         color: Colors.transparent,
                    //         width: 1.5,
                    //       ),
                    )),
            child: Row(
              children: [
                Container(
                  // width: 5.h,
                  height: 5.h,
                  decoration: BoxDecoration(
                      border: Border(
                    left: BorderSide(
                      color: AppColors().grayLightLine,
                      width: 1.5,
                    ),
                    bottom: BorderSide(
                      color: AppColors().grayLightLine,
                      width: 1.5,
                    ),
                    right: BorderSide(
                      color: AppColors().grayLightLine,
                      width: 1.5,
                    ),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.arrBrokerage[index].isSelected = !controller.arrBrokerage[index].isSelected;
                          for (var element in controller.arrBrokerage) {
                            if (element.isSelected) {
                              controller.isAllSelected = true;
                            } else {
                              controller.isAllSelected = false;
                              break;
                            }
                          }
                          controller.update();
                        },
                        child: SizedBox(
                          width: 40,
                          child: Image.asset(
                            controller.arrBrokerage[index].isSelected ? AppImages.checkBoxSelected : AppImages.checkBox,
                            height: 21,
                            width: 21,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      right: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                      bottom: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                    )),
                    child: Center(child: Text(brkValue.symbolName ?? "", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      right: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                      bottom: BorderSide(
                        color: AppColors().grayLightLine,
                        width: 1.5,
                      ),
                    )),
                    child: Center(child: Text(brkValue.brokeragePrice!.toStringAsFixed(2), textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showPopupDialog({String? message, String? subMessage, Function? CancelClick, Function? DeleteClick}) {
    showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
              titlePadding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
              backgroundColor: AppColors().bgColor,
              surfaceTintColor: AppColors().bgColor,
              insetPadding: EdgeInsets.symmetric(
                horizontal: 0.w,
                vertical: 32.h,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    message ?? "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors().DarkText,
                      fontFamily: Appfonts.family1SemiBold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    height: 6.5.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors().grayLightLine,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(3)),
                    // color: AppColors().whiteColor,
                    padding: const EdgeInsets.only(right: 10),
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
                            ),
                            hint: Text(
                              'Select Exchange',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: Appfonts.family1Medium,
                                color: AppColors().DarkText,
                              ),
                            ),
                            items: controller.arrExchangeList
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
                              return controller.arrExchangeList
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
                            value: controller.selectExchangedropdownValue.value.name != null ? controller.selectExchangedropdownValue.value : null,
                            onChanged: (ExchangeData? value) {
                              // setState(() {
                              controller.selectExchangedropdownValue.value = value!;
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
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 6.5.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 36.w,
                          child: CustomButton(
                            isEnabled: true,
                            shimmerColor: AppColors().whiteColor,
                            title: "Reset",
                            textSize: 16,
                            // buttonWidth: 36.w,
                            onPress: () {
                              controller.arrBrokerage.clear();
                              controller.currentPage = 1;
                              Get.back();
                              controller.update();
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
                        SizedBox(
                          width: 36.w,
                          // padding: EdgeInsets.only(right: 10),
                          child: CustomButton(
                            isEnabled: true,
                            shimmerColor: AppColors().whiteColor,
                            title: "Done",
                            textSize: 16,
                            // buttonWidth: 36.w,
                            onPress: () {
                              controller.currentPage = 1;
                              controller.userWiseBrkList(isFromFilter: true);
                              Get.back();
                            },
                            bgColor: AppColors().blueColor,
                            isFilled: true,
                            textColor: AppColors().whiteColor,
                            isTextCenter: true,
                            isLoading: false,
                          ),
                        ),
                        // SizedBox(width: 5.w,),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
