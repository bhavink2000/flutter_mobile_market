import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/holidayListModelClass.dart';
import '../../../../modelClass/marketTimingModelClass.dart';
import '../../../BaseViewController/baseController.dart';

class MarketTimingControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MarketTimingController());
  }
}

class MarketTimingController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  Rx<ExchangeData?>? selectedExchangedropdownValue = ExchangeData().obs;
  RxBool isSearchPressed = false.obs;
  RxBool isDateSelected = false.obs;
  bool isDarkMode = false;
  String? selectedDate;
  DateTime currentDate = DateTime.now();
  DateTime currentDate2 = DateTime.now();
  String currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime targetDateTime = DateTime.now();
  bool isApiCallRunning = false;
  List<HolidayData> arrHoliday = [];
  List<ExchangeData> arrExchangeList = [];
  List<TimingData> arrTiming = [];
  // MarketTimingModel? timingData;
  @override
  void onInit() async {
    super.onInit();
    getExchangeList();
    update();
  }

  getExchangeList() async {
    var response = await service.getExchangeListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrExchangeList = response.exchangeData ?? [];
        arrExchangeList.removeAt(0);
        update();
      }
    }
  }

  getHolidayList() async {
    var response = await service.holidayListCall(selectedExchangedropdownValue!.value!.exchangeId!);
    isApiCallRunning = false;
    update();
    if (response?.statusCode == 200) {
      arrHoliday = response?.data ?? [];

      update();
    }
  }

  getTiming() async {
    isApiCallRunning = true;
    update();
    currentDate = DateTime.now();
    currentDate2 = DateTime.now();
    var response = await service.getMarketTimingCall(selectedExchangedropdownValue!.value!.exchangeId!);
    isApiCallRunning = false;
    update();
    if (response?.statusCode == 200) {
      arrTiming = response?.data ?? [];
      if (arrTiming.isEmpty) {
        isDateSelected.value = false;
      } else {
        targetDateTime = DateTime.now();
        currentMonth = DateFormat.yMMM().format(targetDateTime);
        isDateSelected.value = true;
        update();
      }
      ;
      update();
    }
  }
}
