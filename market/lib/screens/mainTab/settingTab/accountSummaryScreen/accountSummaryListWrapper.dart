import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/main.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/accountSummaryScreen/accountSummaryListController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constant/color.dart';
import '../../../../modelClass/myUserListModelClass.dart';

class AccountSummaryListScreen extends BaseView<AccountSummaryListController> {
  const AccountSummaryListScreen({Key? key}) : super(key: key);

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
          headerTitle: "Account Report",
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
            summaryDetailsTopView(),
            summaryListView(),
          ],
        ),
      ),
    );
  }

  Widget summaryDetailsTopView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      width: 100.w,
      // height: controller.selectStatusdropdownValue == "Custom Period" ? 40.5.h : 32.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors().bgColor,
      ),
      child: Column(
        children: [
          weekSelectiondropDownView(),
          if (controller.selectStatusdropdownValue == "Custom Period") toAndFromDateBtnView(),
          if (userData!.role != UserRollList.user) selectUserdropDownView(),
          checkBoxView(),
          viewAndClearBtnView(),
        ],
      ),
    );
  }

  Widget weekSelectiondropDownView() {
    return Container(
      height: 6.5.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
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
                'Please Select Week of Period',
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
                controller.selectStatusdropdownValue.value = value.toString();
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

  Widget toAndFromDateBtnView() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.only(bottom: 2.h, right: 5.w, left: 5.w),
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
                title: controller.fromDate == "" ? "From Date" : controller.fromDate.toString(),
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
                title: controller.toDate == "" ? "To Date" : controller.toDate.toString(),
                textSize: 14,
                onPress: () {
                  // _selectToDate(Get.context!);
                  _selectToDate(Get.context!, DateTime.parse(controller.fromDate!));
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
      height: 6.5.h,
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
            child: DropdownButton2<UserData>(
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
              value: controller.selectUserDropdownValue.value.userId != null ? controller.selectUserDropdownValue.value : null,
              onChanged: (UserData? value) {
                controller.selectUserDropdownValue.value = value!;
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
                maxHeight: 300,
                decoration: BoxDecoration(
                  color: AppColors().grayBg,
                ),
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: controller.textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 60,
                  padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
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
                    keyboardButtonType: TextInputAction.done,
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
                  return item.value!.userName.toString().toLowerCase().contains(searchValue.toLowerCase());
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

  Widget checkBoxView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (controller.SGX == true) {
                controller.SGX = false;
              }
              controller.NSE = true; // Set NSE to true
              controller.MCX = false; // Deselect MCX by setting it to false
              controller.update();
            },
            child: Row(
              children: [
                Image.asset(
                  controller.NSE ? AppImages.checkBoxSelected : AppImages.checkBox,
                  height: 25,
                  width: 25,
                ),
                SizedBox(
                  width: 1.h,
                ),
                Text("Profit & Loss", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (controller.SGX == true) {
                controller.SGX = false;
              }
              controller.MCX = true; // Set MCX to true
              controller.NSE = false; // Deselect NSE by setting it to false
              controller.update();
              controller.update();
            },
            child: Row(
              children: [
                Image.asset(
                  controller.MCX ? AppImages.checkBoxSelected : AppImages.checkBox,
                  height: 25,
                  width: 25,
                ),
                SizedBox(
                  width: 1.h,
                ),
                Text("Brokerage", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (controller.NSE == true || controller.MCX == true) {
                controller.NSE = false;
                controller.MCX = false;
              }
              controller.SGX = !controller.SGX;
              controller.update();
            },
            child: Row(
              children: [
                Image.asset(
                  controller.SGX ? AppImages.checkBoxSelected : AppImages.checkBox,
                  height: 25,
                  width: 25,
                ),
                SizedBox(
                  width: 1.h,
                ),
                Text("Credit", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget viewAndClearBtnView() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "View",
              textSize: 16,
              onPress: () {
                controller.getAccountSummaryList(isFromFresh: true);
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
              title: "Clear",
              textSize: 16,
              onPress: () {
                controller.selectUserDropdownValue.value = UserData();
                controller.selectStatusdropdownValue.value = "";
                controller.fromDate = "";
                controller.toDate = "";
                controller.NSE = false;
                controller.MCX = false;
                controller.SGX = false;

                controller.getAccountSummaryList(isFromFresh: true);
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

  Widget summaryListView() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 2.h),
        child: Stack(
          children: [
            Container(
              width: 100.w,
              margin: EdgeInsets.only(top: 2.5.h),
              padding: EdgeInsets.only(top: 5.h),
              decoration: BoxDecoration(color: AppColors().bgColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(
                children: [
                  //openingBalanceView(),
                  Expanded(
                      child: controller.isLoadingData == true
                          ? Container(
                              width: 30.w,
                              height: 30.h,
                              child: displayIndicator(),
                            )
                          : controller.isLoadingData == false && controller.arrAccountSummaryListData.isEmpty
                              ? dataNotFoundView("Data not found")
                              : PaginableListView.builder(
                                  loadMore: () async {
                                    if (controller.totalPage >= controller.currentPage) {
                                      print(controller.currentPage);
                                      controller.getAccountSummaryList();
                                    }
                                  },
                                  errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                                  progressIndicatorWidget: displayIndicator(),
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  clipBehavior: Clip.hardEdge,
                                  itemCount: controller.arrAccountSummaryListData.length,
                                  controller: controller.listcontroller,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return userListView(context, index);
                                  })),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90.w,
                  height: 6.h,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors().footerColor, boxShadow: [
                    BoxShadow(
                      color: AppColors().fontColor.withOpacity(0.05),
                      offset: Offset.zero,
                      spreadRadius: 2,
                      blurRadius: 7,
                    ),
                  ]),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5.w,
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
                            // FocusScope.of(context).unfocus();
                          },
                          textCapitalization: TextCapitalization.sentences,
                          controller: controller.searchTextEditingController,
                          focusNode: controller.searchTextEditingFocus,
                          keyboardType: TextInputType.text,
                          minLines: 1,
                          maxLines: 1,
                          textInputAction: TextInputAction.search,
                          onEditingComplete: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.getAccountSummaryList();
                          },
                          style: TextStyle(fontSize: 16.0, color: AppColors().fontColor, fontFamily: Appfonts.family1Medium),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget openingBalanceView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      // width: 90.w,
      child: Column(
        children: [
          Row(
            children: [
              Text("Opening Balance", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
              const Spacer(),
              Text("0.0", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().redColor)),
            ],
          ),
          SizedBox(height: 1.h),
          Container(
            height: 1,
            width: 100.w,
            color: AppColors().grayLightLine,
          )
        ],
      ),
    );
  }

  Widget userListView(BuildContext, int index) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(RouterName.UserListDetailsScreen, arguments: {"userId": controller.arrAccountSummaryListData[index].userId});
        // controller.update();
        controller.selectedIndex = index;
        controller.tradeID = controller.arrAccountSummaryListData[index].tradeId!;
        controller.getTradeDetail();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                Image.asset(
                  AppImages.userImage,
                  width: 10,
                  height: 10,
                  color: AppColors().lightText,
                ),
                const SizedBox(width: 5),
                Center(
                  child: Text("${controller.arrAccountSummaryListData[index].userName} (${controller.arrAccountSummaryListData[index].naOfUser})", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                ),
                const Spacer(),
                Center(
                  child: Image.asset(
                    AppImages.clockImage,
                    width: 10,
                    height: 10,
                    color: AppColors().lightText,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Center(
                  child: Text(shortFullDateTime(DateTime.parse(controller.arrAccountSummaryListData[index].createdAt!.toString())), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                //if (controller.SGX == false)
                Text(controller.arrAccountSummaryListData[index].symbolName ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                //if (controller.SGX == false)
                const SizedBox(width: 10),
                //if (controller.SGX == false)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                      color: /*controller.arrUserListData[index].tradeTypes ==
                                "buy"
                            ?*/
                          AppColors().blueColor.withOpacity(0.1),
                      //    : AppColors().redColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(2)),
                  child: Text("${controller.arrAccountSummaryListData[index].transactionType}",
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: Appfonts.family1SemiBold,
                          color: /*controller.arrUserListData[index].tradeTypes ==
                                  "buy"
                              ? */
                              AppColors().blueColor
                          //: AppColors().redColor,
                          )),
                ),
                //const Spacer(),
                // Text(controller.arrUserListData[index].tradeRate ?? "",
                //     style: TextStyle(
                //         fontSize: 14,
                //         fontFamily: Appfonts.family1Regular,
                //         color: AppColors().blueColor)),
              ],
            ),
            //if (controller.SGX == false)
            const SizedBox(
              height: 10,
            ),
            //if (controller.SGX == false)
            Row(
              children: [
                // Text(controller.arrUserListData[index].tradePValue ?? "",
                //     style: TextStyle(
                //         fontSize: 10,
                //         fontFamily: Appfonts.family1Regular,
                //         color: AppColors().lightText)),
                // Text("-> ",
                //     style: TextStyle(
                //         fontSize: 10,
                //         fontFamily: Appfonts.family1Regular,
                //         color: AppColors().lightText)
                // ),

                Text('${controller.arrAccountSummaryListData[index].amount!.toStringAsFixed(2)}', style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().blueColor)),
                const Spacer(),
                Text("${controller.arrAccountSummaryListData[index].type}", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
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
      _selectToDate(context, DateTime.parse(controller.fromDate!));
    }
  }

  Future<void> _selectToDate(BuildContext context, DateTime fromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate, // Set the initial date to the selected "From Date"
      firstDate: fromDate, // Set the first selectable date to the selected "From Date"
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
