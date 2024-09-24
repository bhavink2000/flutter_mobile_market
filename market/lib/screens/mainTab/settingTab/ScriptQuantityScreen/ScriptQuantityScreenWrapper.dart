import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/ScriptQuantityScreen/ScriptQuantityScreenController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constant/color.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/font_family.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../../modelClass/groupListModelClass.dart';
import '../../tabScreen/MainTabController.dart';

class ScriptQuantityScreen extends BaseView<ScriptQuantityController> {
  const ScriptQuantityScreen({Key? key}) : super(key: key);

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
          headerTitle: "Script Quantity",
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
            dropDownView(),
            searchBtnView(),
            SelectedView(),
          ],
        ),
      ),
    );
  }

  Widget dropDownView() {
    return Container(
      // width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
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
                        child: DropdownButton2<ExchangeData>(
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
                            'Exchange',
                            maxLines: 1,
                            style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
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
                          value: controller.selectExchangeDropdownValue.value.exchangeId != null ? controller.selectExchangeDropdownValue.value : null,
                          onChanged: (ExchangeData? value) {
                            // setState(() {
                            controller.selectExchangeDropdownValue.value = value!;
                            controller.arrGroupList.clear();
                            controller.selectGroupDropdownValue.value = groupListModelData();
                            controller.update();
                            controller.callforGroupList(controller.selectExchangeDropdownValue.value.exchangeId);
                            controller.update();
                            // });
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
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Container(
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
                        child: DropdownButton2<groupListModelData>(
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
                            'Group',
                            maxLines: 1,
                            style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
                          ),
                          items: controller.arrGroupList
                              .map((groupListModelData item) => DropdownMenuItem<groupListModelData>(
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
                            return controller.arrGroupList
                                .map((groupListModelData item) => DropdownMenuItem<groupListModelData>(
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
                          value: controller.selectGroupDropdownValue.value.groupId != null ? controller.selectGroupDropdownValue.value : null,
                          onChanged: (groupListModelData? value) {
                            // setState(() {
                            controller.selectGroupDropdownValue.value = value!;
                            controller.update();
                            // });
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
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 2.h,
          // ),
          // if (userData!.role != UserRollList.user)
          //   Container(
          //     // width: 96.w,
          //     // height: 40,
          //     decoration: BoxDecoration(
          //         border: Border.all(
          //           color: AppColors().grayLightLine,
          //           width: 1.5,
          //         ),
          //         borderRadius: BorderRadius.circular(3)),
          //     padding: const EdgeInsets.only(right: 15),
          //     child: Obx(() {
          //       return Center(
          //         child: DropdownButtonHideUnderline(
          //           child: DropdownButton2<UserData>(
          //             isExpanded: true,
          //             dropdownStyleData: DropdownStyleData(
          //               maxHeight: 300,
          //               decoration: BoxDecoration(
          //                 color: AppColors().grayBg,
          //               ),
          //             ),
          //             // alignment: AlignmentDirectional.center,
          //             iconStyleData: IconStyleData(
          //                 icon: Image.asset(
          //                   AppImages.arrowDown,
          //                   height: 20,
          //                   width: 20,
          //                   color: AppColors().fontColor,
          //                 ),
          //                 openMenuIcon: AnimatedRotation(
          //                   turns: 0.5,
          //                   duration: const Duration(milliseconds: 400),
          //                   child: Image.asset(
          //                     AppImages.arrowDown,
          //                     width: 20,
          //                     height: 20,
          //                     color: AppColors().fontColor,
          //                   ),
          //                 )),
          //             hint: Text(
          //               'Select User',
          //               maxLines: 1,
          //               style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
          //             ),
          //             items: controller.arrUserDataDropDown
          //                 .map((UserData item) => DropdownMenuItem<UserData>(
          //                       value: item,
          //                       child: Text(
          //                         item.userName ?? "",
          //                         style: TextStyle(
          //                           fontSize: 14,
          //                           fontFamily: Appfonts.family1Medium,
          //                           color: AppColors().DarkText,
          //                         ),
          //                       ),
          //                     ))
          //                 .toList(),
          //             selectedItemBuilder: (context) {
          //               return controller.arrUserDataDropDown
          //                   .map((UserData item) => DropdownMenuItem<UserData>(
          //                         value: item,
          //                         child: Text(
          //                           item.userName ?? "",
          //                           style: TextStyle(
          //                             fontSize: 14,
          //                             fontFamily: Appfonts.family1Medium,
          //                             color: AppColors().DarkText,
          //                           ),
          //                         ),
          //                       ))
          //                   .toList();
          //             },
          //             value: controller.selectUserdropdownValue.value.userId != null ? controller.selectUserdropdownValue.value : null,
          //             onChanged: (UserData? value) {
          //               controller.selectUserdropdownValue.value = value!;
          //               controller.update();
          //             },
          //             buttonStyleData: const ButtonStyleData(
          //               padding: EdgeInsets.symmetric(horizontal: 0),
          //               height: 54,
          //             ),
          //             menuItemStyleData: const MenuItemStyleData(
          //               height: 54,
          //             ),

          //             //This to clear the search value when you close the menu
          //             onMenuStateChange: (isOpen) {
          //               if (!isOpen) {
          //                 controller.searchScriptextEditingController.clear();
          //               }
          //             },
          //           ),
          //         ),
          //       );
          //     }),
          //   ),
        ],
      ),
    );
  }

  Widget searchBtnView() {
    return Center(
      child: SizedBox(
        width: 90.w,
        child: CustomButton(
          isEnabled: true,
          shimmerColor: AppColors().whiteColor,
          title: "Search",
          textSize: 16,
          onPress: () {
            controller.getQuantityList();
          },
          bgColor: AppColors().blueColor,
          isFilled: true,
          textColor: AppColors().whiteColor,
          isTextCenter: true,
          isLoading: false,
        ),
      ),
    );
  }

  Widget SelectedView() {
    return Expanded(
      child: controller.isApiCallRunning
          ? displayIndicator()
          : controller.isApiCallRunning == false && controller.arrData.isEmpty
              ? dataNotFoundView("Data not found")
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: AppColors().grayLightLine,
                            width: 1.5,
                          )),
                          child: Row(
                            children: [
                              Container(
                                width: 85,
                                height: 54,
                                decoration: BoxDecoration(
                                    border: Border(
                                  right: BorderSide(
                                    color: AppColors().grayLightLine,
                                    width: 1.5,
                                  ),
                                )),
                                child: Center(child: Text("Symbol", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                              ),
                              Container(
                                width: 85,
                                height: 54,
                                decoration: BoxDecoration(
                                    border: Border(
                                  right: BorderSide(
                                    color: AppColors().grayLightLine,
                                    width: 1.5,
                                  ),
                                )),
                                child: Center(child: Text("Breakup qty", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                              ),
                              Container(
                                width: 85,
                                height: 54,
                                decoration: BoxDecoration(
                                    border: Border(
                                  right: BorderSide(
                                    color: AppColors().grayLightLine,
                                    width: 1.5,
                                  ),
                                )),
                                child: Center(child: Text("Max qty", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                              ),
                              Container(
                                width: 85,
                                height: 54,
                                decoration: BoxDecoration(
                                    border: Border(
                                  right: BorderSide(
                                    color: AppColors().grayLightLine,
                                    width: 1.5,
                                  ),
                                )),
                                child: Center(child: Text("Breakup Lot", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                              ),
                              SizedBox(
                                width: 85,
                                height: 54,
                                child: Center(child: Text("Max Lot", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 428,
                            child: ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                clipBehavior: Clip.hardEdge,
                                itemCount: controller.arrData.length,
                                controller: controller.listcontroller,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return clientSelectedView(context, index);
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget clientSelectedView(BuildContext context, int index) {
    return Container(
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
        children: [
          Container(
            width: 85,
            height: 36,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(
              child: Text(controller.arrData[index].symbolName ?? "", textAlign: TextAlign.center, maxLines: 1, style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText, overflow: TextOverflow.ellipsis)),
            ),
          ),
          Container(
            width: 85,
            height: 36,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text(controller.arrData[index].breakQuantity.toString(), textAlign: TextAlign.center, maxLines: 1, style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor))),
          ),
          Container(
            width: 85,
            height: 36,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text(controller.arrData[index].quantityMax.toString(), textAlign: TextAlign.center, maxLines: 1, style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().blueColor))),
          ),
          Container(
            width: 85,
            height: 36,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: AppColors().grayLightLine,
                width: 1.5,
              ),
            )),
            child: Center(child: Text(controller.arrData[index].breakUpLot.toString(), textAlign: TextAlign.center, maxLines: 1, style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
          SizedBox(
            width: 85,
            height: 36,
            child: Center(child: Text(controller.arrData[index].lotMax.toString(), textAlign: TextAlign.center, maxLines: 1, style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText))),
          ),
        ],
      ),
    );
  }
}
