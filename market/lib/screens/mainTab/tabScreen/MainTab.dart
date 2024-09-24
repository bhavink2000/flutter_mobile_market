import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/screens/mainTab/homeTab/homeController.dart';
import 'package:market/screens/mainTab/positionTab/positionController.dart';
import '../../../constant/assets.dart';
import '../../../constant/color.dart';

import '../../../constant/const_string.dart';
import '../../../constant/utilities.dart';
import '../../../main.dart';
import '../../BaseViewController/baseController.dart';
import 'MainTabController.dart';

final iconList = <String>[
  AppImages.tab2,
  AppImages.tab2,
  AppImages.tab3,
  AppImages.tab4,
];

final titleList = <String>[
  "Trade",
  "Order",
  "Position",
  "Profile",
];

class MainTab extends BaseView<MainTabController> {
  const MainTab({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return PopScope(
      canPop: Platform.isIOS,
      onPopInvoked: (didPop) {
        if (Platform.isAndroid) {
          showPermissionDialog(
              message: "Are you sure you want to close the app?",
              acceptButtonTitle: "Yes",
              rejectButtonTitle: "No",
              yesClick: () {
                SystemNavigator.pop();
                Future.delayed(Duration(milliseconds: 300), () {
                  exit(0);
                });
              },
              noclick: () {
                Get.back();
              });
        }
      },
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: AppColors().marketWatchBgColor,
        // drawer: const DrawerScreen(),
        body: IndexedStack(
          index: selectedIndex,
          children: controller.widgetOptions,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors().blueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0), // Set the border radius to make it round
          ),
          child: Image.asset(
            AppImages.tab1,
            width: 30,
            color: Colors.white,
            height: 30,
          ),
          onPressed: () {
            if (Get.find<HomeController>().isPlayerOpen.value) {
              Get.find<HomeController>().playerController!.playVideo();
            }

            selectedIndex = 4;
            controller.update();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? AppColors().blueColor : AppColors().lightOnlyText;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconList[index],
                  width: 20,
                  height: 20,
                  color: selectedIndex == index ? AppColors().blueColor : AppColors().fontColor,
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    titleList[index],
                    maxLines: 1,
                    style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: color),
                  ),
                )
              ],
            );
          },
          backgroundColor: AppColors().footerColor,
          activeIndex: selectedIndex,
          splashColor: AppColors().blueColor.withOpacity(0.1),
          notchAndCornersAnimation: null,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) {
            selectedIndex = index;
            print(index);
            Get.find<HomeController>().playerController!.pauseVideo();
            if (index == 2) {
              if (userData!.role == UserRollList.user) {
                var positionVC = Get.find<positionController>();
                positionVC.currentPage = 1;
                positionVC.getPositionList("", isFromRefresh: true);
              }
            }
            controller.update();
          },
          hideAnimationController: null,
          shadow: BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 12,
            spreadRadius: 0.5,
            color: AppColors().DarkText.withOpacity(0.5),
          ),
        ),
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //     boxShadow: <BoxShadow>[
        //       BoxShadow(
        //         color: Colors.black.withOpacity(0.2),
        //         blurRadius: 10,
        //       ),
        //     ],
        //   ),
        //   height: 11.5.h,
        //   child: Theme(
        //     data: ThemeData(
        //       splashColor: Colors.transparent,
        //       highlightColor: Colors.transparent,
        //     ),
        //     child: BottomNavigationBar(
        //       type: BottomNavigationBarType.fixed,
        //       showSelectedLabels: true,
        //       showUnselectedLabels: true,
        //       selectedLabelStyle: const TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, height: 1.9),
        //       unselectedLabelStyle: const TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, height: 1.9),
        //       unselectedItemColor: AppColors().DarkText,
        //       selectedItemColor: AppColors().blueColor,
        //       items: <BottomNavigationBarItem>[
        //         BottomNavigationBarItem(
        //           icon: Image.asset(
        //             AppImages.tab1,
        //             width: 28,
        //             height: 28,
        //             color: AppColors().DarkText,
        //           ),
        //           activeIcon: Image.asset(
        //             AppImages.tab1Selected,
        //             color: AppColors().blueColor,
        //             width: 28,
        //             height: 28,
        //           ),
        //           label: 'Watch List',
        //         ),
        //         BottomNavigationBarItem(
        //           icon: Image.asset(
        //             AppImages.tab2,
        //             width: 28,
        //             height: 28,
        //             color: AppColors().DarkText,
        //           ),
        //           activeIcon: Image.asset(
        //             AppImages.tab2Selected,
        //             color: AppColors().blueColor,
        //             width: 28,
        //             height: 28,
        //           ),
        //           label: 'Trade',
        //         ),
        //         BottomNavigationBarItem(
        //           icon: Image.asset(
        //             AppImages.tab3,
        //             width: 28,
        //             height: 28,
        //             color: AppColors().DarkText,
        //           ),
        //           activeIcon: Image.asset(
        //             AppImages.tab3Selected,
        //             color: AppColors().blueColor,
        //             width: 28,
        //             height: 28,
        //           ),
        //           label: 'Position',
        //         ),
        //         BottomNavigationBarItem(
        //           icon: Image.asset(
        //             AppImages.tab4,
        //             width: 28,
        //             height: 28,
        //             color: AppColors().DarkText,
        //           ),
        //           activeIcon: Image.asset(
        //             AppImages.tab4Selected,
        //             color: AppColors().blueColor,
        //             width: 28,
        //             height: 28,
        //           ),
        //           label: 'Profile',
        //         ),
        //       ],
        //       // unselectedItemColor: Get.isDarkMode ? AppColors().darkGrayThemeColor : Colors.white,
        //       currentIndex: controller.selectedIndex,
        //       onTap: controller.onItemTapped,
        //       backgroundColor: AppColors().footerColor,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  // This widget is the root of your application.
}
