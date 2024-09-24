import 'package:get/get.dart';
import 'package:market/modelClass/allSymbolListModelClass.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/modelClass/myUserListModelClass.dart';
import 'package:market/modelClass/rejectLogLisTModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

import '../../../../constant/const_string.dart';
import '../../../../main.dart';

class RejectionLogControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RejectionLogController());
  }
}

class RejectionLogController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  bool isFilterOpen = false;
  List<String> arrCustomDateSelection = [];
  RxString selectedTradeStatus = "".obs;
  Rx<ExchangeData> selectedExchange = ExchangeData().obs;
  Rx<GlobalSymbolData> selectedScriptFromFilter = GlobalSymbolData().obs;
  List<ExchangeData> arrExchange = [];
  List<GlobalSymbolData> arrAllScript = [];
  List<RejectLogData> arrRejectLog = [];
  bool isApiCallRunning = false;
  String selectedUserId = "";
  RxString selectStatusdropdownValue = "".obs;
  String startDate = '';
  String endDate = '';

  List<UserData> arrUserDataDropDown = [];
  RxList<GlobalSymbolData> arrMainScript = RxList<GlobalSymbolData>();
  Rx<ExchangeData> selectExchangedropdownValue = ExchangeData().obs;
  Rx<GlobalSymbolData> selectedScriptDropDownValue = GlobalSymbolData().obs;
  Rx<UserData> selectUserDropdownValue = UserData().obs;

  List<ExchangeData> arrExchangeList = [];
  List<GlobalSymbolData> arrScriptListDropdown = [];
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    arrCustomDateSelection.addAll(CommonCustomDateSelection().arrCustomDate);
    if (userData!.role == UserRollList.user) {
      selectUserDropdownValue.value = UserData(userId: userData!.userId);
    }
    getExchangeList();
    getUserList();
    rejectLogList();
  }

  rejectLogList() async {
    arrRejectLog.clear();
    isApiCallRunning = true;
    update();
    var response = await service.getRejectLogListCall(
        page: 1, startDate: startDate != "" ? startDate : "", endDate: endDate != "" ? endDate : "", userId: selectUserDropdownValue.value.userId ?? "", exchangeId: selectExchangedropdownValue.value.exchangeId ?? "", symbolId: selectedScriptDropDownValue.value.symbolId ?? "");

    isApiCallRunning = false;
    update();
    arrRejectLog = response!.data ?? [];
    update();
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
        update();
      }
    }
  }

  getScriptList() async {
    var response = await service.allSymbolListCall(1, "", selectExchangedropdownValue.value.exchangeId ?? "");
    arrMainScript.value = response!.data ?? [];

    update();
  }
}
