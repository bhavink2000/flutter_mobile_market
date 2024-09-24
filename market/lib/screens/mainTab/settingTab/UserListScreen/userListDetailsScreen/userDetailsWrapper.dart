import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/assets.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/customWidgets/appNavigationBar.dart';
import 'package:market/customWidgets/appTextField.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/settingUserListController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/userListDetailsScreen/userDetailsController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constant/color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../constant/utilities.dart';
import '../../../../../main.dart';
import '../../../../../modelClass/constantModelClass.dart';
import '../../../../../modelClass/userRoleListModelClass.dart';
import '../../../../../navigation/routename.dart';
import '../../CreateNewUserScreen/settingCreateNewUserController.dart';

class UserDetailsScreen extends BaseView<UserDetailsController> {
  const UserDetailsScreen({Key? key}) : super(key: key);

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
        trailingIcon: SizedBox(
          width: 45,
        ),
        headerTitle: "User Details",
        backGroundColor: AppColors().headerBgColor,
      ),
      backgroundColor: AppColors().headerBgColor,
      body: controller.isUserApiCallRunning == false && controller.arrUserDetailsData1 != null
          ? Column(
              children: [
                categoryListContent(context),
                if (controller.selectedCategory == 1) userDetailScreenContent(),
                if (controller.selectedCategory == 2) tradeListScreen(context),
                if (controller.selectedCategory == 3) positionScreen(),
                if (controller.selectedCategory == 4) userView(),
              ],
            )
          : Container(
              child: Center(
                  child: CircularProgressIndicator(
              color: AppColors().blueColor,
              strokeWidth: 2,
            ))),
    );
  }

  Widget categoryListContent(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    controller.selectedCategory = 1;
                    controller.update();
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Text("Overview", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: controller.selectedCategory == 1 ? AppColors().blueColor : AppColors().lightText)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      controller.selectedCategory == 1
                          ? Container(
                              color: AppColors().blueColor,
                              height: 2,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    controller.selectedCategory = 2;
                    controller.update();
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Text("Tradelist", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: controller.selectedCategory == 2 ? AppColors().blueColor : AppColors().lightText)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      controller.selectedCategory == 2
                          ? Container(
                              color: AppColors().blueColor,
                              height: 2,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    controller.selectedCategory = 3;
                    controller.update();
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Text("Position", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: controller.selectedCategory == 3 ? AppColors().blueColor : AppColors().lightText)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      controller.selectedCategory == 3
                          ? Container(
                              color: AppColors().blueColor,
                              height: 2,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            if (controller.roll != UserRollList.broker && controller.roll != UserRollList.user)
              Expanded(
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      controller.selectedCategory = 4;
                      controller.update();
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Text("User List", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: controller.selectedCategory == 3 ? AppColors().blueColor : AppColors().lightText)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        controller.selectedCategory == 4
                            ? Container(
                                color: AppColors().blueColor,
                                height: 2,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget userDetailScreenContent() {
    return Expanded(
      child: Container(
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: AppColors().bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(color: AppColors().blueColor.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                          controller.arrUserDetailsData1!.role == UserRollList.master
                              ? "M"
                              : controller.arrUserDetailsData1!.role == UserRollList.user
                                  ? "C"
                                  : controller.arrUserDetailsData1!.role == UserRollList.broker
                                      ? "B"
                                      : "",
                          style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Regular, color: AppColors().blueColor)),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.userImage,
                            width: 15,
                            height: 15,
                            color: AppColors().fontColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 3),
                            child: Text(controller.arrUserDetailsData1!.name ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Balance : " + controller.arrUserDetailsData1!.tradeBalance!.toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().redColor)),
                          const SizedBox(
                            width: 15,
                          ),
                          Text("C : ${controller.arrUserDetailsData1!.credit ?? ""}", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        if (!Get.isRegistered<UserDetailsController>()) {
                          Get.put(UserDetailsController());
                        }
                        if (!Get.isRegistered<SettingCreateNewUserController>()) {
                          Get.put(SettingCreateNewUserController());
                        } else {
                          Get.delete<SettingCreateNewUserController>();
                          Get.put(SettingCreateNewUserController());
                        }
                        var userDataLocal = Get.find<SettingUserListController>().arrUserListData.firstWhere((element) => element.userId == controller.arrUserDetailsData1!.userId!);
                        Get.toNamed(RouterName.SettingCreateNewUserScreen, arguments: {"isFromUserDetail": userDataLocal});
                      },
                      child: Center(
                        child: Image.asset(
                          AppImages.editIcons,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      clipBehavior: Clip.hardEdge,
                      shrinkWrap: true,
                      itemCount: controller.arrUserDetailsData.length,
                      controller: controller.sheetController,
                      itemBuilder: (context, index) {
                        return sheetList(context, index);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sheetList(BuildContext context, int index) {
    Color backgroundColor = index % 2 == 1 ? AppColors().footerColor : AppColors().contentBg;
    return GestureDetector(
      onTap: () {
        if (!Get.isRegistered<UserDetailsController>()) {
          Get.put(UserDetailsController());
        }
        if (controller.arrUserDetailsData[index].name == "Group Quantity Settings") {
          Get.toNamed(RouterName.GroupQuantityScreen, arguments: {"userId": controller.arrUserDetailsData1!.userId!});
        } else if (controller.arrUserDetailsData[index].name == "Brk Setting") {
          Get.toNamed(RouterName.brkSettingScreen, arguments: {"userId": controller.arrUserDetailsData1!.userId!});
        } else if (controller.arrUserDetailsData[index].name == "Sharing Details") {
          Get.toNamed(RouterName.SharingDetailsScreen, arguments: {"userId": controller.arrUserDetailsData1!.userId!});
        } else if (controller.arrUserDetailsData[index].name == "Change Password") {
          Get.toNamed(RouterName.UserListChangePasswordScreen, arguments: {"userId": controller.arrUserDetailsData1!.userId!});
        } else if (controller.arrUserDetailsData[index].name == "Trade Margin") {
          Get.toNamed(RouterName.tradeMarginScreen, arguments: {"userId": controller.arrUserDetailsData1!.userId!});
        } else if (controller.arrUserDetailsData[index].name == "Script Master") {
          Get.toNamed(RouterName.tradeMarginScreen, arguments: {"userId": controller.arrUserDetailsData1!.userId!});
        } else if (controller.arrUserDetailsData[index].name == "Credit History") {
          Get.toNamed(RouterName.creditGiveScreen, arguments: {"userId": controller.arrUserDetailsData1!.userId!});
        } else if (controller.arrUserDetailsData[index].name == "Add Order") {
          if (userData?.role == UserRollList.master && userData?.marketOrder == 1) {
            Get.toNamed(RouterName.UserListDetailsAddOrderScreen, arguments: {"userObj": controller.arrUserDetailsData1!});
          } else if (userData?.role == UserRollList.admin && userData?.manualOrder == 1) {
            Get.toNamed(RouterName.UserListDetailsAddOrderScreen);
          } else if (userData?.role == UserRollList.superAdmin) {
            Get.toNamed(RouterName.UserListDetailsAddOrderScreen);
          } else {
            showWarningToast(AppString.noAccessForManualOrder, controller.globalContext!);
          }
        }
        // if (controller.arrUserDetailsData[index].name == "Intraday SquareOff") {
        //   Get.toNamed(RouterName.UserListIntradayScreen);
        // }

        controller.update();
      },
      child: Container(
        width: 100.w,
        height: 38,
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          child: Row(
            children: [
              Text(controller.arrUserDetailsData[index].name.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
              const Spacer(),
              if (controller.arrUserDetailsData[index].isSwitch == false && controller.arrUserDetailsData[index].isMore == false && controller.arrUserDetailsData[index].values != null)
                Container(
                  width: 50.w,
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(controller.arrUserDetailsData[index].values.toString(), textAlign: TextAlign.end, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor, overflow: TextOverflow.ellipsis)),
                ),
              if (controller.arrUserDetailsData[index].isMore == true)
                Image.asset(
                  AppImages.arrowRightNew,
                  width: 24,
                  height: 24,
                  color: AppColors().fontColor,
                ),
              if (controller.arrUserDetailsData[index].values == null && controller.arrUserDetailsData[index].isMore == false)
                Container(
                  height: 15, //set desired REAL HEIGHT
                  width: 24,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.arrUserDetailsData[index].isSwitch! ? AppColors().blueColor : AppColors().lightText,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Transform.scale(
                    transformHitTests: false,
                    scale: .4,
                    child: CupertinoSwitch(
                      value: controller.arrUserDetailsData[index].isSwitch!,
                      activeColor: CupertinoColors.white,
                      trackColor: CupertinoColors.white,
                      thumbColor: controller.arrUserDetailsData[index].isSwitch! ? AppColors().blueColor : AppColors().switchColor,
                      onChanged: (bool value) async {
                        controller.arrUserDetailsData[index].isSwitch = !controller.arrUserDetailsData[index].isSwitch!;
                        controller.update();
                        if (controller.arrUserDetailsData[index].name == "Bet") {
                          final payload = {
                            "userId": controller.selectedUserId,
                            "bet": value,
                            "logStatus": "bet",
                          };
                          controller.updateUserStatus(payload);
                        } else if (controller.arrUserDetailsData[index].name == "Close Only") {
                          final payload = {
                            "userId": controller.selectedUserId,
                            "closeOnly": value,
                            "logStatus": "closeOnly",
                          };
                          controller.updateUserStatus(payload);
                        } else if (controller.arrUserDetailsData[index].name == "Auto Square Off") {
                          final payload = {
                            "userId": controller.selectedUserId,
                            "autoSquareOff": value ? 1 : 0,
                            "logStatus": "autoSquareOff",
                          };
                          controller.updateUserStatus(payload);
                        } else if (controller.arrUserDetailsData[index].name == "View Only") {
                          final payload = {
                            "userId": controller.selectedUserId,
                            "viewOnly": value,
                            "logStatus": "viewOnly",
                          };
                          controller.updateUserStatus(payload);
                        } else if (controller.arrUserDetailsData[index].name == "Status") {
                          final payload = {
                            "userId": controller.selectedUserId,
                            "status": value ? 1 : 2,
                            "logStatus": "status",
                          };
                          controller.updateUserStatus(payload);
                        }
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  //**************************************************** */
  //TRADELIST SCREEN
  //**************************************************** */

  Widget tradeListScreen(BuildContext context) {
    return Expanded(
      child: Container(
          // margin: EdgeInsets.only(top: 3.h),
          width: 100.w,
          decoration: BoxDecoration(
            color: AppColors().bgColor,
            // borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(20), topRight: Radius.circular(10))
          ),
          child: Column(
            children: [
              Container(
                height: 1,
                width: 90.w,
                color: AppColors().grayLightLine,
              ),
              Expanded(
                  child: controller.arrTrade.isNotEmpty
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          clipBehavior: Clip.hardEdge,
                          itemCount: controller.arrTrade.length,
                          controller: controller.listcontroller,
                          shrinkWrap: false,
                          itemBuilder: (context, index) {
                            return listContentView(context, index);
                          })
                      : Container(
                          child: Center(
                          child: Text(
                            "Data not found".tr,
                            style: TextStyle(fontSize: 15, fontFamily: Appfonts.family1Regular, color: AppColors().fontColor),
                          ),
                        ))),
            ],
          )),
    );
  }

  Widget listContentView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        controller.selectedTrade = controller.arrTrade[index];
        tradeDetailBottomSheet();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text((controller.arrTrade[index].exchangeName ?? "") + ", ", style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1SemiBold, color: AppColors().DarkText)),
                      Text((controller.arrTrade[index].symbolName ?? "") + ", ", style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                      Text((controller.arrTrade[index].exchangeName!.toLowerCase() == "mcx" ? controller.arrTrade[index].quantity.toString() + " " : controller.arrTrade[index].totalQuantity.toString() + " "),
                          style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1Medium, color: controller.arrTrade[index].tradeType == "buy" ? AppColors().blueColor : AppColors().redColor)),
                      Text(controller.arrTrade[index].tradeTypeValue!.toUpperCase() + " ", style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1Medium, color: controller.arrTrade[index].tradeType == "buy" ? AppColors().blueColor : AppColors().redColor)),
                      Text(controller.arrTrade[index].productTypeValue!, style: TextStyle(fontSize: 13, fontFamily: Appfonts.family1Medium, color: controller.arrTrade[index].tradeType == "buy" ? AppColors().blueColor : AppColors().redColor)),
                      Spacer(),
                      Text(controller.arrTrade[index].price.toString(), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: controller.arrTrade[index].tradeType == "buy" ? AppColors().blueColor : AppColors().redColor)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      if (userData?.role != UserRollList.user)
                        Image.asset(
                          AppImages.profileIcon,
                          width: 15,
                          height: 15,
                          color: AppColors().fontColor,
                        ),
                      if (userData?.role != UserRollList.user)
                        const SizedBox(
                          width: 5,
                        ),
                      if (userData?.role != UserRollList.user) Text(controller.arrTrade[index].userName ?? "", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                      Spacer(),
                      Text(shortFullDateTime(controller.arrTrade[index].createdAt!), style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              width: 90.w,
              color: AppColors().grayLightLine,
            )
          ],
        ),
      ),
    );
  }

  Widget detailTopView() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(color: controller.selectedTrade!.tradeType! == "buy" ? AppColors().blueColor.withOpacity(0.1) : AppColors().redColor.withOpacity(0.1), borderRadius: BorderRadius.circular(2)),
                        child: Text(controller.selectedTrade!.tradeType!.toUpperCase(), style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: controller.selectedTrade!.tradeType! == "buy" ? AppColors().blueColor : AppColors().redColor)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(controller.selectedTrade!.symbolName ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.profileIcon,
                            width: 15,
                            height: 15,
                            color: AppColors().fontColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(controller.selectedTrade?.userName ?? "", style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.profileIcon,
                            width: 15,
                            height: 15,
                            color: AppColors().fontColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(shortFullDateTime(controller.selectedTrade!.createdAt!), style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText)),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(controller.selectedTrade!.price.toString(),
                          style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: controller.getTradePriceColor(controller.selectedTrade!.tradeType!, controller.selectedTrade!.currentPriceFromScoket ?? 0, controller.selectedTrade!.price!.toDouble()))),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("${controller.selectedTrade!.quantity.toString()}/${controller.selectedTrade!.totalQuantity.toString()}", textAlign: TextAlign.end, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 90.w,
            color: AppColors().lightText,
            height: 0.5,
          ),
        ],
      ),
    );
  }

  tradeDetailBottomSheet() {
    Get.bottomSheet(
        PopScope(
          canPop: false,
          onPopInvoked: (canpop) {},
          child: StatefulBuilder(builder: (context, stateSetter) {
            return Column(
              children: [
                Expanded(child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                )),
                Container(
                    height: 68.h,
                    decoration: BoxDecoration(
                        // borderRadius: const BorderRadius.only(
                        //     topLeft: Radius.circular(20),
                        //     topRight: Radius.circular(20)),
                        color: AppColors().bgColor),
                    child: Column(
                      children: [
                        detailTopView(),
                        SizedBox(
                          height: 1.h,
                        ),
                        Expanded(
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            shrinkWrap: false,
                            children: [
                              sheetLists("Username", controller.selectedTrade?.userName ?? "", 0),
                              sheetLists("Order Time", "25 JUl 2023 10:25:53", 1),
                              sheetLists("Symbol", controller.selectedTrade?.symbolName ?? "", 2),
                              sheetLists("Order Type", controller.selectedTrade?.orderType ?? "", 3),
                              sheetLists("Quantity", controller.selectedTrade!.quantity!.toString(), 4),
                              sheetLists("Price", controller.selectedTrade!.price.toString(), 5),
                              sheetLists("Brk", "155.92", 6),
                              sheetLists("Reference Price", "389.8", 7),
                              sheetLists("Order Method", "IOS", 8),
                              sheetLists("Ipaddress", "152.58.4.124", 9),
                              sheetLists("Device Id", "1547845212458756458", 10),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            );
          }),
        ),
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: true);
  }

  Widget sheetLists(String name, String value, int index) {
    Color backgroundColor = index % 2 == 1 ? AppColors().headerBgColor : AppColors().contentBg;
    return Container(
      width: 100.w,
      height: 38,
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: Row(
          children: [
            Text(name.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
            const Spacer(),
            Text(value.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
          ],
        ),
      ),
    );
  }

  //**************************************************** */
  //POSITION SCREEN
  //**************************************************** */
  Widget positionScreen() {
    return Expanded(
      flex: 1,
      child: SizedBox(
        width: 100.w,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(top: controller.isTotalViewExpanded ? 27.h : 5.h),
              width: 100.w,
              decoration: BoxDecoration(color: AppColors().bgColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(10))),
              child: Container(
                margin: EdgeInsets.only(top: 0.h),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.isTotalViewExpanded = !controller.isTotalViewExpanded;
                controller.update();
              },
              child: Column(
                children: [
                  totalView(),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(top: 50),
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        clipBehavior: Clip.hardEdge,
                        itemCount: controller.arrPositionScriptList.length,
                        controller: controller.listcontroller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return positionListContentView(context, index);
                        }),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget totalView() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: controller.isTotalViewExpanded ? 210 : 62,
      width: 92.5.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(color: AppColors().postionTotalBox, borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: ClipRRect(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                controller.isTotalViewExpanded = !controller.isTotalViewExpanded;
                controller.update();
              },
              child: Container(
                width: 100.w,
                color: AppColors().postionTotalDetailsBox,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text("Total", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                        ),
                        Spacer(),
                        Container(
                          child: RotatedBox(
                            quarterTurns: controller.isTotalViewExpanded ? 90 : 180,
                            child: Icon(
                              Icons.expand_more,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                          // userData?.role == UserRollList.user
                          //     ? "${(((userData!.profitLoss! - userData!.brokerageTotal!) + controller.totalPosition.value).toStringAsFixed(2))}"
                          //     : "${(((userData!.profitLoss! + userData!.brokerageTotal!) + controller.totalPositionPercentWise.value).toStringAsFixed(2))}",
                          "${(((controller.arrUserDetailsData1!.profitLoss! - controller.arrUserDetailsData1!.brokerageTotal!) + controller.totalPosition.value).toStringAsFixed(2))}",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: Appfonts.family1Medium,
                              color: controller.totalPosition.value > 0
                                  ? Colors.white
                                  : controller.totalPosition.value < 0
                                      ? AppColors().redColor
                                      : Colors.white)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            //   height: 0.5,
            //   color: AppColors().DarkText.withOpacity(0.5),
            // ),
            Offstage(
              offstage: controller.isTotalViewExpanded == false,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Realised P&L", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              if (controller.arrUserDetailsData1!.role == UserRollList.user)
                                Text((controller.arrUserDetailsData1!.profitLoss! - controller.arrUserDetailsData1!.brokerageTotal!).toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                              if (controller.arrUserDetailsData1!.role != UserRollList.user)
                                Text((controller.arrUserDetailsData1!.profitLoss! + controller.arrUserDetailsData1!.brokerageTotal!).toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Unrealised P&L", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              Text(
                                // Get.arguments['roll'] == UserRollList.user ? controller.totalPosition.toStringAsFixed(2) : controller.totalPositionPercentWise.toStringAsFixed(2),
                                controller.totalPosition.toStringAsFixed(2),
                                style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Margin Used", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              Text((controller.arrUserDetailsData1!.marginBalance! - controller.arrUserDetailsData1!.tradeMarginBalance!).toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Free margin", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              Text(controller.arrUserDetailsData1!.tradeMarginBalance!.toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Equity", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              Text(((controller.arrUserDetailsData1!.credit! + controller.totalPosition.value + controller.arrUserDetailsData1!.profitLoss!) - controller.arrUserDetailsData1!.brokerageTotal!).toStringAsFixed(2),
                                  style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                            ],
                          ),
                        ),
                        // Spacer(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Credit", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor.withOpacity(0.75))),
                              const Spacer(),
                              Text(controller.arrUserDetailsData1!.credit!.toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().whiteColor)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget positionListContentView(BuildContext context, int index) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5.w),
            child: Row(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text("${controller.arrPositionScriptList[index].exchangeName} ${controller.arrPositionScriptList[index].symbolTitle}, ", style: TextStyle(fontSize: 13, fontFamily: Appfonts.family2, color: AppColors().DarkText)),
                          Text(controller.arrPositionScriptList[index].totalQuantity! > 0 ? "BUY " : "Sell" + " ",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: Appfonts.family2,
                                color: controller.arrPositionScriptList[index].totalQuantity! > 0 ? AppColors().blueColor : AppColors().redColor,
                              )),
                          Text(controller.arrPositionScriptList[index].exchangeName!.toLowerCase() == "mcx" ? controller.arrPositionScriptList[index].quantity!.toString() : controller.arrPositionScriptList[index].totalQuantity!.toString(),
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: Appfonts.family2,
                                color: controller.arrPositionScriptList[index].totalQuantity! > 0 ? AppColors().blueColor : AppColors().redColor,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          "${double.parse(controller.arrPositionScriptList[index].price!.toStringAsFixed(2))} -> ${controller.arrPositionScriptList[index].totalQuantity! < 0 ? controller.arrPositionScriptList[index].ask!.toStringAsFixed(2).toString() : controller.arrPositionScriptList[index].bid!.toStringAsFixed(2).toString()}",
                          style: TextStyle(fontSize: 10, fontFamily: Appfonts.family1Regular, color: AppColors().lightText))
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(double.parse(controller.arrPositionScriptList[index].profitLossValue!.toStringAsFixed(2)).toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Appfonts.family1Medium,
                              color: controller.getPriceColor(
                                controller.arrPositionScriptList[index].profitLossValue!,
                              ))),
                      const SizedBox(
                        height: 5,
                      ),
                      if (userData!.role != UserRollList.user)
                        Text("( " + controller.getPlPer(percentage: controller.arrPositionScriptList[index].profitAndLossSharing!, pl: controller.arrPositionScriptList[index].profitLossValue!).toStringAsFixed(2) + " )",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 10, fontFamily: Appfonts.family1Regular, color: controller.getPlPer(percentage: controller.arrPositionScriptList[index].profitAndLossSharing!, pl: controller.arrPositionScriptList[index].profitLossValue!) > 0 ? AppColors().blueColor : AppColors().redColor)),
                      // Text(
                      //     controller.arrPositionScriptList[index].quantity
                      //         .toString(),
                      //     textAlign: TextAlign.end,
                      //     style: TextStyle(
                      //         fontSize: 12,
                      //         fontFamily: Appfonts.family1Regular,
                      //         color: AppColors().DarkText)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            width: 90.w,
            color: AppColors().grayLightLine,
          )
        ],
      ),
    );
  }

  Widget sheetListss(String name, String value, int index) {
    Color backgroundColor = AppColors().contentBg;
    return Container(
      width: 100.w,
      height: 38,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: Row(
          children: [
            Text(name.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Text(value.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
          ],
        ),
      ),
    );
  }

  Widget orderTypeInBottomSheetss(BuildContext context, int index, Type value) {
    return Container(
      // height: 40.h,
      width: 31.5.w,
      height: 5.h,
      margin: EdgeInsets.only(left: index == 0 ? 20 : 0, right: index == constantValues!.orderType!.length - 1 ? 20 : 0),
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.selectedOrderType = constantValues!.orderType![index];
                  controller.selectedOptionBottomSheetTab.value = index;
                },
                child: Container(
                  height: 5.h,
                  // width: 10.w,
                  margin: EdgeInsets.only(right: constantValues!.orderType!.length - 1 == index ? 20 : 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: controller.selectedOptionBottomSheetTab == index ? AppColors().blueColor : AppColors().grayBorderColor, width: 1)),
                  child: Center(
                    child: Text(value.name ?? "", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: controller.selectedOptionBottomSheetTab == index ? AppColors().blueColor : AppColors().lightOnlyText)),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget qtyPriceView() {
    return Container(
      // height: 40.h,
      width: 89.w,
      height: 12.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors().bgColor, boxShadow: [
        BoxShadow(
          color: AppColors().fontColor.withOpacity(0.2),
          offset: Offset.zero,
          spreadRadius: 2,
          blurRadius: 7,
        ),
      ]),
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Quantity", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                        const Spacer(),
                        Text("Lot Size ${controller.selectedScript!.value!.lotSize!.toString()}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 5.h,
                      child: CustomTextField(
                        type: 'Quantity',
                        regex: '[0-9]',
                        onTap: () {
                          if (controller.buySellBottomSheetKey?.currentState?.expansionStatus == ExpansionStatus.contracted) {
                            controller.buySellBottomSheetKey?.currentState?.expand();
                          }
                        },
                        // fillColor: AppColors().headerBgColor,
                        keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                        isEnabled: true,
                        isOptional: false,
                        inValidMsg: AppString.emptyPassword,
                        placeHolderMsg: "Quantity",
                        labelMsg: "Quantity",
                        emptyFieldMsg: AppString.emptyPassword,
                        controller: controller.qtyController,
                        focus: controller.qtyFocus,
                        isSecure: false,
                        maxLength: 6,
                        keyboardButtonType: TextInputAction.done,
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (controller.selectedOptionBottomSheetTab > 0)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Price", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                          const Spacer(),
                          Text(
                              // "Tick Size ${controller.selectedScript!.value!.ts!.toString()}",
                              "Tick Val",
                              style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 5.h,
                        width: 100.w,
                        child: CustomTextField(
                          type: 'Price',
                          regex: '[0-9.]',
                          onTap: () {
                            if (controller.buySellBottomSheetKey?.currentState?.expansionStatus == ExpansionStatus.contracted) {
                              controller.buySellBottomSheetKey?.currentState?.expand();
                            }
                          },
                          keyBoardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                          isEnabled: true,
                          isOptional: false,
                          inValidMsg: AppString.emptyPassword,
                          placeHolderMsg: "Price",
                          labelMsg: "Price",
                          emptyFieldMsg: AppString.emptyPassword,
                          controller: controller.priceController,
                          focus: controller.priceFocus,
                          isSecure: false,
                          maxLength: 8,
                          keyboardButtonType: TextInputAction.done,
                        ),
                      )
                    ],
                  ),
                ),
              )
          ],
        );
      }),
    );
  }

  displyMoreOptionBootomSheet() {
    // GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
    controller.buySellBottomSheetKey = GlobalKey();
    Future.delayed(const Duration(milliseconds: 100), () {
      controller.buySellBottomSheetKey?.currentState?.expand();
    });
    Get.bottomSheet(
        PopScope(
          canPop: false,
          onPopInvoked: (canpop) {},
          child: StatefulBuilder(builder: (context, stateSetter) {
            return Container(
              height: 90.h,
              width: 100.w,
              decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: AppColors().bgColor),
              child: SingleChildScrollView(
                // physics: ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(controller.selectedScript?.value?.symbolName ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    AppImages.crossIcon,
                                    width: 35,
                                    height: 35,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(controller.selectedScript!.value!.price.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Appfonts.family1Medium,
                                        color: controller.selectedScript!.value!.scriptDataFromSocket.value.ch != null
                                            ? controller.getPriceColorss(
                                                controller.selectedScript!.value!.scriptDataFromSocket.value.ch!.toDouble(),
                                              )
                                            : AppColors().DarkText)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("${controller.selectedScript!.value!.scriptDataFromSocket.value.ch ?? ""}(${controller.selectedScript!.value!.scriptDataFromSocket.value.chp ?? ""}%)", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().DarkText)),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                    Container(
                      height: 1,
                      width: 100.w,
                      color: AppColors().grayLightLine,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: SizedBox(
                        height: 5.h,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            itemCount: constantValues?.orderType?.length ?? 0,
                            controller: controller.orderTypeListcontroller,
                            scrollDirection: Axis.horizontal,
                            // shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return orderTypeInBottomSheetss(context, index, constantValues!.orderType![index] as Type);
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(child: qtyPriceView()),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 42.w,
                          child: CustomButton(
                            isEnabled: true,
                            shimmerColor: AppColors().whiteColor,
                            title: "Buy",
                            textSize: 16,
                            prefixHeight: 22,
                            onPress: () {
                              // controller.qtyController.text = "";
                              // controller.priceController.text = "";
                              var msg = controller.validateForm();
                              if (msg.isEmpty) {
                                Get.back();
                                controller.isForBuy = true;
                                // buySellBottomSheet(true);
                                controller.initiateTrade(stateSetter);
                              } else {
                                showWarningToast(msg, controller.globalContext!);
                              }
                            },
                            bgColor: AppColors().blueColor,
                            isFilled: true,
                            textColor: AppColors().whiteColor,
                            isTextCenter: true,
                            isLoading: false,
                          ),
                        ),
                        SizedBox(
                          width: 42.w,
                          child: CustomButton(
                            isEnabled: true,
                            shimmerColor: AppColors().whiteColor,
                            title: "Sell",
                            textSize: 16,
                            prefixHeight: 22,
                            onPress: () {
                              // controller.qtyController.text = "";
                              // controller.priceController.text = "";
                              var msg = controller.validateForm();
                              if (msg.isEmpty) {
                                Get.back();
                                controller.isForBuy = false;
                                // buySellBottomSheet(false);
                                controller.initiateTrade(stateSetter);
                              } else {
                                showWarningToast(msg, controller.globalContext!);
                              }
                            },
                            bgColor: AppColors().redColor,
                            isFilled: true,
                            textColor: AppColors().whiteColor,
                            isTextCenter: true,
                            isLoading: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                //
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppImages.chartIcon,
                                    width: 20,
                                    height: 20,
                                    color: AppColors().blueColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("View Chart", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    AppImages.arrowRight,
                                    width: 20,
                                    height: 20,
                                    color: AppColors().blueColor,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      child: Container(
                        height: 1,
                        width: 100.w,
                        color: AppColors().grayLightLine,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      // height: 45.h,
                      color: AppColors().bgColor,
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                              ),
                              child: Obx(() {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text("Open", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                        Text("${controller.selectedScript!.value!.scriptDataFromSocket.value.open ?? "-"}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("High", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                        Text("${controller.selectedScript!.value!.scriptDataFromSocket.value.high ?? "-"}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("Low", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                        Text("${controller.selectedScript!.value!.scriptDataFromSocket.value.low ?? "-"}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("Prev. close", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                        Text("${controller.selectedScript!.value!.scriptDataFromSocket.value.close ?? "-"}", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Obx(() {
                              return controller.selectedScript!.value!.scriptDataFromSocket.value.depth == null
                                  ? const SizedBox()
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 43.w,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Bid", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                    const Spacer(),
                                                    Text("Order", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                    const Spacer(),
                                                    Text("Qty", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  child: ListView.builder(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    clipBehavior: Clip.hardEdge,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    itemCount: controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.buy!.length,
                                                    itemBuilder: (context, index) {
                                                      return bottomSheetList((controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.buy![index].price ?? 0).toString(), (controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.buy![index].orders ?? 0).toString(),
                                                          (controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.buy![index].quantity ?? 0).toString(), AppColors().blueColor, 0);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Text("Total", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                                                      const Spacer(),
                                                      Text(controller.getTotal(true).toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 43.w,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Offer", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                    const Spacer(),
                                                    Text("Order", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                    const Spacer(),
                                                    Text("Qty", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  child: ListView.builder(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    clipBehavior: Clip.hardEdge,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    itemCount: controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.sell!.length,
                                                    itemBuilder: (context, index) {
                                                      return bottomSheetList((controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.sell![index].price ?? 0).toString(), (controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.sell![index].orders ?? 0).toString(),
                                                          (controller.selectedScript!.value!.scriptDataFromSocket.value.depth!.sell![index].quantity ?? 0).toString(), AppColors().blueColor, 0);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Text("Total", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().redColor)),
                                                      const Spacer(),
                                                      Text(controller.getTotal(false).toStringAsFixed(2), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().redColor)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            }),
                            const SizedBox(
                              height: 0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                              ),
                              child: Container(
                                height: 1,
                                width: 100.w,
                                color: AppColors().grayLightLine,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Obx(() {
                              return ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                clipBehavior: Clip.hardEdge,
                                shrinkWrap: true,
                                controller: controller.sheetController,
                                children: [
                                  sheetListss("Lot Size", controller.selectedScript!.value!.lotSize!.toString(), 0),
                                  sheetListss("LTP", controller.selectedScript!.value!.price!.toString(), 1),
                                  sheetListss("Volume", controller.selectedScript!.value!.quantity!.toString(), 2),
                                  sheetListss("Avg. Price", "Key Not found", 3),
                                  sheetListss("Time", shortTime(DateTime.now()), 4)
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    )
                  ],
                ),
              ),
            );
            // return BottomSheet(
            //   key: controller.buySellBottomSheetKey,
            //   // background: GestureDetector(
            //   //   onTap: () {
            //   //     Get.back();
            //   //   },
            //   //   child: Container(
            //   //     color: Colors.transparent,
            //   //     child: const Center(
            //   //       child: Text(''),
            //   //     ),
            //   //   ),
            //   // ),
            //   onClosing: () {},
            //   builder: (context) =>
            //   // expandableContent:
            // );
          }),
        ),
        isDismissible: true,
        isScrollControlled: true,
        enableDrag: true);
  }

  Widget bottomSheetList(String bid, String order, String Qty, Color fontColors, int index) {
    return Container(
      // width: 100.w,
      height: 20,
      child: Row(
        children: [
          Text(bid.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: fontColors)),
          const Spacer(),
          Text(order.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: fontColors)),
          const Spacer(),
          Text(Qty.toString(), style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: fontColors)),
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
                        height: 1,
                        width: 100.w,
                        color: AppColors().grayLightLine,
                      ),
                      const SizedBox(
                        height: 10,
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
                          child: const Center(child: CircularProgressIndicator()),
                        )
                      : controller.arrUserListData.isNotEmpty
                          ? ListView.builder(
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
        Get.toNamed(RouterName.UserListDetailsScreen, arguments: {"userId": controller.arrUserListData[index].userId});
        controller.update();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
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
                      const SizedBox(
                        height: 5,
                      ),
                      //
                      Text("Balance : " + controller.arrUserListData[index].credit!.toStringAsFixed(2), style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().redColor)),
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
                                      : "",
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
            const SizedBox(
              height: 5,
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
                vertical: 24.h,
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

                              controller.selectUserdropdownValue = userRoleListData().obs;
                              controller.selectStatusdropdownValue = AddMaster().obs;
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
