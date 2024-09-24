import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../../modelClass/positionTrackListModelClass.dart';
import '../../../BaseViewController/baseController.dart';

class UserScriptPositionTrackControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserScriptPositionTrackController());
  }
}

class UserScriptPositionTrackController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  RxString fromDate = "Start Date".obs;
  RxString endDate = "End Date".obs;

  Rx<UserData> selectedUser = UserData().obs;
  FocusNode viewFocus = FocusNode();
  FocusNode clearFocus = FocusNode();
  ScrollController mainScroll = ScrollController();
  List<PositionTrackData> arrTracking = [];
  bool isApiCallRunning = false;
  bool isFilterApiCallRunning = false;
  bool isClearApiCallRunning = false;
  bool isPagingApiCall = false;
  int totalPage = 0;
  int currentPage = 1;
  int totalCount = 0;
  Rx<ExchangeData> selectExchangedropdownValue = ExchangeData().obs;
  Rx<GlobalSymbolData> selectedScriptDropDownValue = GlobalSymbolData().obs;
  RxList<GlobalSymbolData> arrMainScript = RxList<GlobalSymbolData>();
  List<ExchangeData> arrExchangeList = [];

  bool isResetCall = false;

  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();
    trackList();
    getExchangeList();
  }

  getExchangeList() async {
    var response = await service.getExchangeListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrExchangeList = response.exchangeData ?? [];
      }
    }
  }

  getScriptList() async {
    var response = await service.allSymbolListCall(1, "", selectExchangedropdownValue.value.exchangeId ?? "");
    arrMainScript.value = response!.data ?? [];

    update();
  }

  trackList({bool isFromFilter = false, bool isFromClear = false}) async {
    if (isPagingApiCall) {
      return;
    }
    if (isFromFilter) {
      isFilterApiCallRunning = true;
      arrTracking.clear();
    }
    if (isFromClear) {
      isClearApiCallRunning = true;
      arrTracking.clear();
    }
    isPagingApiCall = true;
    update();
    var response = await service.positionTrackingListCall(
      page: currentPage,
      userId: selectedUser.value.userId ?? "",
      symbolId: selectedScriptDropDownValue.value.symbolId ?? "",
      exchangeId: selectExchangedropdownValue.value.exchangeId ?? "",
      endDate: endDate.value == "End Date" ? "" : endDate.value,
    );

    arrTracking.addAll(response!.data!);
    isApiCallRunning = false;
    isPagingApiCall = false;

    isFilterApiCallRunning = false;
    isClearApiCallRunning = false;
    totalCount = response.meta!.totalCount!;
    totalPage = response.meta!.totalPage!;
    if (totalPage >= currentPage) {
      currentPage = currentPage + 1;
    }
    update();
  }
}
