import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/commonFunction.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/brokerListModelClass.dart';
import 'package:market/modelClass/groupListModelClass.dart';
import 'package:market/modelClass/userRoleListModelClass.dart';
import 'package:market/screens/mainTab/settingTab/CreateNewUserScreen/settingCreateNewUserController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constant/color.dart';
import '../../../../constant/utilities.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../BaseViewController/baseController.dart';
import '../../tabScreen/MainTabController.dart';

class SettingCreateNewUserScreen extends BaseView<SettingCreateNewUserController> {
  const SettingCreateNewUserScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return PopScope(
      canPop: controller.isAPICallRunning.isFalse,
      child: IgnorePointer(
        ignoring: controller.isAPICallRunning.isTrue,
        child: Scaffold(
          appBar: appNavigationBar(
              isBackDisplay: true,
              onBackButtonPress: () {
                Get.back();
              },
              isTrailingDisplay: true,
              trailingIcon: SizedBox(
                width: 45,
              ),
              headerTitle: controller.arrUserDetailsData1 != null ? "Edit User" : "Create New User",
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
            child: Column(
              children: [
                IgnorePointer(
                  ignoring: controller.arrUserDetailsData1 != null,
                  child: userTypeDropDown(),
                ),
                if (controller.isUserDataLoadRunning.value) Expanded(child: Center(child: displayIndicator())),
                if (controller.isUserDataLoadRunning.value == false) formDataView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userTypeDropDown() {
    return Container(
      color: AppColors().headerBgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Row(
          children: [
            Text("User Type", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Container(
              width: 150,
              height: 50,
              color: AppColors().bgColor,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Obx(() {
                  return Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<userRoleListData>(
                        isExpanded: true,
                        iconStyleData: IconStyleData(
                            icon: Image.asset(
                              AppImages.arrowDown,
                              height: 20,
                              width: 20,
                              color: AppColors().fontColor,
                            ),
                            openMenuIcon: AnimatedRotation(
                              turns: 0.5,
                              duration: const Duration(milliseconds: 400),
                              child: Image.asset(
                                AppImages.arrowDown,
                                width: 20,
                                height: 20,
                                color: AppColors().fontColor,
                              ),
                            )),
                        hint: Text(
                          'Select User Type',
                          maxLines: 1,
                          style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
                        ),
                        items: arrUserRoleList
                            .map((userRoleListData item) => DropdownMenuItem<userRoleListData>(
                                  value: item,
                                  child: Text(item.name ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                ))
                            .toList(),
                        selectedItemBuilder: (context) {
                          return arrUserRoleList
                              .map((userRoleListData item) => DropdownMenuItem<userRoleListData>(
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
                        value: controller.dropdownValue.value.roleId != null ? controller.dropdownValue.value : null,
                        onChanged: (userRoleListData? value) {
                          controller.dropdownValue.value = value!;
                          controller.nameController.text = "";
                          controller.userNameController.text = "";
                          controller.passwordController.text = "";
                          controller.retypeController.text = "";
                          controller.numberController.text = "";
                          controller.cutOffController.text = "";
                          controller.creditController.text = "";
                          controller.remarkController.text = "";
                          controller.leverageSelectionValue.value = "";
                          controller.profitController.text = "";
                          controller.brkController.text = "";
                          controller.isAddMaster.value = false;
                          controller.isModifyOrder.value = false;
                          controller.isManualOrder.value = false;
                          controller.isIntraday.value = false;
                          controller.isChangePassword.value = false;
                          controller.isSelectedallExchangeinMaster.value = false;
                          controller.selectBrokerSelectionValue.value = "";
                          for (var i = 0; i < controller.arrExchangeList.length; i++) {
                            if (controller.arrExchangeList[i].isSelected == true) {
                              controller.arrExchangeList[i].isSelected = false;
                            }
                            if (controller.arrExchangeList[i].isTurnOverSelected == true) {
                              controller.arrExchangeList[i].isTurnOverSelected = false;
                            }
                            if (controller.arrExchangeList[i].isSymbolSelected == true) {
                              controller.arrExchangeList[i].isSymbolSelected = false;
                            }
                            if (controller.arrExchangeList[i].isHighLowTradeSelected == true) {
                              controller.arrExchangeList[i].isHighLowTradeSelected = false;
                            }
                            if (controller.arrExchangeList[i].isDropDownValueSelected.value != "") {
                              controller.arrExchangeList[i].isDropDownValueSelected.value = "";
                            }
                            if (controller.arrExchangeList[i].selectedItems.isNotEmpty) {
                              controller.arrExchangeList[i].selectedItems.clear();
                            }
                          }
                          controller.arrSelectedGroupListIDforOthers.clear();
                          controller.arrSelectedGroupListIDforNSE.clear();
                          controller.arrSelectedGroupListIDforMCX.clear();
                          controller.arrSelectedDropDownValueClient.clear();
                          controller.arrSelectedExchangeList.clear();
                          controller.arrHighLowBetweenTradeSelectedList.clear();
                          controller.update();
                        },
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 300,
                          decoration: BoxDecoration(
                            color: AppColors().grayBg,
                          ),
                        ),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          // height: 54,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 54,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formDataView() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 2.h),
        decoration: BoxDecoration(color: AppColors().bgColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text("Personal Details", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField(
                  regex: "[a-zA-Z ]",
                  type: 'Name',
                  keyBoardType: TextInputType.text,
                  isEnabled: true,
                  isOptional: false,
                  inValidMsg: AppString.emptyName,
                  placeHolderMsg: "Name",
                  labelMsg: "Name",
                  emptyFieldMsg: AppString.emptyName,
                  controller: controller.nameController,
                  focus: controller.nameFocus,
                  isSecure: false,
                  keyboardButtonType: TextInputAction.next,
                  maxLength: 20,
                  sufixIcon: null,
                ),
                if (controller.arrUserDetailsData1 == null)
                  SizedBox(
                    height: 2.h,
                  ),
                if (controller.arrUserDetailsData1 == null)
                  CustomTextField(
                    regex: "[a-zA-Z,#@!0-9]",
                    type: 'User Name',
                    keyBoardType: TextInputType.text,
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: AppString.emptyUserName,
                    placeHolderMsg: "User Name",
                    labelMsg: "User Name",
                    emptyFieldMsg: AppString.emptyUserName,
                    controller: controller.userNameController,
                    focus: controller.userNameFocus,
                    isSecure: false,
                    keyboardButtonType: TextInputAction.next,
                    maxLength: 20,
                    sufixIcon: null,
                  ),
                SizedBox(
                  height: 2.h,
                ),
                if (controller.arrUserDetailsData1 == null)
                  CustomTextField(
                    type: 'Password',
                    keyBoardType: TextInputType.text,
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: AppString.emptyPassword,
                    placeHolderMsg: "Password",
                    labelMsg: "Password",
                    emptyFieldMsg: AppString.emptyPassword,
                    controller: controller.passwordController,
                    focus: controller.passwordFocus,
                    isSecure: controller.isEyeOpen,
                    keyboardButtonType: TextInputAction.next,
                    maxLength: 20,
                    sufixIcon: GestureDetector(
                      onTap: () {
                        controller.isEyeOpen = !controller.isEyeOpen;
                        controller.update();
                      },
                      child: Image.asset(
                        controller.isEyeOpen ? AppImages.eyeCloseIcon : AppImages.eyeOpenIcon,
                        width: 22,
                        height: 22,
                      ),
                    ),
                  ),
                if (controller.dropdownValue.value.roleId != UserRollList.broker && controller.arrUserDetailsData1 == null)
                  SizedBox(
                    height: 2.h,
                  ),
                if (controller.dropdownValue.value.roleId != UserRollList.broker && controller.arrUserDetailsData1 == null)
                  CustomTextField(
                    type: 'Retype Password',
                    keyBoardType: TextInputType.text,
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: AppString.emptyRetypePassword,
                    placeHolderMsg: "Retype Password",
                    labelMsg: "Retype Password",
                    emptyFieldMsg: AppString.emptyRetypePassword,
                    controller: controller.retypeController,
                    focus: controller.retypeFocus,
                    isSecure: controller.confirmIsEyeOpen,
                    keyboardButtonType: TextInputAction.next,
                    maxLength: 20,
                    sufixIcon: GestureDetector(
                      onTap: () {
                        controller.confirmIsEyeOpen = !controller.confirmIsEyeOpen;
                        controller.update();
                      },
                      child: Image.asset(
                        controller.confirmIsEyeOpen ? AppImages.eyeCloseIcon : AppImages.eyeOpenIcon,
                        width: 22,
                        height: 22,
                      ),
                    ),
                  ),
                if (controller.dropdownValue.value.roleId != UserRollList.broker && controller.arrUserDetailsData1 == null)
                  SizedBox(
                    height: 2.h,
                  ),
                if (controller.dropdownValue.value.roleId != UserRollList.broker)
                  CustomTextField(
                    type: 'Mobile Number',
                    keyBoardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: AppString.emptyMobileNumber,
                    placeHolderMsg: "Mobile Number",
                    labelMsg: "Mobile Number",
                    emptyFieldMsg: AppString.emptyMobileNumber,
                    controller: controller.numberController,
                    focus: controller.numberFocus,
                    isSecure: false,
                    keyboardButtonType: TextInputAction.next,
                    maxLength: 10,
                    sufixIcon: null,
                  ),
                if (controller.dropdownValue.value.roleId != UserRollList.broker && controller.arrUserDetailsData1 == null)
                  SizedBox(
                    height: 2.h,
                  ),
                // CustomTextField(
                //   type: 'City',
                //   keyBoardType: TextInputType.text,
                //   isEnabled: true,
                //   isOptional: false,
                //   inValidMsg: AppString.emptyCity,
                //   placeHolderMsg: "City",
                //   labelMsg: "City",
                //   emptyFieldMsg: AppString.emptyCity,
                //   controller: controller.cityController,
                //   focus: controller.cityFocus,
                //   isSecure: false,
                //   keyboardButtonType: TextInputAction.next,
                //   maxLength: 64,
                //   sufixIcon: null,
                // ),
                // SizedBox(
                //   height: 2.h,
                // ),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user) && controller.arrUserDetailsData1 == null)
                  CustomTextField(
                    regex: "[0-9]",
                    type: 'Credit',
                    keyBoardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: AppString.emptyCredit,
                    placeHolderMsg: "Credit",
                    labelMsg: "Credit",
                    emptyFieldMsg: AppString.emptyCredit,
                    controller: controller.creditController,
                    focus: controller.creditFocus,
                    isSecure: false,
                    keyboardButtonType: TextInputAction.next,
                    maxLength: 9,
                    sufixIcon: null,
                    onChange: () {
                      controller.update();
                    },
                  ),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user) && controller.creditController.text.isNotEmpty && controller.arrUserDetailsData1 == null)
                  Container(
                    width: 90.w,
                    // color: Colors.red,
                    child: Text(controller.creditController.text.isNotEmpty ? controller.numericToWord() : "", maxLines: 5, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                  ),
                if (controller.dropdownValue.value.roleId == UserRollList.user)
                  SizedBox(
                    height: 2.h,
                  ),
                if (controller.dropdownValue.value.roleId == UserRollList.user)
                  CustomTextField(
                    regex: "[0-9]",
                    type: 'Cut Off',
                    keyBoardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: AppString.emptyCutOff,
                    placeHolderMsg: "Cut Off",
                    labelMsg: "Cut Off",
                    emptyFieldMsg: AppString.emptyCredit,
                    controller: controller.cutOffController,
                    focus: controller.cutOffFocus,
                    isSecure: false,
                    keyboardButtonType: TextInputAction.next,
                    maxLength: 3,
                    sufixIcon: null,
                    onChange: () {
                      if (controller.cutOffController.text.isNotEmpty) {
                        controller.isCutOffHasValue.value = true;
                        controller.isAddMaster.value = true;
                        controller.update();
                      } else {
                        controller.isCutOffHasValue.value = false;
                        controller.isAddMaster.value = false;
                        controller.update();
                      }
                    },
                  ),
                if (controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user)
                  SizedBox(
                    height: 2.h,
                  ),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user) && controller.arrUserDetailsData1 == null) leverageDropDown(),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user) && controller.arrUserDetailsData1 == null)
                  SizedBox(
                    height: 2.h,
                  ),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user))
                  CustomTextField(
                    type: 'Remark',
                    keyBoardType: TextInputType.text,
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: AppString.emptyRemark,
                    placeHolderMsg: "Remark",
                    labelMsg: "Remark",
                    emptyFieldMsg: AppString.emptyRemark,
                    controller: controller.remarkController,
                    focus: controller.remarkFocus,
                    isSecure: false,
                    keyboardButtonType: controller.dropdownValue.value.roleId == UserRollList.user ? TextInputAction.done : TextInputAction.next,
                    maxLength: 100,
                    sufixIcon: null,
                  ),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user))
                  SizedBox(
                    height: 2.h,
                  ),
                if (controller.dropdownValue.value.roleId == UserRollList.admin) adminTopView(),
                if (((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user)) && controller.arrUserDetailsData1 == null)
                  Container(
                    child: Text("Partnership share Detail", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                  ),

                if (controller.dropdownValue.value.roleId == UserRollList.user) clientSelectedView(),
                if (controller.dropdownValue.value.roleId == UserRollList.master) masterSelectedView(),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user))
                  SizedBox(
                    height: 2.h,
                  ),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user))
                  Container(
                    child: Text("High Low Between Trade Limit", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                  ),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user))
                  SizedBox(
                    height: 1.h,
                  ),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user))
                  Container(
                    // height: 3.h,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 3.5),
                        physics: const NeverScrollableScrollPhysics(),
                        clipBehavior: Clip.hardEdge,
                        itemCount: controller.arrExchangeList.length,
                        controller: controller.listcontroller,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return highLowBetWeenTradeView(context, index);
                        }),
                  ),
                if (controller.dropdownValue.value.roleId == UserRollList.master)
                  SizedBox(
                    height: 2.h,
                  ),
                // if (controller.dropdownValue.value.roleId == UserRollList.master) multiGroupDropDown(),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user))
                  SizedBox(
                    height: controller.dropdownValue.value.roleId == UserRollList.master ? 0.h : 3.h,
                  ),
                if ((controller.dropdownValue.value.roleId == UserRollList.master || controller.dropdownValue.value.roleId == UserRollList.user))
                  Container(
                    child: Column(
                      children: [
                        if (controller.dropdownValue.value.roleId != UserRollList.broker)
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (controller.cutOffController.text.isEmpty) {
                                    controller.isAddMaster.value = !controller.isAddMaster.value;
                                    controller.update();
                                  }
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      controller.isAddMaster.value ? AppImages.checkBoxSelected : AppImages.checkBox,
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 1.h,
                                    ),
                                    Text(controller.dropdownValue.value.roleId == UserRollList.user ? "Auto Square Off" : "Add Master", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (controller.dropdownValue.value.roleId != UserRollList.broker)
                          SizedBox(
                            height: 1.5.h,
                          ),
                        if (controller.dropdownValue.value.roleId == UserRollList.master)
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.isManualOrder.value = !controller.isManualOrder.value;
                                  controller.update();
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      controller.isManualOrder.value ? AppImages.checkBoxSelected : AppImages.checkBox,
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 1.h,
                                    ),
                                    Text("Market Order", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 37.2.w,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (userData!.highLowSLLimitPercentage == false) {
                                  controller.isSymbolWiseSL.value = !controller.isSymbolWiseSL.value;
                                  controller.update();
                                }
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    controller.isSymbolWiseSL.value ? AppImages.checkBoxSelected : AppImages.checkBox,
                                    height: 25,
                                    width: 25,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Text("Symbol wise SL/Limit(%)", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 37.2.w,
                            ),
                          ],
                        ),
                        if (controller.dropdownValue.value.roleId == UserRollList.user)
                          SizedBox(
                            height: 1.5.h,
                          ),
                        if (controller.dropdownValue.value.roleId == UserRollList.user)
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.isFreshLimitSL.value = !controller.isFreshLimitSL.value;
                                  controller.update();
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      controller.isFreshLimitSL.value ? AppImages.checkBoxSelected : AppImages.checkBox,
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 1.h,
                                    ),
                                    Text("Fresh Limit SL", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 37.2.w,
                              ),
                            ],
                          ),
                        if (controller.dropdownValue.value.roleId != UserRollList.user)
                          SizedBox(
                            height: 1.5.h,
                          ),
                        if (controller.dropdownValue.value.roleId != UserRollList.user && controller.arrUserDetailsData1 == null)
                          GestureDetector(
                            onTap: () {
                              controller.isChangePassword.value = !controller.isChangePassword.value;
                              controller.update();
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  controller.isChangePassword.value ? AppImages.checkBoxSelected : AppImages.checkBox,
                                  height: 25,
                                  width: 25,
                                ),
                                SizedBox(
                                  width: 1.h,
                                ),
                                Text("Change Password On First Login", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                              ],
                            ),
                          ),
                        // if (controller.dropdownValue.value.roleId ==
                        //     UserRollList.user)
                        //   SizedBox(
                        //     height: 1.5.h,
                        //   ),
                        // if (controller.dropdownValue.value.roleId ==
                        //     UserRollList.user)
                        //   clientBrokerageView(),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 2.h,
                ),
                CustomButton(
                  isEnabled: true,
                  shimmerColor: AppColors().whiteColor,
                  title: controller.arrUserDetailsData1 == null ? "CREATE" : "UPDATE",
                  textSize: 16,
                  onPress: () {
                    controller.onSubmitClicked();
                  },
                  bgColor: AppColors().blueColor,
                  isFilled: true,
                  textColor: AppColors().whiteColor,
                  isTextCenter: true,
                  isLoading: controller.isAPICallRunning.value,
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget adminTopView() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text("CMP Order", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (controller.isCmpOrder == true) {
                      controller.isCmpOrder = null;
                    } else {
                      controller.isCmpOrder = true;
                    }
                    controller.update();
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            controller.isCmpOrder == true ? AppImages.checkBoxSelectedRound : AppImages.checkBoxRound,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Yes", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.isCmpOrder == false) {
                      controller.isCmpOrder = null;
                    } else {
                      controller.isCmpOrder = false;
                    }

                    controller.update();
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            controller.isCmpOrder == false ? AppImages.checkBoxSelectedRound : AppImages.checkBoxRound,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("No", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (controller.dropdownValue.value.roleId == UserRollList.superAdmin)
            SizedBox(
              height: 2.h,
            ),
          if (controller.dropdownValue.value.roleId == UserRollList.superAdmin)
            Container(
              child: Row(
                children: [
                  Container(
                    child: Text("Manual Order", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (controller.isAdminManualOrder == true) {
                        controller.isAdminManualOrder = null;
                      } else {
                        controller.isAdminManualOrder = true;
                      }
                      controller.update();
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset(
                              controller.isAdminManualOrder == true ? AppImages.checkBoxSelectedRound : AppImages.checkBoxRound,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Yes", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.isAdminManualOrder == false) {
                        controller.isAdminManualOrder = null;
                      } else {
                        controller.isAdminManualOrder = false;
                      }
                      controller.update();
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset(
                              controller.isAdminManualOrder == false ? AppImages.checkBoxSelectedRound : AppImages.checkBoxRound,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("No", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text("Delete Trade", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (controller.isDeleteTrade == true) {
                      controller.isDeleteTrade = null;
                    } else {
                      controller.isDeleteTrade = true;
                    }
                    controller.update();
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            controller.isDeleteTrade == true ? AppImages.checkBoxSelectedRound : AppImages.checkBoxRound,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Yes", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.isDeleteTrade == false) {
                      controller.isDeleteTrade = null;
                    } else {
                      controller.isDeleteTrade = false;
                    }
                    controller.update();
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            controller.isDeleteTrade == false ? AppImages.checkBoxSelectedRound : AppImages.checkBoxRound,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("No", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      child: Text("Execute Pending Order", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (controller.isExecutePendingOrder == true) {
                          controller.isExecutePendingOrder = null;
                        } else {
                          controller.isExecutePendingOrder = true;
                        }

                        controller.update();
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Image.asset(
                                controller.isExecutePendingOrder == true ? AppImages.checkBoxSelectedRound : AppImages.checkBoxRound,
                                height: 20,
                                width: 20,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Yes", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.isExecutePendingOrder == false) {
                          controller.isExecutePendingOrder = null;
                        } else {
                          controller.isExecutePendingOrder = false;
                        }
                        controller.update();
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Image.asset(
                                controller.isExecutePendingOrder == false ? AppImages.checkBoxSelectedRound : AppImages.checkBoxRound,
                                height: 20,
                                width: 20,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("No", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }

  Widget leverageDropDown() {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().grayLightLine,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3)),
      padding: const EdgeInsets.only(right: 15, left: 5),
      child: Obx(() {
        return Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              // alignment: AlignmentDirectional.center,

              iconStyleData: IconStyleData(
                  icon: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                  openMenuIcon: AnimatedRotation(
                    turns: 0.5,
                    duration: const Duration(milliseconds: 400),
                    child: Image.asset(
                      AppImages.arrowDown,
                      width: 20,
                      height: 20,
                      color: AppColors().fontColor,
                    ),
                  )),
              hint: Text(
                'Leverage',
                maxLines: 1,
                style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
              ),
              items: controller.arrLeverageList
                  .map((item) => DropdownMenuItem<String>(
                        value: item.name ?? "",
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
                return controller.arrLeverageList
                    .map((item) => DropdownMenuItem<String>(
                          value: item.name ?? "",
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
              value: controller.leverageSelectionValue.value.isNotEmpty ? controller.leverageSelectionValue.value : null,
              onChanged: (String? value) {
                controller.leverageSelectionValue.value = value.toString();
                controller.update();
              },
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: AppColors().grayBg,
                ),
                offset: const Offset(-20, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all(6),
                  thumbVisibility: MaterialStateProperty.all(true),
                ),
              ),
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                // height: 54,
              ),
              menuItemStyleData: MenuItemStyleData(height: 54, overlayColor: MaterialStateProperty.all(Colors.green)),
            ),
          ),
        );
      }),
    );
  }

  Widget multiGroupDropDown() {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().grayLightLine,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3)),
      padding: const EdgeInsets.only(right: 15, left: 5),
      child: Obx(() {
        return Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              // alignment: AlignmentDirectional.center,

              iconStyleData: IconStyleData(
                  icon: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                  openMenuIcon: AnimatedRotation(
                    turns: 0.5,
                    duration: const Duration(milliseconds: 400),
                    child: Image.asset(
                      AppImages.arrowDown,
                      width: 20,
                      height: 20,
                      color: AppColors().fontColor,
                    ),
                  )),
              hint: Text(
                'Multi group Selection',
                maxLines: 1,
                style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
              ),
              items: controller.arrMultiGroupSelection
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: Appfonts.family1Medium,
                            color: AppColors().DarkText,
                          ),
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return controller.arrMultiGroupSelection
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: Appfonts.family1Medium,
                              color: AppColors().DarkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: controller.multiGroupSelectionValue.value.isNotEmpty ? controller.multiGroupSelectionValue.value : null,
              onChanged: (String? value) {
                controller.multiGroupSelectionValue.value = value.toString();
                controller.update();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                // height: 54,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 54,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: AppColors().grayBg,
                ),
                offset: const Offset(-20, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all(6),
                  thumbVisibility: MaterialStateProperty.all(true),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget masterSelectedView() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.arrUserDetailsData1 == null)
            SizedBox(
              height: 2.h,
            ),
          if (controller.arrUserDetailsData1 == null)
            CustomTextField(
              type: 'P/L Sharing (%)',
              keyBoardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
              isEnabled: true,
              isOptional: false,
              inValidMsg: AppString.emptyServer,
              placeHolderMsg: "P/L Sharing (%)",
              labelMsg: "P/L Sharing (%)",
              emptyFieldMsg: AppString.emptyServer,
              controller: controller.profitController,
              focus: controller.profitFocus,
              isSecure: false,
              keyboardButtonType: TextInputAction.next,
              maxLength: controller.profitController.text.length > 1
                  ? controller.profitController.text.characters.first == "1"
                      ? 3
                      : 2
                  : 3,
              sufixIcon: null,
            ),
          if (controller.arrUserDetailsData1 == null)
            SizedBox(
              height: 1.h,
            ),
          if (controller.arrUserDetailsData1 == null)
            Row(
              children: [
                Text("Our: ", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                Text(
                    // "${controller.profitAndLossSharingDownLine - (num.tryParse(controller.profitController.text) ?? 0)}",
                    controller.profitController.text == "" ? controller.profitAndLossSharingDownLine.toString() : controller.profitController.text,
                    style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                SizedBox(
                  width: 1.h,
                ),
                Text("|", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                SizedBox(
                  width: 1.h,
                ),
                Text("Down Line: ", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                Text(
                    // "${(num.tryParse(controller.profitController.text) ?? 0)}",
                    controller.profitController.text == "" ? "0" : "${controller.profitAndLossSharingDownLine - (num.tryParse(controller.profitController.text) ?? 0)}",
                    style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                if (userData!.role != UserRollList.superAdmin)
                  SizedBox(
                    width: 1.h,
                  ),
                if (userData!.role != UserRollList.superAdmin) Text("|", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                if (userData!.role != UserRollList.superAdmin)
                  SizedBox(
                    width: 1.h,
                  ),
                if (userData!.role != UserRollList.superAdmin) Text("Up Line: ", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                if (userData!.role != UserRollList.superAdmin) Text(controller.profitAndLossSharingUpLine.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
              ],
            ),
          if (controller.arrUserDetailsData1 == null)
            SizedBox(
              height: 2.h,
            ),
          if (controller.arrUserDetailsData1 == null)
            CustomTextField(
              type: 'Brokrage Sharing (%)',
              keyBoardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
              isEnabled: true,
              isOptional: false,
              inValidMsg: AppString.emptyServer,
              placeHolderMsg: "Brokrage Sharing (%)",
              labelMsg: "Brokrage Sharing (%)",
              emptyFieldMsg: AppString.emptyServer,
              controller: controller.brkController,
              focus: controller.brkFocus,
              isSecure: false,
              keyboardButtonType: TextInputAction.done,
              maxLength: controller.brkController.text.length > 0
                  ? controller.brkController.text.characters.first == "1"
                      ? 3
                      : 2
                  : 3,
              sufixIcon: null,
            ),
          if (controller.arrUserDetailsData1 == null)
            SizedBox(
              height: 1.h,
            ),
          if (controller.arrUserDetailsData1 == null)
            Row(
              children: [
                Text("Our: ", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                Text(controller.brkController.text == "" ? controller.brkSharingDownLine.toString() : controller.brkController.text, style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                SizedBox(
                  width: 1.h,
                ),
                Text("|", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                SizedBox(
                  width: 1.h,
                ),
                Text("Down Line: ", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                Text(
                    // "${num.tryParse(controller.brkController.text) ?? 0}",
                    controller.brkController.text == "" ? "0" : "${controller.brkSharingDownLine - (num.tryParse(controller.brkController.text) ?? 0)}",
                    style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                SizedBox(
                  width: 1.h,
                ),
                if (userData!.role != UserRollList.superAdmin) Text("|", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                if (userData!.role != UserRollList.superAdmin)
                  SizedBox(
                    width: 1.h,
                  ),
                if (userData!.role != UserRollList.superAdmin) Text("Up Line: ", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                if (userData!.role != UserRollList.superAdmin) Text(controller.brkSharingUpLine.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
              ],
            ),
          if (controller.arrUserDetailsData1 == null)
            SizedBox(
              height: 2.h,
            ),
          Container(
            child: Text("Exchange Allow", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
          ),
          SizedBox(
            height: 1.h,
          ),
          MasterSelectedView(),
          // Container(
          //   // width: 100.w,
          //   height: 3.h,
          //   child: ListView.builder(
          //       physics: const ClampingScrollPhysics(),
          //       clipBehavior: Clip.hardEdge,
          //       itemCount: controller.arrExchangeList.length,
          //       controller: controller.listcontroller,
          //       scrollDirection: Axis.horizontal,
          //       shrinkWrap: true,
          //       itemBuilder: (context, index) {
          //         return masterExchangeView(context, index);
          //       }),
          // ),
        ],
      ),
    );
  }

  Widget clientBrokerageView() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          selectBrokerDropDownView(),
          if (controller.selectBrokerSelectionValue.value != "")
            SizedBox(
              height: 2.h,
            ),
          if (controller.selectBrokerSelectionValue.value != "")
            CustomTextField(
              type: 'Brokrage Sharing (%)',
              keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
              isEnabled: true,
              isOptional: false,
              inValidMsg: AppString.emptyServer,
              placeHolderMsg: "Brokrage Sharing (%)",
              labelMsg: "Brokrage Sharing (%)",
              emptyFieldMsg: AppString.emptyServer,
              controller: controller.brkController,
              focus: controller.brkFocus,
              isSecure: false,
              keyboardButtonType: TextInputAction.done,
              maxLength: 3,
              sufixIcon: null,
            ),
          if (controller.selectBrokerSelectionValue.value != "")
            SizedBox(
              height: 1.h,
            ),
          if (controller.selectBrokerSelectionValue.value != "")
            Row(
              children: [
                Text("Our: ", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                Text("${num.tryParse(controller.brkController.text) ?? 0}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                SizedBox(
                  width: 1.h,
                ),
                Text("|", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                SizedBox(
                  width: 1.h,
                ),
                Text("Down Line: ", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                Text("${100 - (num.tryParse(controller.brkController.text) ?? 0)}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                SizedBox(
                  width: 1.h,
                ),
                Text("Up Line: ", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                Text(
                    // "${(num.tryParse(controller.profitController.text) ?? 0)}",
                    controller.profitController.text == "" ? "0" : "${controller.profitAndLossSharingDownLine - (num.tryParse(controller.profitController.text) ?? 0)}",
                    style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
              ],
            ),
        ],
      ),
    );
  }

  Widget selectBrokerDropDownView() {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().grayLightLine,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3)),
      padding: const EdgeInsets.only(right: 15, left: 5),
      child: Obx(() {
        return Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              // alignment: AlignmentDirectional.center,
              iconStyleData: IconStyleData(
                  icon: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                  openMenuIcon: AnimatedRotation(
                    turns: 0.5,
                    duration: const Duration(milliseconds: 400),
                    child: Image.asset(
                      AppImages.arrowDown,
                      width: 20,
                      height: 20,
                      color: AppColors().fontColor,
                    ),
                  )),
              hint: Text(
                'Select Brocker',
                maxLines: 1,
                style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
              ),
              items: controller.arrBrokerList
                  .map((BrokerListModelData item) => DropdownMenuItem<String>(
                        value: item.name ?? "",
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
                return controller.arrBrokerList
                    .map((BrokerListModelData item) => DropdownMenuItem<String>(
                          value: item.name ?? "",
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
              value: controller.selectBrokerSelectionValue.value.isNotEmpty ? controller.selectBrokerSelectionValue.value : null,
              onChanged: (String? value) {
                controller.selectBrokerSelectionValue.value = value.toString();
                controller.update();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                // height: 54,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 54,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget masterExchangeView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        controller.arrExchangeList[index].isSelected = !controller.arrExchangeList[index].isSelected;
        controller.update();
      },
      child: Row(
        children: [
          Image.asset(
            controller.arrExchangeList[index].isSelected ? AppImages.checkBoxSelected : AppImages.checkBox,
            height: 25,
            width: 25,
          ),
          SizedBox(
            width: 1.h,
          ),
          Text(controller.arrExchangeList[index].name ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
          if (index != controller.arrExchangeList.length - 1)
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
            ),
        ],
      ),
    );
  }

  Widget highLowBetWeenTradeView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (controller.arrExchangeList[index].isSelected) {
          controller.arrExchangeList[index].isHighLowTradeSelected = !controller.arrExchangeList[index].isHighLowTradeSelected!;
          controller.update();
        }
      },
      child: Row(
        children: [
          Image.asset(
            controller.arrExchangeList[index].isHighLowTradeSelected! ? AppImages.checkBoxSelected : AppImages.checkBox,
            height: 25,
            width: 25,
          ),
          SizedBox(
            width: 1.h,
          ),
          Text(controller.arrExchangeList[index].name ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
        ],
      ),
    );
  }

  Widget clientSelectedView() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.5.h,
          ),
          Container(
            // height: 20.5.h,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(3)),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                    child: Row(
                      children: [
                        Container(
                          width: 25.w,
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: AppColors().grayLightLine,
                              width: 1.5,
                            ),
                            right: BorderSide(
                              color: AppColors().grayLightLine,
                              width: 1.5,
                            ),
                          )),
                          child: Center(
                            child: Text("Exchange", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                          ),
                        ),
                        Container(
                          width: 15.w,
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: AppColors().grayLightLine,
                              width: 1.5,
                            ),
                            right: BorderSide(
                              color: AppColors().grayLightLine,
                              width: 1.5,
                            ),
                          )),
                          child: Center(child: Text("Turnover\n(%)", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText))),
                        ),
                        Container(
                          width: 15.w,
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: AppColors().grayLightLine,
                              width: 1.5,
                            ),
                            right: BorderSide(
                              color: AppColors().grayLightLine,
                              width: 1.5,
                            ),
                          )),
                          child: Center(child: Text("Symbol\n(%)", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText))),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: AppColors().grayLightLine,
                                width: 1.5,
                              ),
                            )),
                            child: Center(child: Text("Group", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // height: 15.h,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        clipBehavior: Clip.hardEdge,
                        itemCount: controller.arrExchangeList.length,
                        controller: controller.listcontroller,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return exchangeListCallClient(context, index);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget exchangeListCallClient(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (controller.arrExchangeList[index].isSelected) {
                      controller.arrExchangeList[index].isHighLowTradeSelected = false;
                    }
                    if (controller.arrExchangeList[index].arrGroupList.isNotEmpty) {
                      controller.arrExchangeList[index].isSelected = !controller.arrExchangeList[index].isSelected;
                      if (controller.arrExchangeList[index].isSelected == false) {
                        controller.arrExchangeList[index].isSymbolSelected = false;
                        controller.arrExchangeList[index].isTurnOverSelected = false;
                      } else {
                        if (controller.arrExchangeList[index].brokarageType == "symbolwise") {
                          controller.arrExchangeList[index].isSymbolSelected = true;
                          controller.arrExchangeList[index].isTurnOverSelected = false;
                        } else {
                          controller.arrExchangeList[index].isSymbolSelected = false;
                          controller.arrExchangeList[index].isTurnOverSelected = true;
                        }
                      }
                      //Condition
                      if (controller.arrExchangeList[index].isSelected == false) {
                        if (controller.isSelectedallExchangeinMaster.value == true) {
                          controller.isSelectedallExchangeinMaster.value = false;
                        }
                      }
                      if (controller.arrExchangeList.every((exchange) => exchange.isSelected)) {
                        controller.isSelectedallExchangeinMaster.value = true;
                      }

                      if (controller.arrExchangeList[index].isSelected == false) {
                        controller.arrExchangeList[index].selectedItems.clear();
                        controller.arrExchangeList[index].isDropDownValueSelected.value = controller.arrExchangeList[index].arrGroupList.first.groupId!;
                        controller.arrExchangeList[index].isDropDownValueSelected.value = "";
                      }

                      controller.update();
                    }
                    // if (controller.arrExchangeList[index].arrGroupList.isNotEmpty) {
                    //   if (controller.arrExchangeList[index].isSelected) {
                    //     controller.arrExchangeList[index].isHighLowTradeSelected = false;
                    //   }
                    //   controller.arrExchangeList[index].isSelected = !controller.arrExchangeList[index].isSelected;
                    //   //Condition
                    //   if (controller.arrExchangeList[index].isSelected == false) {
                    //     if (controller.isSelectedallExchangeinMaster.value == true) {
                    //       controller.isSelectedallExchangeinMaster.value = false;
                    //     }
                    //   }
                    //   if (controller.arrExchangeList.every((exchange) => exchange.isSelected)) {
                    //     controller.isSelectedallExchangeinMaster.value = true;
                    //   }

                    //   if (controller.arrExchangeList[index].isSelected == false) {
                    //     controller.arrExchangeList[index].selectedItems.clear();
                    //     controller.arrExchangeList[index].isDropDownValueSelected.value = "";
                    //   }

                    //   controller.update();
                    // }
                  },
                  child: Container(
                    width: 21.w,
                    child: Row(
                      children: [
                        Image.asset(
                          controller.arrExchangeList[index].isSelected ? AppImages.checkBoxSelected : AppImages.checkBox,
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(controller.arrExchangeList[index].name ?? "", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.arrExchangeList[index].brokarageType == "turnoverwise" || controller.arrExchangeList[index].brokarageType == "both") {
                      if (controller.arrExchangeList[index].isSymbolSelected == true) {
                        controller.arrExchangeList[index].isSymbolSelected = false;
                      }
                      controller.arrExchangeList[index].isTurnOverSelected = true;
                      //!controller.arrExchangeList[index].isTurnOverSelected!;
                      controller.update();
                    }
                  },
                  child: Image.asset(
                    controller.arrExchangeList[index].isTurnOverSelected! ? AppImages.checkBoxSelected : AppImages.checkBox,
                    height: 20,
                    width: 20,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.arrExchangeList[index].brokarageType == "symbolwise" || controller.arrExchangeList[index].brokarageType == "both") {
                      if (controller.arrExchangeList[index].isTurnOverSelected == true) {
                        controller.arrExchangeList[index].isTurnOverSelected = false;
                      }
                      controller.arrExchangeList[index].isSymbolSelected = true;
                      //!controller.arrExchangeList[index].isSymbolSelected!;
                      controller.update();
                    }
                  },
                  child: Image.asset(
                    controller.arrExchangeList[index].isSymbolSelected! ? AppImages.checkBoxSelected : AppImages.checkBox,
                    height: 20,
                    width: 20,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                dropDownClient(controller.arrExchangeList[index].isDropDownValueSelected, controller.arrExchangeList[index].arrGroupList.toSet().toList()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDownClient(RxString values, List<groupListModelData> arr) {
    return Container(
      height: 3.h,
      width: 33.w,
      child: Container(
        color: AppColors().grayLightLine,
        padding: EdgeInsets.only(right: 1.w),
        child: Obx(() {
          return Center(
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                iconStyleData: IconStyleData(
                    icon: Image.asset(
                      AppImages.arrowDown,
                      height: 15,
                      width: 15,
                      color: AppColors().fontColor,
                    ),
                    openMenuIcon: AnimatedRotation(
                      turns: 0.5,
                      duration: const Duration(milliseconds: 400),
                      child: Image.asset(
                        AppImages.arrowDown,
                        width: 15,
                        height: 15,
                        color: AppColors().fontColor,
                      ),
                    )),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    color: AppColors().grayBg,
                  ),
                  offset: const Offset(-20, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all(6),
                    thumbVisibility: MaterialStateProperty.all(true),
                  ),
                ),
                hint: Text(
                  'Select Group',
                  maxLines: 1,
                  style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
                ),
                items: arr
                    .map((groupListModelData item) => DropdownMenuItem<String>(
                          value: item.name ?? "",
                          child: Text(
                            item.name ?? "",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: Appfonts.family1Medium,
                              color: AppColors().DarkText,
                            ),
                          ),
                        ))
                    .toList(),
                selectedItemBuilder: (context) {
                  return arr
                      .map((groupListModelData item) => DropdownMenuItem<String>(
                            value: item.name ?? "",
                            child: Text(
                              item.name ?? "",
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: Appfonts.family1Medium,
                                color: AppColors().DarkText,
                              ),
                            ),
                          ))
                      .toList();
                },
                value: values.value.isNotEmpty ? values.value : null,
                onChanged: (String? value) {
                  values.value = value.toString();
                  controller.update();
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  // height: 54,
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: 30,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget MasterSelectedView() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.5.h,
          ),
          Container(
            // height: 25.5.h,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().grayLightLine,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(3)),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                  child: Row(
                    children: [
                      Container(
                        width: 11.w,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: AppColors().grayLightLine,
                            width: 1.5,
                          ),
                          right: BorderSide(
                            color: AppColors().grayLightLine,
                            width: 1.5,
                          ),
                        )),
                        child: GestureDetector(
                          onTap: () async {
                            controller.isSelectedallExchangeinMaster.value = !controller.isSelectedallExchangeinMaster.value;
                            for (var indexs = 0; indexs < controller.arrExchangeList.length; indexs++) {
                              controller.arrExchangeList[indexs].isSelected = controller.isSelectedallExchangeinMaster.value;
                              if (controller.arrExchangeList[indexs].isSelected == false) {
                                controller.arrExchangeList[indexs].selectedItems.clear();
                                controller.arrExchangeList[indexs].isDropDownValueSelected.value = "";
                              }

                              if (controller.arrExchangeList[indexs].arrGroupList.isNotEmpty) {
                                controller.arrExchangeList[indexs].isSelected = true;
                              } else {
                                controller.arrExchangeList[indexs].isSelected = false;
                              }

                              if (controller.isSelectedallExchangeinMaster.value == false) {
                                controller.arrExchangeList[indexs].isHighLowTradeSelected = false;
                                controller.arrExchangeList[indexs].isSelected = false;
                                controller.update();
                              }
                            }
                            controller.update();
                          },
                          child: Center(
                            child: Image.asset(
                              controller.isSelectedallExchangeinMaster.value ? AppImages.checkBoxSelected : AppImages.checkBox,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.h),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: AppColors().grayLightLine,
                            width: 1.5,
                          ),
                          right: BorderSide(
                            color: AppColors().grayLightLine,
                            width: 1.5,
                          ),
                        )),
                        child: Center(child: Text("Exchange", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText))),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 9.7.h),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: AppColors().grayLightLine,
                            width: 1.5,
                          ),
                        )),
                        child: Center(child: Text("Group", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText))),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      clipBehavior: Clip.hardEdge,
                      itemCount: controller.arrExchangeList.length,
                      controller: controller.listcontroller,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return exchangeListCallMaster(context, index);
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget exchangeListCallMaster(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.h),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (controller.arrExchangeList[index].arrGroupList.isNotEmpty) {
                      if (controller.arrExchangeList[index].isSelected) {
                        controller.arrExchangeList[index].isHighLowTradeSelected = false;
                      }
                      controller.arrExchangeList[index].isSelected = !controller.arrExchangeList[index].isSelected;
                      //Condition
                      if (controller.arrExchangeList[index].isSelected == false) {
                        if (controller.isSelectedallExchangeinMaster.value == true) {
                          controller.isSelectedallExchangeinMaster.value = false;
                        }
                      }
                      if (controller.arrExchangeList.every((exchange) => exchange.isSelected)) {
                        controller.isSelectedallExchangeinMaster.value = true;
                      }

                      if (controller.arrExchangeList[index].isSelected == false) {
                        controller.arrExchangeList[index].selectedItems.clear();
                        controller.arrExchangeList[index].isDropDownValueSelected.value = "";
                      }
                      // }
                      controller.update();
                    }
                  },
                  child: Container(
                    width: 12.w,
                    child: Row(
                      children: [
                        Image.asset(
                          controller.arrExchangeList[index].isSelected ? AppImages.checkBoxSelected : AppImages.checkBox,
                          height: 20,
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                  // width: 12.w,
                  child: Text(controller.arrExchangeList[index].name ?? "",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: Appfonts.family1Medium,
                        color: AppColors().DarkText,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                // SizedBox(
                //   width: 18.w,
                // ),
                Spacer(),
                dropDownMasterMultiSelection(controller.arrExchangeList[index].selectedItems, controller.arrExchangeList[index].arrGroupList),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDownMasterMultiSelection(List<String> values, List<groupListModelData> arr) {
    return Container(
      height: 3.h,
      width: 48.w,
      child: Container(
        color: AppColors().grayLightLine,
        padding: EdgeInsets.only(right: 1.w),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: AppColors().grayBg,
                ),
                offset: const Offset(-20, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all(6),
                  thumbVisibility: MaterialStateProperty.all(true),
                ),
              ),
              iconStyleData: IconStyleData(
                  icon: Image.asset(
                    AppImages.arrowDown,
                    height: 15,
                    width: 15,
                    color: AppColors().fontColor,
                  ),
                  openMenuIcon: AnimatedRotation(
                    turns: 0.5,
                    duration: const Duration(milliseconds: 400),
                    child: Image.asset(
                      AppImages.arrowDown,
                      width: 15,
                      height: 15,
                      color: AppColors().fontColor,
                    ),
                  )),
              hint: Text(
                'Select Group',
                maxLines: 1,
                style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
              ),
              items: arr.map((item) {
                return DropdownMenuItem<String>(
                  value: item.name ?? "",
                  //disable default onTap to avoid closing menu when selecting an item
                  enabled: false,
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      final isSelected = values.contains(item.name ?? "");
                      return InkWell(
                        onTap: () {
                          isSelected ? values.remove(item.name ?? "") : values.add(item.name ?? "");
                          //This rebuilds the StatefulWidget to update the button's text
                          controller.update();
                          //This rebuilds the dropdownMenu Widget to update the check mark
                          menuSetState(() {});
                        },
                        child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              // if (isSelected) const Icon(Icons.check_box_outlined) else const Icon(Icons.check_box_outline_blank),
                              // const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  item.name ?? "",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: Appfonts.family1Medium,
                                    color: isSelected ? AppColors().blueColor : AppColors().DarkText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
              value: values.isEmpty ? null : values.last,
              onChanged: (value) {},
              selectedItemBuilder: (context) {
                return arr.map(
                  (item) {
                    return Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        values.join(', '),
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: Appfonts.family1Medium,
                          color: AppColors().DarkText,
                        ),
                        maxLines: 1,
                      ),
                    );
                  },
                ).toList();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(left: 16, right: 0),
                height: 40,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
