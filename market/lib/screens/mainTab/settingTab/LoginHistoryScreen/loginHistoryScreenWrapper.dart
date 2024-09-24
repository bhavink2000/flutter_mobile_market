import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/modelClass/myUserListModelClass.dart';
import 'package:market/screens/mainTab/settingTab/LoginHistoryScreen/loginHistoryScreenController.dart';
import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constant/color.dart';

import '../../../../constant/assets.dart';
import '../../../../constant/font_family.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../../customWidgets/appTextField.dart';
import '../../../BaseViewController/baseController.dart';
import '../../tabScreen/MainTabController.dart';

class SettingLoginHistoryScreen extends BaseView<SettingLoginHistoryController> {
  const SettingLoginHistoryScreen({Key? key}) : super(key: key);

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
          headerTitle: "Login History",
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
              //dropDownView(),
              // if (controller.selectStatusdropdownValue == "Custom Period")
              //   btnField(),
              // selectUserdropDownView(),
              // searchboxView(),
              Expanded(
                child: controller.isApiCallRunning
                    ? displayIndicator()
                    : controller.isApiCallRunning == false && controller.arrUserLoginHistoryData.isEmpty
                        ? dataNotFoundView("Data not found")
                        : PaginableListView.builder(
                            loadMore: () async {
                              if (controller.totalPage >= controller.currentPage) {
                                print(controller.currentPage);
                                controller.getUserListData();
                              }
                            },
                            errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                            progressIndicatorWidget: displayIndicator(),
                            physics: const AlwaysScrollableScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            itemCount: controller.arrUserLoginHistoryData.length,
                            controller: controller.listcontroller,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return userListView(context, index);
                            }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
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
            child: DropdownButton2<String>(
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
                'Please Select week of Period',
                maxLines: 1,
                style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
              ),
              items: controller.arrCustomDateSelection
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
                return controller.arrCustomDateSelection
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
              value: controller.selectStatusdropdownValue.value.isNotEmpty ? controller.selectStatusdropdownValue.value : null,
              onChanged: (String? value) {
                // value.toString() == "Custom Period" ?
                //  _selectFromDate(Get.context!)
                // :
                controller.selectStatusdropdownValue.value = value.toString();
                controller.update();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 54,
                // width: 140,
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

  Widget btnField() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.only(bottom: 5.w, right: 5.w, left: 5.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors().grayLightLine,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(3)),
              child: CustomButton(
                isEnabled: true,
                shimmerColor: AppColors().whiteColor,
                title: controller.fromDate == null ? "From Date" : controller.fromDate.toString(),
                textSize: 14,
                onPress: () {
                  _selectFromDate(Get.context!);
                },
                bgColor: Colors.transparent,
                isFilled: true,
                textColor: AppColors().DarkText,
                isTextCenter: true,
                isLoading: false,
              ),
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            // flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors().grayLightLine,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(3)),
              child: CustomButton(
                isEnabled: true,
                shimmerColor: AppColors().whiteColor,
                title: controller.toDate == null ? "To Date" : controller.toDate.toString(),
                textSize: 14,
                onPress: () {
                  _selectToDate(Get.context!);
                },
                bgColor: Colors.transparent,
                isFilled: true,
                textColor: AppColors().DarkText,
                isTextCenter: true,
                isLoading: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectUserdropDownView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
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
            child: DropdownButton2<String>(
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
              value: controller.selectUserDropdownValue.value.isNotEmpty ? controller.selectUserDropdownValue.value : null,
              onChanged: (String? value) {
                controller.selectUserDropdownValue.value = value.toString();
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
                searchController: controller.textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 60,
                  padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
                  // padding: const EdgeInsets.only(
                  //   top: 8,
                  //   bottom: 4,
                  //   right: 8,
                  //   left: 8,
                  // ),
                  child: CustomTextField(
                    type: '',
                    keyBoardType: TextInputType.text,
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: "",
                    placeHolderMsg: "Search User",
                    emptyFieldMsg: "",
                    controller: controller.textEditingController,
                    focus: controller.textEditingFocus,
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
                          controller.textEditingController.clear();
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
                  return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  controller.textEditingController.clear();
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Widget searchboxView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 90.w,
          height: 6.h,
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors().fontColor.withOpacity(0.05),
                  offset: Offset.zero,
                  spreadRadius: 2,
                  blurRadius: 7,
                ),
              ],
              borderRadius: BorderRadius.circular(3),
              color: AppColors().bgColor),
          child: Row(
            children: [
              SizedBox(
                width: 2.5.w,
              ),
              Image.asset(
                AppImages.searchIcon,
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 70.w,
                child: TextField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  textCapitalization: TextCapitalization.sentences,
                  controller: controller.searchtextEditingController,
                  focusNode: controller.searchtextEditingFocus,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 1,
                  onChanged: (value) {
                    controller.arrUserLoginHistoryData.clear();
                    controller.arrUserLoginHistoryData.addAll(controller.arrMainScript);
                    controller.arrUserLoginHistoryData.retainWhere((scriptObj) {
                      return scriptObj.name!.toLowerCase().contains(value.toLowerCase());
                    });
                    controller.update();
                  },
                  style: TextStyle(fontSize: 14.0, color: AppColors().fontColor, fontFamily: Appfonts.family1Medium),
                  decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.w), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      hintStyle: TextStyle(color: AppColors().placeholderColor),
                      hintText: "Search exchange or script"),
                ),
              ),
            ],
          ),
        ),
      ],
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
            Row(
              children: [
                Image.asset(
                  AppImages.userImage,
                  width: 10,
                  height: 10,
                  color: AppColors().lightText,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(controller.arrUserLoginHistoryData[index].name ?? "", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                Spacer(),
                Text("IP:${controller.arrUserLoginHistoryData[index].ip ?? ""}", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                    controller.arrUserLoginHistoryData[index].loginDate != "" && controller.arrUserLoginHistoryData[index].loginDate != null
                        ? "Login Time : " + shortFullDateTime(controller.arrUserLoginHistoryData[index].loginDate!)
                        : "Logout Time : " + shortFullDateTime(controller.arrUserLoginHistoryData[index].logoutDate!),
                    style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                Spacer(),
                Text(controller.arrUserLoginHistoryData[index].city ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Regular, color: AppColors().blueColor)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Id :", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                Text(controller.arrUserLoginHistoryData[index].userId ?? "", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              width: 100.w,
              color: AppColors().grayLightLine,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: 'Select From Date',
      cancelText: 'Cancel',
      confirmText: 'Select To Date',
      // locale: Locale('en', 'US'),
    );

    if (picked != null) {
      // Format the DateTime to display only the date portion
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      print(formattedDate);
      controller.fromDate = formattedDate;
      controller.update();
      _selectToDate(context);
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: 'Select To Date',
      cancelText: 'Cancel',
      confirmText: 'OK',
    );
    if (picked != null) {
      // Format the DateTime to display only the date portion
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      print(formattedDate);
      controller.toDate = formattedDate;
      controller.update();
    }
  }
}
