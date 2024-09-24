import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constant/color.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/font_family.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../BaseViewController/baseController.dart';
import '../../tabScreen/MainTabController.dart';
import 'filterScriptController.dart';

class FilterScriptScreen extends BaseView<FilterScriptController> {
  const FilterScriptScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            controller.selectedExchange = ExchangeData();
            controller.scriptSearchController.clear();
            controller.passSelectedScripts();
          },
          headerTitle: "Add Script",
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
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            width: 100.w,
            height: 84.h,
            child: Stack(
              children: [
                Positioned(
                  top: 3.h,
                  child: Container(
                    width: 100.w,
                    height: 82.h,
                    decoration: BoxDecoration(color: AppColors().bgColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    child: Container(
                      margin: EdgeInsets.only(top: 5.h),
                      child: controller.isApiCallForScriptRunning
                          ? displayIndicator()
                          : ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              clipBehavior: Clip.hardEdge,
                              itemCount: controller.arrScript.length,
                              controller: controller.listcontroller,

                              // shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return scriptlistContent(context, index);
                              }),
                    ),
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
                              controller: controller.scriptSearchController,
                              focusNode: controller.scriptSearchFocus,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.search,
                              minLines: 1,
                              maxLines: 1,
                              onChanged: (value) {
                                if (controller.scriptSearchController.text.length >= 3) {
                                  controller.getSymbolListByKeyword(value);
                                }
                              },
                              onSubmitted: (value) {
                                controller.getSymbolListByKeyword(value);
                              },
                              style: TextStyle(fontSize: 16.0, color: AppColors().fontColor, fontFamily: Appfonts.family1Medium),
                              decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.w), borderSide: BorderSide.none),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                  hintStyle: TextStyle(color: AppColors().placeholderColor),
                                  hintText: "Search Script"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget scriptlistContent(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        controller.currentSelectedIndex = index;
        if (controller.isAddDeleteApiLoading == false) {
          controller.isAddDeleteApiLoading = true;
          controller.update();
          if (controller.arrSlectedScript.contains(controller.arrScript[index])) {
            controller.arrSlectedScript.remove(controller.arrScript[index]);

            var temp = controller.arrCurrentAvailableSymbol.firstWhereOrNull((value) => value.symbolId == controller.arrScript[index].symbolId);
            if (temp != null) {
              controller.deleteSymbolFromTab(temp.userTabSymbolId!);
            }
          } else {
            controller.arrSlectedScript.add(controller.arrScript[index]);
            controller.addSymbolToTab(controller.arrScript[index].symbolId!);
          }
          controller.update();
        }
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(controller.arrScript[index].symbolTitle ?? "", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().borderColor)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(controller.arrScript[index].exchangeName ?? "", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Regular, color: AppColors().placeholderColor)),
                  ],
                ),
                const Spacer(),
                controller.isAddDeleteApiLoading && controller.currentSelectedIndex == index
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors().blueColor,
                        ))
                    : controller.arrSlectedScript.contains(controller.arrScript[index])
                        ? Icon(
                            Icons.check_box,
                            color: AppColors().blueColor,
                          )
                        : Icon(
                            Icons.check_box_outline_blank,
                            color: AppColors().lightText,
                          )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
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
}
