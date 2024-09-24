import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:market/constant/commonFunction.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/customWidgets/appButton.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/settingListModelClass.dart';
import 'package:market/navigation/routename.dart';
import 'package:market/screens/mainTab/homeTab/homeController.dart';
import 'package:market/screens/mainTab/settingTab/CreateNewUserScreen/settingCreateNewUserController.dart';
import 'package:market/screens/mainTab/settingTab/settingController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../../../constant/const_string.dart';
import '../../../../../constant/color.dart';
import '../../../constant/assets.dart';
import '../../../constant/font_family.dart';
import '../../../customWidgets/appNavigationBar.dart';
import '../../BaseViewController/baseController.dart';
import '../tabScreen/MainTabController.dart';
import 'package:ticker_text/ticker_text.dart';
import 'package:section_view/section_view.dart';
import 'package:flutter_share/flutter_share.dart';

import 'NotificationScreen/notificationScreenController.dart';

class SettingScreen extends BaseView<SettingController> {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().headerBgColor,
      appBar: appNavigationBar(
          isTrailingDisplay: true,
          isMarketDisplay: true,
          leadingTitleText: "Settings",
          backGroundColor: AppColors().headerBgColor,
          trailingIcon: Image.asset(
            AppImages.notificationIcon,
            width: 20,
            height: 20,
            color: AppColors().blueColor,
            // color: AppColors().fontColor,
          ),
          isMoreDisplay: true,
          onMoreButtonPress: () {
            controller.isHedaderDropdownSelected.value = !controller.isHedaderDropdownSelected.value;
            if (controller.isHedaderDropdownSelected.value) {
              Future.delayed(const Duration(milliseconds: 300), () {
                controller.isHedaderDropdownOpen.value = true;
              });
            } else {
              controller.isHedaderDropdownOpen.value = false;
            }
          },
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
      body: Column(
        children: [
          // headerDropDown(),
          // userView(),
          newsView(),
          mainDetailView(),
        ],
      ),
    );
  }

  Widget userView() {
    return Container(
      color: AppColors().headerBgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Row(
          children: [
            Text("User", style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
            const Spacer(),
            Container(
              height: 20, //set desired REAL HEIGHT
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: controller.isDetailSciptOn ? AppColors().blueColor : AppColors().lightText,
              ),
              child: Transform.scale(
                transformHitTests: false,
                scale: .5,
                child: CupertinoSwitch(
                  value: controller.isDetailSciptOn,
                  activeColor: AppColors().whiteColor,
                  trackColor: AppColors().whiteColor,
                  thumbColor: controller.isDetailSciptOn ? AppColors().blueColor : AppColors().switchColor,
                  onChanged: (bool value) async {
                    controller.isDetailSciptOn = !controller.isDetailSciptOn;
                    await controller.localStorage.write(localStorageKeys.isDetailSciptOn, controller.isDetailSciptOn);
                    controller.update();
                    var homeVc = Get.find<HomeController>();
                    homeVc.refreshSciptLayout();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newsView() {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 0.h, bottom: 2.h),
        height: 50,
        color: AppColors().footerColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Image.asset(
                AppImages.volumeIcon,
                width: 25,
                height: 25,
                color: AppColors().fontColor,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Container(
                  child: SizedBox(
                    width: 80.w, // constrain the parent width so the child overflows and scrolling takes effect
                    child: TickerText(
                      // default values
                      controller: controller.moveTextController, // this is optional

                      scrollDirection: Axis.horizontal,
                      speed: 20,
                      startPauseDuration: const Duration(seconds: 2),
                      primaryCurve: Curves.linear,
                      returnCurve: Curves.easeOut,
                      child: Text(constantValues!.settingData?.banMessage ?? "",
                          style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Regular, color: AppColors().redColor)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainDetailView() {
    return Expanded(
      // flex: 12,
      child: SizedBox(
        width: 100.w,
        child: Stack(
          children: [
            Container(
              width: 100.w,
              margin: EdgeInsets.only(top: 3.h),
              decoration: BoxDecoration(
                  color: AppColors().bgColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              child: Container(
                margin: EdgeInsets.only(top: 8.h),
                child: Column(
                  children: [
                    Expanded(
                      child: SectionView<GroupModel, ItemModel>(
                        source: controller.arrCategoryData,
                        onFetchListData: (header) => header.items,
                        headerBuilder: (buildContext, groupModel, int) {
                          return Container(
                            color: AppColors().bgColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                                  child: Text(groupModel.name.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: Appfonts.family1SemiBold,
                                        color: Color.fromRGBO(136, 136, 136, 1),
                                      )),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Container(
                                    height: 1,
                                    width: 100.w,
                                    color: AppColors().grayLightLine.withOpacity(currentisDarkModeOn ? 0.25 : 1),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemBuilder: (context, itemData, itemIndex, headerData, headerIndex) => GestureDetector(
                          onTap: () async {
                            if (itemData.name == "Create New User") {
                              // Create New User
                              if (userData!.role != UserRollList.user && userData!.role != UserRollList.broker) {
                                Get.toNamed(RouterName.SettingCreateNewUserScreen);
                              } else {
                                showWarningToast(AppString.accessRestricted, controller.globalContext!);
                              }
                            }
                            if (itemData.name == "User List") {
                              if (userData!.role != UserRollList.user && userData!.role != UserRollList.broker) {
                                if (Get.isRegistered<SettingCreateNewUserController>()) {
                                  Get.delete<SettingCreateNewUserController>();
                                }
                                Get.put(SettingCreateNewUserController());
                                Get.toNamed(RouterName.SettingUserListScreen);
                              } else {
                                showWarningToast(AppString.accessRestricted, controller.globalContext!);
                              }
                            }
                            if (itemData.name == "Search User") {
                              if (userData!.role != UserRollList.user && userData!.role != UserRollList.broker) {
                                Get.toNamed(RouterName.SearchUserListScreen);
                              } else {
                                showWarningToast(AppString.accessRestricted, controller.globalContext!);
                              }
                            }
                            if (itemData.name == "Bulk Trade") {
                              Get.toNamed(RouterName.bulkTradeScreen);
                            }
                            if (itemData.name == "Account Report") {
                              Get.toNamed(RouterName.accountReportScreen);
                            }
                            if (itemData.name == "Generate Bill") {
                              Get.toNamed(RouterName.GenerateBillScreen);
                            }
                            if (itemData.name == "Weekly Admin") {
                              Get.toNamed(RouterName.WeeklyAdminScreen);
                            }
                            if (itemData.name == "Intraday History") {
                              Get.toNamed(RouterName.IntradayHistoryScreen);
                            }
                            if (itemData.name == "P&L") {
                              if (userData!.role != UserRollList.user && userData!.role != UserRollList.broker) {
                                Get.toNamed(RouterName.ClientPLScreen);
                              } else {
                                showWarningToast(AppString.accessRestricted, controller.globalContext!);
                              }
                            }

                            if (itemData.name == "Settlements Report") {
                              Get.toNamed(RouterName.SettlementReportScreen);
                            }
                            if (itemData.name == "Trade Margin") {
                              Get.toNamed(RouterName.tradeMarginScreen);
                            }
                            if (itemData.name == "Trade Logs") {
                              Get.toNamed(RouterName.tradeLogsScreen);
                            }
                            if (itemData.name == "Script Master") {
                              Get.toNamed(RouterName.scriptMasterScreen);
                            }
                            if (itemData.name == "User Wise Position") {
                              Get.toNamed(RouterName.UserWiseScreen);
                            }
                            if (itemData.name == "Open Position") {
                              Get.toNamed(RouterName.openPositionScreen);
                            }
                            if (itemData.name == "Rejection Log") {
                              Get.toNamed(RouterName.rejectionLogScreen);
                            }
                            if (itemData.name == "Script Quantity") {
                              Get.toNamed(RouterName.ScriptQuantityScreen);
                            }
                            if (itemData.name == "Symbol Wise Position Report") {
                              Get.toNamed(RouterName.symbolWisePositionReportScreen);
                            }
                            if (itemData.name == "User Script Position Tracking") {
                              Get.toNamed(RouterName.userScriptPositionTracking);
                            }
                            if (itemData.name == "Credit History") {
                              Get.toNamed(RouterName.historyOfCreditScreen);
                            }
                            if (itemData.name == "Profit & Loss") {
                              Get.toNamed(RouterName.profitAndLossScreen);
                            }
                            if (itemData.name == "Set  Quantity Values") {
                              Get.toNamed(RouterName.SetQuantityValueScreen);
                            }
                            if (itemData.name == "Messages") {
                              Get.toNamed(RouterName.SettingMessageScreen);
                            }
                            if (itemData.name == "Market Timings") {
                              Get.toNamed(RouterName.MarketTimingScreen);
                            }
                            if (itemData.name == "Profile") {
                              Get.toNamed(RouterName.SettingProfileScreen);
                            }
                            if (itemData.name == "Notification Settings") {
                              Get.put(SettingNotificationController());
                              Get.toNamed(RouterName.SettingNotificationScreen);
                            }
                            if (itemData.name == "Change Password") {
                              Get.toNamed(RouterName.UserListChangePasswordScreen);
                            }
                            if (itemData.name == "Login History") {
                              Get.toNamed(RouterName.SettingLoginHistoryScreen);
                            }
                            if (itemData.name == "Privacy Policy") {
                              await launchUrl(Uri.parse('https://bazaar2.in/privacy-policy.html'));
                            }
                            if (itemData.name == "Terms & Conditions") {
                              await launchUrl(Uri.parse('https://bazaar2.in/terms-conditions.html'));
                            }
                            if (itemData.name == "Contact Us") {
                              await launchUrl(Uri.parse('https://bazaar2.in/contact.html'));
                            }
                            if (itemData.name == "Delete Account") {
                              showPermissionDialog(
                                  message: "Are you sure you want to delete your account?",
                                  acceptButtonTitle: "Yes",
                                  rejectButtonTitle: "No",
                                  yesClick: () {
                                    service.logoutCall();
                                    socket.channel?.sink.close(status.normalClosure);
                                    socketIO.socketForTrade?.disconnect();
                                    socketIO.socketForTrade?.dispose();
                                    arrSymbolNames.clear();
                                    controller.localStorage.erase();
                                    if (profileTimer != null) {
                                      profileTimer!.cancel();
                                      profileTimer = null;
                                    }

                                    Get.changeTheme(ThemeData.light());
                                    currentisDarkModeOn = false;
                                    controller.localStorage.write(localStorageKeys.isDarkMode, false);
                                    userData = null;
                                    SystemChrome.setSystemUIOverlayStyle(getSystemUiOverlayStyle());
                                    Get.offAllNamed(RouterName.signInScreen);
                                  },
                                  noclick: () {
                                    Get.back();
                                  });
                            }

                            if (itemData.name == "Invite Friends") {
                              share();
                              print('object');
                            }
                            if (itemData.name == "Theme") {
                              controller.isThemeOpen = !controller.isThemeOpen;
                              controller.update();
                            }
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                        child: itemData.name == "Theme"
                                            ? Icon(
                                                Icons.dark_mode_sharp,
                                                size: 20,
                                                color: AppColors().blueColor,
                                              )
                                            : Image.asset(
                                                itemData.ImageName,
                                                width: 20,
                                                height: 20,
                                                color: AppColors().blueColor,
                                              ),
                                      ),
                                      Text(itemData.name,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: Appfonts.family1Medium,
                                            color: AppColors().settingItemText,
                                          )),
                                      const Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 17,
                                        color: AppColors().settingItemText.withOpacity(0.5),
                                      )
                                    ],
                                  ),
                                ),
                                if (itemData.name == "Theme")
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    height: controller.isThemeOpen ? 13.h : 0,
                                    padding: EdgeInsets.symmetric(horizontal: 12.5.w),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (currentisDarkModeOn) {
                                              isThemeChange = true;
                                              await socket.channel?.sink.close(status.normalClosure);
                                              socket.channel = null;
                                              await socketIO.socketForTrade?.disconnect();
                                              socketIO.socketForTrade?.dispose();
                                              arrSymbolNames.clear();
                                              Get.changeTheme(ThemeData.light());
                                              currentisDarkModeOn = false;
                                              controller.localStorage.write(localStorageKeys.isDarkMode, false);
                                              SystemChrome.setSystemUIOverlayStyle(getSystemUiOverlayStyle());
                                              Get.offAllNamed(RouterName.mainTab);
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                !currentisDarkModeOn ? AppImages.radioSelected : AppImages.radioUnselected,
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("Light Theme",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: Appfonts.family1Medium,
                                                    color: AppColors().settingItemText,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (!currentisDarkModeOn) {
                                              isThemeChange = true;
                                              await socket.channel?.sink.close(status.normalClosure);
                                              socket.channel = null;
                                              await socketIO.socketForTrade?.disconnect();
                                              socketIO.socketForTrade?.dispose();
                                              arrSymbolNames.clear();
                                              Get.changeTheme(ThemeData.dark());
                                              currentisDarkModeOn = true;
                                              controller.localStorage.write(localStorageKeys.isDarkMode, true);
                                              SystemChrome.setSystemUIOverlayStyle(getSystemUiOverlayStyle());
                                              Get.offAllNamed(RouterName.mainTab);
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                currentisDarkModeOn ? AppImages.radioSelected : AppImages.radioUnselected,
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("Dark Theme",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: Appfonts.family1Medium,
                                                    color: AppColors().settingItemText,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            controller.isDetailSciptOn = !controller.isDetailSciptOn;
                                            await controller.localStorage.write(localStorageKeys.isDetailSciptOn, controller.isDetailSciptOn);
                                            Get.find<HomeController>().refreshSciptLayout();
                                            controller.update();
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                controller.isDetailSciptOn ? AppImages.radioSelected : AppImages.radioUnselected,
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("Meta Theme",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: Appfonts.family1Medium,
                                                    color: AppColors().settingItemText,
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  child: Container(
                                    height: 1,
                                    width: 100.w,
                                    color: AppColors().grayLightLine.withOpacity(currentisDarkModeOn ? 0.25 : 1),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 95.w,
                      child: CustomButton(
                        isEnabled: true,
                        shimmerColor: AppColors().whiteColor,
                        title: "Logout",
                        textSize: 16,
                        onPress: () async {
                          showPermissionDialog(
                              message: "Are you sure you want to logout?",
                              acceptButtonTitle: "Yes",
                              rejectButtonTitle: "No",
                              yesClick: () async {
                                isLogoutRunning = true;
                                await service.logoutCall();

                                arrSymbolNames.clear();
                                await socket.channel?.sink.close(status.normalClosure);
                                try {
                                  socket.channel = null;
                                  socketIO.socketForTrade?.emit('unsubscribe', userData!.userName);
                                  socketIO.socketForTrade?.disconnect();
                                  socketIO.socketForTrade?.dispose();
                                } catch (e) {
                                  print(e);
                                }
                                CancelToken().cancel();

                                controller.localStorage.erase();
                                userToken = null;

                                if (profileTimer != null) {
                                  profileTimer!.cancel();
                                  profileTimer = null;
                                }
                                Get.changeTheme(ThemeData.light());
                                currentisDarkModeOn = false;
                                controller.localStorage.write(localStorageKeys.isDarkMode, false);
                                userData = null;
                                SystemChrome.setSystemUIOverlayStyle(getSystemUiOverlayStyle());
                                Get.offAllNamed(RouterName.signInScreen);
                              },
                              noclick: () {
                                Get.back();
                              });
                        },
                        bgColor: AppColors().redColor,
                        isFilled: true,
                        textColor: AppColors().whiteColor,
                        isTextCenter: true,
                        isLoading: false,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 92.5.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors().footerColor,
                        boxShadow: currentisDarkModeOn
                            ? []
                            : [
                                BoxShadow(
                                  color: AppColors().fontColor.withOpacity(0.12),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2), // changes position of shadow
                                ),
                              ]),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userData!.name ?? "",
                                style: TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
                            Text(userData!.userName ?? "",
                                style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(color: AppColors().blueColor.withOpacity(0.1), borderRadius: BorderRadius.circular(25)),
                          child: Center(
                            child: Text(
                                userData!.role == UserRollList.master
                                    ? "M"
                                    : userData!.role == UserRollList.user
                                        ? "C"
                                        : userData!.role == UserRollList.superAdmin
                                            ? "SA"
                                            : "A",
                                style: TextStyle(fontSize: 20, fontFamily: Appfonts.family1SemiBold, color: AppColors().blueColor)),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     if (currentisDarkModeOn) {
                        //       Get.changeTheme(ThemeData.light());
                        //       currentisDarkModeOn = false;
                        //       controller.localStorage.write(localStorageKeys.isDarkMode, false);
                        //     } else {
                        //       Get.changeTheme(ThemeData.dark());
                        //       currentisDarkModeOn = true;
                        //       controller.localStorage.write(localStorageKeys.isDarkMode, true);
                        //     }
                        //     SystemChrome.setSystemUIOverlayStyle(getSystemUiOverlayStyle());
                        //     Get.offAllNamed(RouterName.mainTab);
                        //   },
                        //   child: Image.asset(
                        //     AppImages.moonIcon,
                        //     width: 50,
                        //     height: 50,
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 5.w,
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(title: 'Example share', text: 'Example share text', linkUrl: 'www.google.com', chooserTitle: 'Example Chooser Title');
  }
}
