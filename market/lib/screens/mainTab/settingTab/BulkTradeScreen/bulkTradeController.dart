import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/bulkTradeModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../../modelClass/constantModelClass.dart';
import '../../../BaseViewController/baseController.dart';

class BulkTradeControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BulkTradeController());
  }
}

class BulkTradeController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */

  Rx<UserData> selectedUser = UserData().obs;
  RxString selectedTradeStatus = "".obs;
  Rx<Type> selectedStatus = Type().obs;
  Rx<ExchangeData> selectedExchange = ExchangeData().obs;
  Rx<GlobalSymbolData> selectedScriptFromFilter = GlobalSymbolData().obs;
  List<ExchangeData> arrExchange = [];
  List<GlobalSymbolData> arrAllScript = [];
  List<BulkTradeData> arrBulkTrade = [];
  bool isApiCallRunning = false;
  bool isResetCall = false;
  String selectedUserId = "";
  int totalPage = 0;
  int currentPage = 1;
  bool isPagingApiCall = false;
  FocusNode viewFocus = FocusNode();
  FocusNode clearFocus = FocusNode();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    isApiCallRunning = true;
    bulkTradeList();
  }

  bulkTradeList({bool isFromClear = false, bool isFromFilter = false}) async {
    if (isFromFilter) {
      if (isFromClear) {
        isResetCall = true;
      } else {
        isApiCallRunning = true;
      }
    }
    if (isPagingApiCall) {
      return;
    }
    isPagingApiCall = true;

    update();
    var response = await service.bulkTradeListCall(currentPage, selectedExchange.value.exchangeId ?? "", selectedScriptFromFilter.value.symbolId ?? "", selectedUser.value.userId ?? "");

    isApiCallRunning = false;
    isPagingApiCall = false;
    isResetCall = false;
    totalPage = response!.meta!.totalPage!;
    if (totalPage >= currentPage) {
      currentPage = currentPage + 1;
    }
    update();
    arrBulkTrade.addAll(response.data!);
    update();
  }
}
