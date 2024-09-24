import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/screens/mainTab/settingTab/MarketTimingScreen/MarketTimingScreenController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../../../../../constant/color.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/font_family.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../BaseViewController/baseController.dart';
import '../../tabScreen/MainTabController.dart';

class MarketTimingScreen extends BaseView<MarketTimingController> {
  const MarketTimingScreen({Key? key}) : super(key: key);

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
          headerTitle: "Market Timings",
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
      backgroundColor: AppColors().bgColor,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: AppColors().bgColor,
        ),
        child: Column(
          children: [
            exchangeDropDownView(),
            searchBtnView(),
            if (controller.arrTiming.isNotEmpty) customCalender(),
            if (controller.isDateSelected == true)
              Expanded(
                child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    clipBehavior: Clip.hardEdge,
                    itemCount: controller.arrTiming.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return dateTimingView(context, index);
                    }),
              ),
          ],
        ),
      ),
    );
  }

  Widget exchangeDropDownView() {
    return Container(
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
            child: DropdownButton2<ExchangeData>(
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
                'Select Exchange',
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
              value: controller.selectedExchangedropdownValue!.value!.exchangeId != null ? controller.selectedExchangedropdownValue!.value : null,
              onChanged: (ExchangeData? value) {
                // setState(() {
                controller.selectedExchangedropdownValue!.value = value!;
                controller.getHolidayList();
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
            if (controller.selectedExchangedropdownValue!.value!.exchangeId != null) {
              // controller.isSearchPressed = true.obs;
              controller.getTiming();
            } else {
              showWarningToast("Please Select Exchange", controller.globalContext!);
            }
          },
          bgColor: AppColors().blueColor,
          isFilled: true,
          textColor: AppColors().whiteColor,
          isTextCenter: true,
          isLoading: controller.isApiCallRunning,
        ),
      ),
    );
  }

  Widget customCalenderHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            controller.currentMonth,
            style: TextStyle(
              fontSize: 16,
              fontFamily: Appfonts.family1SemiBold,
              color: AppColors().DarkText,
            ),
          )),
          GestureDetector(
            onTap: () {
              controller.targetDateTime = DateTime(controller.targetDateTime.year, controller.targetDateTime.month - 1);
              controller.currentMonth = DateFormat.yMMM().format(controller.targetDateTime);
              controller.update();
            },
            child: Image.asset(
              AppImages.calenderarrowleft,
              height: 16,
              width: 10,
              // color: AppColors().blueColor,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: () {
              controller.targetDateTime = DateTime(controller.targetDateTime.year, controller.targetDateTime.month + 1);
              controller.currentMonth = DateFormat.yMMM().format(controller.targetDateTime);
              controller.update();
            },
            child: Image.asset(
              AppImages.calenderarrowright,
              height: 16,
              width: 10,
              // color: AppColors().blueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget customCalender() {
    var valueObj = controller.arrTiming.first;
    return Column(
      children: [
        Container(
          // height: 515,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors().footerColor, boxShadow: [
            BoxShadow(
              color: AppColors().fontColor.withOpacity(0.1),
              offset: Offset.zero,
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ]),
          margin: EdgeInsets.only(left: 3.9.w, top: 2.h, right: 3.9.w),
          child: Column(
            children: [
              customCalenderHeader(),
              CalendarCarousel<Event>(
                onDayPressed: (date, events) {
                  // if (valueObj.weekOff!.contains(date.weekday)) {
                  //   controller.currentDate2 = date;
                  //   events.forEach((event) => print(event.title));
                  //   controller.isDateSelected = true.obs;
                  //   controller.update();
                  // }
                  controller.currentDate2 = date;
                  events.forEach((event) => print(event.title));
                  controller.isDateSelected = true.obs;
                  controller.update();
                },
                showOnlyCurrentMonthDate: false,
                height: 40.h,
                selectedDateTime: controller.currentDate2,
                targetDateTime: controller.targetDateTime,
                customGridViewPhysics: NeverScrollableScrollPhysics(),
                showHeader: false,
                selectedDayButtonColor: AppColors().blueColor,
                todayButtonColor: AppColors().lightOnlyText,
                customDayBuilder: (isSelectable, index, isSelectedDay, isToday, isPrevMonthDay, textStyle, isNextMonthDay, isThisMonthDay, day) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: Appfonts.family1SemiBold,
                          color: isPrevMonthDay || isNextMonthDay
                              ? AppColors().lightOnlyText
                              : isSelectedDay || isToday
                                  ? AppColors().whiteColor
                                  : valueObj.weekOff!.contains(day.weekday)
                                      ? controller.arrHoliday.indexWhere((element) => element.startDate!.day == day.day && element.startDate!.month == day.month && element.startDate!.year == day.year) == -1
                                          ? Colors.green
                                          : AppColors().redColor
                                      : AppColors().redColor,
                        ),
                      ),
                    ),
                  );
                },
                customWeekDayBuilder: (weekday, weekdayName) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Text(
                    weekdayName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: Appfonts.family1SemiBold,
                      color: AppColors().lightText,
                    ),
                  ),
                ),
                minSelectedDate: controller.currentDate.subtract(Duration(days: 360)),
                maxSelectedDate: controller.currentDate.add(Duration(days: 360)),
                onCalendarChanged: (DateTime date) {
                  controller.targetDateTime = date;
                  controller.currentMonth = DateFormat.yMMM().format(controller.targetDateTime);
                  controller.update();
                  // dateTimingView();
                },
              ),
            ],
          ),
        ),
        if (controller.isDateSelected == false)
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            child: Text(
              '  No Selected Date',
              maxLines: 1,
              style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1Medium, color: AppColors().lightText, overflow: TextOverflow.ellipsis),
            ),
          ),
      ],
    );
  }

  Widget dateTimingView(BuildContext context, int index) {
    var valueObj = controller.arrTiming[index];
    var valueObj1 = controller.arrTiming.first;
    var isWeekEnd = !valueObj1.weekOff!.contains(controller.currentDate2.weekday);
    print(controller.currentDate2);
    var isHoliday = false;
    var holiday = "";

    for (var element in controller.arrHoliday) {
      print(element.startDate);
      if (element.startDate == controller.currentDate2) {
        print("Match");
        isHoliday = true;
        holiday = element.text ?? "";
      }
    }
    if (isHoliday == false && isWeekEnd) {
      isHoliday = true;
      holiday = "WEEKEND";
    }
    return Container(
      // height: 6.h,

      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                DateFormat('EEE').format(controller.currentDate2).toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: Appfonts.family1Medium,
                  color: isHoliday ? AppColors().redColor : AppColors().blueColor,
                ),
              ),
              Container(
                width: 48,
                decoration: BoxDecoration(color: isHoliday ? AppColors().redColor : AppColors().blueColor, borderRadius: BorderRadius.circular(13.5)),
                child: Center(
                  child: Text(
                    controller.currentDate2.day.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: Appfonts.family1Medium,
                      color: AppColors().whiteColor,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              height: 5.7.h,
              decoration: BoxDecoration(color: isHoliday ? AppColors().redColor : AppColors().blueColor, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  isHoliday ? holiday : valueObj.startTime! + " - " + valueObj.endTime!,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: Appfonts.family1Medium,
                    color: AppColors().whiteColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
