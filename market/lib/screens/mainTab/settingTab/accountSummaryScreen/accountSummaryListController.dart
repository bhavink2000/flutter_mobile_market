import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/main.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant/color.dart';
import '../../../../constant/utilities.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../../modelClass/settingAccountSummaryModelClass.dart';
import '../../../../modelClass/tradeDetailModelClass.dart';

class AccountSummaryListControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountSummaryListController());
  }
}

class AccountSummaryListController extends BaseController {
  ScrollController listcontroller = ScrollController();
  List<String> arrCustomDateSelection = [];
  bool NSE = false;
  bool MCX = false;
  bool SGX = false;
  String? fromDate = "";
  String? toDate = "";

  Rx<UserData> selectUserDropdownValue = UserData().obs;
  final TextEditingController textEditingController = TextEditingController();
  FocusNode textEditingFocus = FocusNode();
  final TextEditingController searchTextEditingController = TextEditingController();
  FocusNode searchTextEditingFocus = FocusNode();
  RxString selectStatusdropdownValue = "".obs;
  bool isDarkMode = false;

  List<UserData> arrUserDataDropDown = [];

  List<AccountSummaryData> arrAccountSummaryListData = [];
  String startDate = '';
  String endDate = '';
  bool isLoadingData = false;
  int totalPage = 0;
  int currentPage = 1;
  bool isPagingApiCall = false;
  bool isFromFilter = false;
  TradeDetailData tradeDetail = TradeDetailData();
  bool isApiCall = false;
  var tradeID = "";
  int selectedIndex = -1;
  @override
  void onInit() async {
    super.onInit();
    isLoadingData = true;
    await getAccountSummaryList();
    await getUserList();
    arrCustomDateSelection.addAll(CommonCustomDateSelection().arrCustomDate);
    if (userData!.role == UserRollList.user) {
      selectUserDropdownValue.value = UserData(userId: userData!.userId);
    }
    update();
  }

  getAccountSummaryList({bool isFromFresh = false}) async {
    if (selectStatusdropdownValue.toString().isNotEmpty) {
      if (selectStatusdropdownValue.toString() != 'Custom Period') {
        String thisWeekDateRange = "$selectStatusdropdownValue";
        List<String> dateParts = thisWeekDateRange.split(" to ");
        startDate = dateParts[0].trim().split('Week').last;
        endDate = dateParts[1];
      } else {
        startDate = '';
        endDate = '';
      }
    }
    if (isFromFresh) {
      currentPage = 1;
      isFromFilter = true;
      isLoadingData = true;
    } else {
      if (isPagingApiCall) {
        return;
      }
      isPagingApiCall = true;
    }

    update();
    var response = await service.accountSummary(
      page: currentPage,
      search: searchTextEditingController.text.trim(),
      uId: selectUserDropdownValue.value.userId.toString(),
      type: NSE == true
          ? 'profit_loss'
          : MCX == true
              ? 'brokerage'
              : '',
      sDate: startDate.toString() == '' ? fromDate.toString() : startDate.toString(),
      eDate: endDate.toString() == '' ? toDate.toString() : endDate.toString(),
      sortKey: '',
    );
    isLoadingData = false;

    isFromFilter = false;
    if (response != null) {
      if (response.statusCode == 200) {
        if (isFromFresh) {
          arrAccountSummaryListData.clear();
        }
        arrAccountSummaryListData.addAll(response.data!);
        isPagingApiCall = false;
        totalPage = response.meta!.totalPage!;
        if (totalPage >= currentPage) {
          currentPage = currentPage + 1;
        }
        update();
      }
    }
  }

  getTradeDetail() async {
    isApiCall = true;
    update();
    var response = await service.getTradeDetailCall(tradeID);
    isApiCall = false;
    update();
    if (response?.statusCode == 200) {
      tradeDetail = response!.data!;

      update();
      tradeDetailBottomSheet();
    }

    //print(response);
  }

  getUserList() async {
    var response = await service.getMyUserListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserDataDropDown = response.data ?? [];
        update();
      }
    }
  }

  tradeDetailBottomSheet() {
    Get.bottomSheet(
        PopScope(
          canPop: false,
          onPopInvoked: (canpop) {},
          child: StatefulBuilder(builder: (context, stateSetter) {
            return Column(
              children: [
                Expanded(child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                )),
                Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        color: AppColors().bgColor),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Expanded(
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            shrinkWrap: true,
                            children: [
                              sheetList("Username", tradeDetail.userName ?? "", 0),
                              sheetList("Order Time", shortFullDateTime(tradeDetail.executionDateTime!), 1),
                              sheetList("Symbol", tradeDetail.symbolName ?? "", 2),
                              sheetList("Order Type", tradeDetail.orderType ?? "", 3),
                              sheetList("Trade Type", tradeDetail.tradeTypeValue ?? "", 4),
                              sheetList("Quantity", tradeDetail.quantity!.toString(), 5),
                              sheetList("Price", tradeDetail.price.toString(), 6),
                              sheetList("Average Price",
                                  arrAccountSummaryListData[selectedIndex].positionDataAveragePrice!.toStringAsFixed(2), 6),
                              sheetList("Closing", arrAccountSummaryListData[selectedIndex].closing!.toStringAsFixed(2), 6),
                              sheetList("Open Qty", arrAccountSummaryListData[selectedIndex].positionDataQuantity!.toString(), 6),
                              sheetList("Order Method", tradeDetail.orderMethod ?? "", 7),
                              sheetList("Device Id", tradeDetail.deviceId ?? "", 8),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            );
          }),
        ),
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: true);
  }

  Widget sheetList(String name, String value, int index) {
    Color backgroundColor = index % 2 == 1 ? AppColors().headerBgColor : AppColors().contentBg;
    return Container(
      width: 100.w,
      height: 38,
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: Row(
          children: [
            Text(name.toString(),
                style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().lightText)),
            const Spacer(),
            Text(value.toString(),
                style: TextStyle(fontSize: 12, fontFamily: Appfonts.family1Medium, color: AppColors().DarkText)),
          ],
        ),
      ),
    );
  }
}
