import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

import '../../../../../../main.dart';
import '../../../../../../modelClass/tradeMarginListModelClass.dart';

class TradeMarginControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TradeMarginController());
  }
}

class TradeMarginController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  Rx<ExchangeData> selectExchangedropdownValue = ExchangeData().obs;
  FocusNode viewFocus = FocusNode();
  FocusNode saveFocus = FocusNode();
  FocusNode clearFocus = FocusNode();
  bool isApiCallRunning = false;
  bool isFirstCallRunning = false;
  bool isClearApiCallRunning = false;
  bool isPagingApiCall = false;
  int totalPage = 0;
  int currentPage = 1;
  int totalCount = 0;
  String userId = "";

  List<TradeMarginData> arrTradeMargin = [];

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      userId = Get.arguments["userId"];
    } else {
      userId = userData!.userId!;
    }
    // tradeMarginList(isFromFilter: true);
  }

  tradeMarginList({bool isFromFilter = false, bool isFromClear = false}) async {
    if (isFirstCallRunning == false) {
      if (isFromFilter) {
        arrTradeMargin.clear();
        currentPage = 1;
        if (isFromClear) {
          isClearApiCallRunning = true;
        } else {
          isApiCallRunning = true;
        }
      }
      if (isPagingApiCall) {
        return;
      }
      isPagingApiCall = true;
      update();
    }

    var response = await service.tradeMarginListCall(page: currentPage, exchangeId: selectExchangedropdownValue.value.exchangeId ?? "", text: searchController.text, userId: userId);
    isFirstCallRunning = false;
    arrTradeMargin.addAll(response!.data!);
    isApiCallRunning = false;
    isPagingApiCall = false;
    isClearApiCallRunning = false;
    totalCount = response.meta!.totalCount!;
    totalPage = response.meta!.totalPage!;
    if (totalPage >= currentPage) {
      currentPage = currentPage + 1;
    }
    update();
  }
}
