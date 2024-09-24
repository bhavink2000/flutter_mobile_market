import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../constant/color.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/myTradeListModelClass.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../../modelClass/tradeLogsModelClass.dart';
import '../../../BaseViewController/baseController.dart';
import '../../../../modelClass/constantModelClass.dart';

class TradeLogControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TradeLogController());
  }
}

class TradeLogController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  bool isFilterOpen = true;
  RxString fromDateStr = "Start Date".obs;
  RxString endDateStr = "End Date".obs;
  int selectedOrderIndex = -1;
  DateTime? fromDate;
  DateTime? toDate;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  ScrollController listcontroller = ScrollController();
  List<TradeLogData> arrTrade = [];
  TradeData? selectedTrade;
  bool isLocalDataLoading = true;
  bool isApiCallRunning = false;
  bool isResetCall = false;
  bool isSuccessSelected = true;
  int totalSuccessRecord = 0;
  int totalPendingRecord = 0;
  FocusNode viewFocus = FocusNode();
  FocusNode clearFocus = FocusNode();
  int pageNumber = 1;
  int totalPage = 0;
  bool isPagingApiCall = false;
  int currentPage = 1;
  List<ExchangeData> arrExchangeList = [];

  RxList<GlobalSymbolData> arrMainScript = RxList<GlobalSymbolData>();
  Rx<ExchangeData> selectExchangedropdownValue = ExchangeData().obs;
  Rx<GlobalSymbolData> selectedScriptDropDownValue = GlobalSymbolData().obs;
  Rx<Type> selectedOrderType = Type().obs;
  List<UserData> arrUserDataDropDown = [];
  final TextEditingController textEditingController = TextEditingController();
  FocusNode textEditingFocus = FocusNode();
  Rx<UserData> selectUserDropdownValue = UserData().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getExchangeList();
    getUserList();
    getTradeList();
  }

  getUserList() async {
    // arrUserDataDropDown = constantValues!.userFilterType!;
    var response = await service.getMyUserListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserDataDropDown = response.data ?? [];
      }
    }
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

  getTradeList({bool isFromClear = false}) async {
    arrTrade.clear();
    pageNumber = 1;

    isLocalDataLoading = true;
    if (isFromClear) {
      isResetCall = true;
    } else {
      isApiCallRunning = true;
    }

    String strFromDate = "";
    String strToDate = "";

    update();
    if (fromDateStr.value != "Start Date") {
      strFromDate = DateFormat('yyyy-MM-dd').format(fromDate!);
    }
    if (endDateStr.value != "End Date") {
      strToDate = DateFormat('yyyy-MM-dd').format(toDate!);
    }

    if (isPagingApiCall) {
      return;
    }
    isPagingApiCall = true;
    update();
    var response = await service.tradeLogsListCall(
      pageNumber,
      search: textEditingController.text.trim(),
      userId: selectUserDropdownValue.value.userId ?? "",
      symbolId: selectedScriptDropDownValue.value.symbolId ?? "",
      exchangeId: selectExchangedropdownValue.value.exchangeId ?? "",
      startDate: strFromDate,
      endDate: strToDate,
    );

    arrTrade.addAll(response!.data!);
    isApiCallRunning = false;
    isPagingApiCall = false;
    isResetCall = false;
    totalPage = response.meta!.totalPage!;
    if (totalPage >= currentPage) {
      currentPage = currentPage + 1;
    }
    update();
  }

  Color getPriceColor(String type, double currentPrice, double tradePrice) {
    switch (type) {
      case "buy":
        {
          if (currentPrice > tradePrice) {
            return AppColors().blueColor;
          } else if (currentPrice < tradePrice) {
            return AppColors().redColor;
          } else {
            return AppColors().fontColor;
          }
        }
      case "sell":
        {
          if (currentPrice < tradePrice) {
            return AppColors().blueColor;
          } else if (currentPrice > tradePrice) {
            return AppColors().redColor;
          } else {
            return AppColors().fontColor;
          }
        }

      default:
        {
          return AppColors().DarkText;
        }
    }
  }

  num getNetPrice(String isFromBuy, num tradePrice, num brokerage) {
    if (isFromBuy == "buy") {
      return tradePrice + brokerage;
    } else {
      return tradePrice - brokerage;
    }
  }

  Color getProfitLossColor(String isFromBuy, num netPrice, num currentPrice) {
    if (isFromBuy == "buy") {
      if (netPrice > currentPrice) {
        return AppColors().blueColor;
      } else {
        return AppColors().redColor;
      }
    } else {
      if (netPrice > currentPrice) {
        return AppColors().redColor;
      } else {
        return AppColors().blueColor;
      }
    }
  }
}
