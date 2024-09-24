import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/modelClass/constantModelClass.dart';
import 'package:market/navigation/routename.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/settingUserListController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:paginable/paginable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constant/color.dart';
import '../../../../constant/utilities.dart';
import '../../../../modelClass/userRoleListModelClass.dart';
import '../../../BaseViewController/baseController.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SettingUserListScreen extends BaseView<SettingUserListController> {
  const SettingUserListScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
            FocusManager.instance.primaryFocus?.unfocus();
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
            showPopupDialog();
          },
          headerTitle: "User List",
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
      body: Column(
        children: [
          userView(),
        ],
      ),
    );
  }

  Widget userView() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: AppColors().bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            children: [
              Container(
                child: Container(
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
                                  controller.getUserList();
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
              ),
              // controller.isLoadingData
              //         ? Container(
              //             width: 30,
              //             height: 30,
              //             child: Center(child: CircularProgressIndicator()),
              //           )
              //         : controller.arrUserListData.isNotEmpty
              //             ? ListView.builder(
              //                 physics: const AlwaysScrollableScrollPhysics(),
              //                 clipBehavior: Clip.hardEdge,
              //                 itemCount: controller.arrUserListData.length,
              //                 controller: controller.listcontroller,
              //                 shrinkWrap: true,
              //                 itemBuilder: (context, index) {
              //                   return userListView(context, index);
              //                 })
              //             : Container(
              //                 child: Center(
              //                 child: Text(
              //                   "Data not found".tr,
              //                   style: TextStyle(
              //                       fontSize: 15,
              //                       fontFamily: Appfonts.family1Regular,
              //                       color: AppColors().fontColor),
              //                 ),
              //               ))
              Expanded(
                  child: controller.isLoadingData
                      ? Container(
                          width: 30.w,
                          height: 30.h,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: AppColors().blueColor,
                            strokeWidth: 2,
                          )),
                        )
                      : controller.arrUserListData.isNotEmpty
                          ? PaginableListView.builder(
                              loadMore: () async {
                                if (controller.totalPage >= controller.currentPage) {
                                  print(controller.currentPage);
                                  controller.getUserList();
                                }
                              },
                              errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                              progressIndicatorWidget: Container(height: 50, child: displayIndicator()),
                              physics: const AlwaysScrollableScrollPhysics(),
                              clipBehavior: Clip.hardEdge,
                              itemCount: controller.arrUserListData.length,
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
                            ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget userListView(BuildContext, int index) {
    return GestureDetector(
      onTap: () {
        // if (!Get.isRegistered<UserListDetailsController>()) {
        //   Get.put(UserListDetailsController());
        // }
        Get.toNamed(RouterName.UserListDetailsScreen, arguments: {"userId": controller.arrUserListData[index].userId, "roll": controller.arrUserListData[index].role});
        controller.update();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.userImage,
                            width: 10,
                            height: 10,
                            color: AppColors().fontColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Center(
                            child: Text(controller.arrUserListData[index].userName ?? "", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                          ),
                        ],
                      ),
                      Text("Balance : " + controller.arrUserListData[index].credit!.toStringAsFixed(2), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: controller.arrUserListData[index].credit! > 0 ? AppColors().blueColor : AppColors().redColor)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(color: AppColors().blueColor.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                          controller.arrUserListData[index].role == UserRollList.master
                              ? "M"
                              : controller.arrUserListData[index].role == UserRollList.user
                                  ? "C"
                                  : controller.arrUserListData[index].role == UserRollList.broker
                                      ? "B"
                                      : "A",
                          style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Regular, color: AppColors().blueColor)),
                    ),
                  ),
                  // Image.asset(
                  //   AppImages.userListImage,
                  //   width: 30,
                  //   height: 30,
                  // ),
                ],
              ),
            ),
            Row(
              children: [
                Text("Credit : ${controller.arrUserListData[index].credit ?? ""}", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                const Spacer(),
                Text("${controller.arrUserListData[index].profitAndLossSharing ?? ""}%", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().redColor)),
                const SizedBox(
                  width: 7,
                )
              ],
            ),
            const SizedBox(
              height: 5,
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
                vertical: 23.1.h,
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
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
                          child: DropdownButton2<AddMaster>(
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
                              'Own User',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: Appfonts.family1Medium,
                                color: AppColors().lightText,
                              ),
                            ),
                            items: controller.userlist
                                .map((AddMaster item) => DropdownMenuItem<AddMaster>(
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
                              return controller.userlist
                                  .map((AddMaster item) => DropdownMenuItem<AddMaster>(
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
                            value: controller.userdropdownValue.value.id != null ? controller.userdropdownValue.value : null,
                            onChanged: (AddMaster? value) {
                              // setState(() {
                              controller.userdropdownValue.value = value!;
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
                              'Select User',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: Appfonts.family1Medium,
                                color: AppColors().lightText,
                              ),
                            ),
                            items: controller.selectUserlist
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
                              return controller.selectUserlist
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
                            value: controller.selectUserdropdownValue.value.roleId != null ? controller.selectUserdropdownValue.value : null,
                            onChanged: (userRoleListData? value) {
                              // setState(() {
                              controller.selectUserdropdownValue.value = value!;
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
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
                          child: DropdownButton2<AddMaster>(
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
                              'Select Status',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: Appfonts.family1Medium,
                                color: AppColors().lightText,
                              ),
                            ),
                            items: controller.selectStatuslist
                                .map((AddMaster item) => DropdownMenuItem<AddMaster>(
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
                              return controller.selectStatuslist
                                  .map((AddMaster item) => DropdownMenuItem<AddMaster>(
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
                            value: controller.selectStatusdropdownValue.value.id != null ? controller.selectStatusdropdownValue.value : null,
                            onChanged: (AddMaster? value) {
                              // setState(() {
                              controller.selectStatusdropdownValue.value = value!;
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
                              controller.userdropdownValue = AddMaster().obs;
                              controller.currentPage = 1;
                              controller.selectUserdropdownValue = userRoleListData().obs;
                              controller.selectStatusdropdownValue = AddMaster().obs;
                              controller.update();
                              controller.getUserList();
                              Get.back();
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
                              controller.getUserList();
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
