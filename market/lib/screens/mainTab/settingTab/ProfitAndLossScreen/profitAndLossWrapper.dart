import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/navigation/routename.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/commonWidgets.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../BaseViewController/baseController.dart';
import 'profitAndLossController.dart';
import 'userProfitLossWrapper.dart';

class ProfitAndLossScreen extends BaseView<ProfitAndLossController> {
  const ProfitAndLossScreen({Key? key}) : super(key: key);

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
          headerTitle: "Profit & Loss",
          backGroundColor: AppColors().headerBgColor,
        ),
        body: mainContent(context));
  }

  // Widget filterContent(BuildContext context) {
  //   return FocusTraversalGroup(
  //     policy: WidgetOrderTraversalPolicy(),
  //     child: Visibility(
  //       visible: controller.isFilterOpen,
  //       child: AnimatedContainer(
  //         margin: EdgeInsets.only(bottom: 2.h),
  //         decoration: BoxDecoration(
  //             border: Border(
  //           bottom: BorderSide(color: AppColors().whiteColor, width: 1),
  //         )),
  //         width: controller.isFilterOpen ? 270 : 0,
  //         duration: Duration(milliseconds: 100),
  //         child: Offstage(
  //           offstage: !controller.isFilterOpen,
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 width: 35,
  //               ),
  //               Container(
  //                 height: 35,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Spacer(),
  //                     Container(
  //                       child: Text("Filter",
  //                           style: TextStyle(
  //                             fontSize: 14,
  //                             fontFamily: CustomFonts.family1SemiBold,
  //                             color: AppColors().DarkText,
  //                           )),
  //                     ),
  //                     Spacer(),
  //                     GestureDetector(
  //                       onTap: () {
  //                         controller.isFilterOpen = false;
  //                         controller.update();
  //                       },
  //                       child: Container(
  //                         padding: EdgeInsets.all(9),
  //                         width: 30,
  //                         height: 30,
  //                         color: Colors.transparent,
  //                         child: Image.asset(
  //                           AppImages.closeIcon,
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: 10,
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               Expanded(
  //                   child: Container(
  //                 color: AppColors().slideGrayBG,
  //                 child: Column(
  //                   children: [
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Container(
  //                       height: 4.h,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Spacer(),
  //                           Container(
  //                             child: Text("Username:",
  //                                 style: TextStyle(
  //                                   fontSize: 12,
  //                                   fontFamily: CustomFonts.family1Regular,
  //                                   color: AppColors().fontColor,
  //                                 )),
  //                           ),
  //                           SizedBox(
  //                             width: 10,
  //                           ),
  //                           userListDropDown(controller.selectedUser, width: 150),
  //                           SizedBox(
  //                             width: 30,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         SizedBox(
  //                           width: 80,
  //                           height: 35,
  //                           child: CustomButton(
  //                             isEnabled: true,
  //                             shimmerColor: AppColors().whiteColor,
  //                             title: "Apply",
  //                             textSize: 14,
  //                             onPress: () {
  //                               controller.profitLossList();
  //                             },
  //                             bgColor: AppColors().blueColor,
  //                             isFilled: true,
  //                             textColor: AppColors().whiteColor,
  //                             isTextCenter: true,
  //                             isLoading: false,
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: 1.w,
  //                         ),
  //                         SizedBox(
  //                           width: 80,
  //                           height: 35,
  //                           child: CustomButton(
  //                             isEnabled: true,
  //                             shimmerColor: AppColors().whiteColor,
  //                             title: "Clear",
  //                             textSize: 14,
  //                             prefixWidth: 0,
  //                             onPress: () {
  //                               controller.selectedUser.value = UserData();
  //                               controller.profitLossList();
  //                             },
  //                             bgColor: AppColors().whiteColor,
  //                             isFilled: true,
  //                             borderColor: AppColors().blueColor,
  //                             textColor: AppColors().blueColor,
  //                             isTextCenter: true,
  //                             isLoading: false,
  //                           ),
  //                         ),
  //                         // SizedBox(width: 5.w,),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ))
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  filterPopupDialog({String? message, String? subMessage, Function? CancelClick, Function? DeleteClick}) {
    showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
            titlePadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: AppColors().bgColor,
            surfaceTintColor: AppColors().bgColor,
            insetPadding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 32.h,
            ),
            content: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              userListDropDown(),
              buttonsView(),
            ])));
  }

  Widget mainContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              width: 1100,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("Our : ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: Appfonts.family1SemiBold,
                              color: AppColors().DarkText,
                            )),
                        Text(controller.totalPL.toStringAsFixed(2),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: Appfonts.family1SemiBold,
                              color: AppColors().DarkText,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("Net P/L : ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: Appfonts.family1SemiBold,
                              color: AppColors().DarkText,
                            )),
                        Text(controller.totalPlWithBrk.toStringAsFixed(2),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: Appfonts.family1SemiBold,
                              color: AppColors().DarkText,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 3.h,
                    color: AppColors().whiteColor,
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
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        clipBehavior: Clip.hardEdge,
                        itemCount: controller.arrPlList.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return profitAndLossContent(context, index);
                        }),
                  ),
                  Container(
                    height: 2.h,
                    color: AppColors().headerBgColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget profitAndLossContent(BuildContext context, int index) {
    // var scriptValue = controller.arrUserOderList[index];
    if (controller.isApiCallRunning) {
      return Container(
        margin: EdgeInsets.only(bottom: 3.h),
        child: Shimmer.fromColors(
            child: Container(
              height: 3.h,
              color: Colors.white,
            ),
            baseColor: AppColors().whiteColor,
            highlightColor: AppColors().grayBg),
      );
    } else {
      return GestureDetector(
        onTap: () {
          controller.update();
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (controller.arrPlList[index].role! == UserRollList.user)
                valueBox(
                  "",
                  60,
                  index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                  AppColors().DarkText,
                  index,
                ),
              if (controller.arrPlList[index].role! != UserRollList.user)
                valueBox(
                  "",
                  isImage: true,
                  60,
                  strImage: AppImages.viewIcon,
                  index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                  AppColors().DarkText,
                  index,
                  onClickImage: () {
                    Get.to(() => UserProfitAndLossScreen(), arguments: controller.arrPlList[index].userId!, preventDuplicates: false);
                  },
                ),
              valueBox(
                controller.arrPlList[index].userName ?? "",
                100,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                controller.arrPlList[index].role == UserRollList.user ? controller.arrPlList[index].brkSharingDownLine!.toString() : controller.arrPlList[index].brkSharing!.toString(),
                100,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                controller.arrPlList[index].role == UserRollList.user ? controller.arrPlList[index].profitLoss!.toStringAsFixed(2) : controller.arrPlList[index].childUserProfitLossTotal!.toStringAsFixed(2),
                160,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                controller.arrPlList[index].role == UserRollList.master ? controller.arrPlList[index].childUserBrokerageTotal!.toStringAsFixed(2) : controller.arrPlList[index].brokerageTotal!.toStringAsFixed(2),
                120,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                controller.arrPlList[index].totalProfitLossValue.toStringAsFixed(2),
                120,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                controller.arrPlList[index].plWithBrk.toStringAsFixed(2),
                120,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              // valueBox(
              //   controller.arrPlList[index].plSharePer.toStringAsFixed(2),
              //   120,
              //   index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              //   controller.arrPlList[index].plSharePer < 0 ? AppColors().redColor : AppColors().DarkText,
              //   index,
              // ),
              // valueBox(
              //   controller.arrPlList[index].parentBrokerageTotal!.toStringAsFixed(2),
              //   100,
              //   index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              //   AppColors().DarkText,
              //   index,
              // ),
              valueBox(
                controller.arrPlList[index].netPL.toStringAsFixed(2),
                100,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                controller.arrPlList[index].netPL > 0
                    ? AppColors().greenColor
                    : controller.arrPlList[index].netPL < 0.0
                        ? AppColors().redColor
                        : AppColors().DarkText,
                index,
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget listTitleContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleBox("VIEW", width: 60),

        titleBox("USERNAME", width: 100),
        titleBox("SHARING %", width: 100),
        titleBox("RELEASE P/L", width: 160),
        titleBox("BRK", width: 120),
        titleBox("M2M", width: 120),
        titleBox("NET P/L", width: 120),
        // titleBox("P/L SHARE %", width: 120),
        // titleBox("BRK", width: 100),
        titleBox("OUR", width: 100),
      ],
    );
  }

  Widget userListDropDown() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      height: 6.5.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().grayLightLine,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3)),
      // color: AppColors().whiteColor,
      padding: EdgeInsets.only(right: 10),
      child: Obx(() {
        return Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<UserData>(
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
                'Select User',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: Appfonts.family1Medium,
                  color: AppColors().DarkText,
                ),
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
                    .toList();
              },
              value: controller.selectedUser.value.userId != null ? controller.selectedUser.value : null,
              onChanged: (UserData? value) {
                controller.selectedUser.value = value!;
                controller.update();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                // height: 54,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 54,
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 300),
            ),
          ),
        );
      }),
    );
  }

  Widget buttonsView() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 35.w,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Reset",
              textSize: 16,
              onPress: () {
                controller.selectedUser.value = UserData();
                ();
                Get.back();
                controller.update();
                controller.getProfitLossList("");
                // controller.getAccountSummaryNewList("", isFromClear: true, isFromfilter: true);
              },
              bgColor: AppColors().grayLightLine,
              isFilled: true,
              textColor: AppColors().DarkText,
              isTextCenter: true,
              isLoading: controller.isResetCall,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          SizedBox(
            width: 35.w,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Done",
              textSize: 16,
              // buttonWidth: 36.w,
              onPress: () {
                Get.back();
                controller.getProfitLossList("");
                // controller.getAccountSummaryNewList("", isFromfilter: true);
              },
              bgColor: AppColors().blueColor,
              isFilled: true,
              textColor: AppColors().whiteColor,
              isTextCenter: true,
              isLoading: controller.isApiCallRunning,
            ),
          ),
          // SizedBox(width: 5.w,),
        ],
      ),
    );
  }
}
