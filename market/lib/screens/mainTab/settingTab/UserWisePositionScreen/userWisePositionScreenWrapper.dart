import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/UserWisePositionScreen/userWisePositionScreenController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constant/color.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/commonFunction.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../../modelClass/userRoleListModelClass.dart';
import '../../tabScreen/MainTabController.dart';

class UserWiseScreen extends BaseView<UserWiseScreenController> {
  const UserWiseScreen({Key? key}) : super(key: key);

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
            child: Image.asset(
              AppImages.filterIcon,
              width: 25,
              height: 25,
              color: AppColors().blueColor,
            ),
          ),
          onTrailingButtonPress: () {
            filterPopupDialog();
          },
          headerTitle: "User Wise Netposition",
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
        child: SafeArea(
          child: Column(
            children: [
              // dropDownView(),
              // selectUserdropDownView(),
              // btnView(),
              searchView(),
              totalLabelView(),
              // searchboxView(),
              Expanded(
                child: controller.isLoadingData
                    ? Container(
                        width: 30.w,
                        height: 30.h,
                        child: displayIndicator(),
                      )
                    : controller.arrUserWiseNPList.isNotEmpty
                        ? ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            itemCount: controller.arrUserWiseNPList.length,
                            controller: controller.listcontroller,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return userListView(context, index);
                            })
                        : Container(
                            child: Center(
                            child: Text(
                              "Data not found".tr,
                              style: TextStyle(fontSize: 15, fontFamily: Appfonts.family1Regular, color: AppColors().fontColor),
                            ),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  filterPopupDialog({String? message, String? subMessage, Function? CancelClick, Function? DeleteClick}) {
    showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
            titlePadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
                Container(
                  decoration: BoxDecoration(color: AppColors().bgColor, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      dropDownView(),
                      selectUserdropDownView(),
                      SizedBox(
                        height: 3.w,
                      ),
                      btnView(),
                    ],
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
              ],
            )));
  }

  Widget dropDownView() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      child: Column(
        children: [
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
                    iconStyleData: IconStyleData(
                      icon: Image.asset(
                        AppImages.arrowDown,
                        height: 25,
                        width: 25,
                        color: AppColors().fontColor,
                      ),
                    ),
                    hint: Text(
                      'Exchange',
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
                      controller.selectScriptdropdownValue.value = GlobalSymbolData();
                      controller.arrScriptDropdown.clear();
                      controller.update();
                      controller.getScriptList();
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
          Container(
            margin: const EdgeInsets.only(top: 15),
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
              var dropdownButton2 = DropdownButton2<GlobalSymbolData>(
                isExpanded: true,
                iconStyleData: IconStyleData(
                  icon: Image.asset(
                    AppImages.arrowDown,
                    height: 25,
                    width: 25,
                    color: AppColors().fontColor,
                  ),
                ),
                hint: Text(
                  'Select Script',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: Appfonts.family1Medium,
                    color: AppColors().DarkText,
                  ),
                ),
                items: controller.arrScriptDropdown
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
                  return controller.arrScriptDropdown
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
                value: controller.selectScriptdropdownValue.value.symbolName != null ? controller.selectScriptdropdownValue.value : null,
                onChanged: (GlobalSymbolData? value) {
                  // setState(() {
                  controller.selectScriptdropdownValue.value = value!;
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
              );
              return Center(
                child: DropdownButtonHideUnderline(
                  child: dropdownButton2,
                ),
              );
            }),
          ),
          SizedBox(
            height: 20,
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
                  child: DropdownButton2<userRoleListData>(
                    isExpanded: true,
                    iconStyleData: IconStyleData(
                      icon: Image.asset(
                        AppImages.arrowDown,
                        height: 25,
                        width: 25,
                        color: AppColors().fontColor,
                      ),
                    ),
                    hint: Text(
                      'Roll Type',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: Appfonts.family1Medium,
                        color: AppColors().DarkText,
                      ),
                    ),
                    items: arrUserRoleList
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
                    value: controller.selectedRoll.value.roleId != null ? controller.selectedRoll.value : null,
                    onChanged: (userRoleListData? value) {
                      // setState(() {
                      controller.selectedRoll.value = value!;
                      controller.selectUserdropdownValue.value = UserData();
                      controller.arrUserDataDropDown.clear();
                      controller.update();
                      controller.getUserList();
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
        ],
      ),
    );
  }

  Widget selectUserdropDownView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().grayLightLine,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3)),
      padding: const EdgeInsets.only(right: 15),
      child: Obx(() {
        return Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<UserData>(
              isExpanded: true,
              dropdownStyleData: DropdownStyleData(
                maxHeight: 300,
                decoration: BoxDecoration(
                  color: AppColors().grayBg,
                ),
              ),
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
                'Select User',
                maxLines: 1,
                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
              ),
              items: controller.arrUserDataDropDown
                  .map((UserData item) => DropdownMenuItem<UserData>(
                        value: item,
                        child: Text(
                          item.userName ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: Appfonts.family1Medium,
                            color: AppColors().DarkText,
                          ),
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return controller.arrUserDataDropDown
                    .map((UserData item) => DropdownMenuItem<String>(
                          value: item.userName ?? "",
                          child: Text(
                            item.userName ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: Appfonts.family1Medium,
                              color: AppColors().DarkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: controller.selectUserdropdownValue.value.userId != null ? controller.selectUserdropdownValue.value : null,
              onChanged: (UserData? value) {
                controller.selectUserdropdownValue.value = value!;
                controller.update();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 54,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 54,
              ),

              dropdownSearchData: DropdownSearchData(
                searchController: controller.searchUsertextEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 60,
                  padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
                  child: CustomTextField(
                    type: 'Remark',
                    keyBoardType: TextInputType.text,
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: "",
                    placeHolderMsg: "Search User",
                    emptyFieldMsg: "",
                    controller: controller.searchUsertextEditingController,
                    focus: controller.searchUsertextEditingFocus,
                    isSecure: false,
                    borderColor: AppColors().grayLightLine,
                    keyboardButtonType: TextInputAction.next,
                    maxLength: 64,
                    prefixIcon: Image.asset(
                      AppImages.searchIcon,
                      height: 24,
                      width: 24,
                    ),
                    sufixIcon: Container(
                      child: GestureDetector(
                        onTap: () {
                          controller.searchUsertextEditingController.clear();
                        },
                        child: Image.asset(
                          AppImages.crossIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value!.userName!.toString().toLowerCase().contains(searchValue.toLowerCase());
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  controller.searchUsertextEditingController.clear();
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Widget btnView() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Search",
              textSize: 16,
              onPress: () {
                Get.back();
                controller.getUserWiseNetpositionList();
                controller.update();
              },
              bgColor: AppColors().blueColor,
              isFilled: true,
              textColor: AppColors().whiteColor,
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
              title: "Reset",
              textSize: 16,
              onPress: () {
                Get.back();
                controller.selectExchangedropdownValue.value = ExchangeData();
                controller.selectScriptdropdownValue.value = GlobalSymbolData();
                controller.selectUserdropdownValue.value = UserData();

                controller.getUserWiseNetpositionList();
                controller.update();
              },
              bgColor: AppColors().grayLightLine,
              isFilled: true,
              textColor: AppColors().DarkText,
              isTextCenter: true,
              isLoading: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget totalLabelView() {
    return Container(
      width: 100.w,
      height: 6.5.h,
      margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.h),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().grayLightLine,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3)),
      child: Row(
        children: [
          SizedBox(width: 2.5.w),
          Text("Total", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
          const Spacer(),
          Text("${controller.totalPosition.value.toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: Appfonts.family1Medium,
                  color: controller.totalPosition.value > 0
                      ? AppColors().blueColor
                      : controller.totalPosition.value < 0
                          ? AppColors().redColor
                          : AppColors().fontColor)),
          SizedBox(
            width: 2.5.w,
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
              // margin: const EdgeInsets.symmetric(vertical: 10),
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
                      controller: controller.searchListingTextEditingController,
                      focusNode: controller.searchListingtextEditingFocus,
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
                      // onEditingComplete: () {
                      //   FocusManager.instance.primaryFocus?.unfocus();
                      //   controller.currentPage = 1;
                      //   controller.userWiseBrkList(isFromFilter: true);
                      // },
                      // onChanged: (value) {
                      //   controller.currentPage = 1;
                      //   controller.userWiseBrkList(isFromFilter: true);
                      // },
                      onSubmitted: (value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.getUserWiseNetpositionList();
                      },
                      style: TextStyle(fontSize: 16.0, color: AppColors().fontColor, fontFamily: Appfonts.family1Medium),
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.w), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                          hintStyle: TextStyle(color: AppColors().placeholderColor),
                          hintText: "Search"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userListView(BuildContext, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${controller.arrUserWiseNPList[index].userName} (${controller.arrUserWiseNPList[index].naOfUser})", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(controller.arrUserWiseNPList[index].symbolName ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(color: controller.arrUserWiseNPList[index].tradeType == "buy" ? AppColors().blueColor.withOpacity(0.1) : AppColors().redColor.withOpacity(0.1), borderRadius: BorderRadius.circular(2)),
                  child: Text(controller.arrUserWiseNPList[index].tradeType!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: Appfonts.family1SemiBold,
                        color: controller.arrUserWiseNPList[index].tradeType == "buy" ? AppColors().blueColor : AppColors().redColor,
                      )),
                ),
                const Spacer(),
                Text(controller.arrUserWiseNPList[index].profitLossValue.toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: Appfonts.family1Medium,
                        color: controller.getPriceColor(
                          controller.arrUserWiseNPList[index].profitLossValue,
                        ))),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(controller.arrUserWiseNPList[index].tradeType == "buy" ? '${controller.arrUserWiseNPList[index].buyTotalQuantity}' : '${controller.arrUserWiseNPList[index].sellTotalQuantity}', style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                Text("-> ", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                Text('${controller.arrUserWiseNPList[index].price.toStringAsFixed(2)}', style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().blueColor)),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              width: 100.w,
              color: AppColors().grayLightLine,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
