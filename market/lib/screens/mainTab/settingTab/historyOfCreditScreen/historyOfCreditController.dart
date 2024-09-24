import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../constant/const_string.dart';
import '../../../../main.dart';
import '../../../../modelClass/creditListModelClass.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../../modelClass/tradeDetailModelClass.dart';
import '../../../../modelClass/constantModelClass.dart';
import '../../../BaseViewController/baseController.dart';

class HistoryOfCreditControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryOfCreditController());
  }
}

class HistoryOfCreditController extends BaseController {
//*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */

  RxString fromDate = "".obs;
  RxString toDate = "".obs;
  // AccountSummaryType? selectedAccountSummaryType;
  Rx<UserData> selectedUser = UserData().obs;
  Type? selectedType;

  bool isApiCallRunning = false;
  bool isResetCall = false;
  num totalAmount = 0.0;
  bool isPagingApiCall = false;
  int totalPage = 0;
  int currentPage = 1;
  TradeDetailData tradeDetail = TradeDetailData();
  bool isApiCall = false;
  var tradeID = "";
  RxString selectStatusdropdownValue = "".obs;
  List<String> arrCustomDateSelection = [];
  FocusNode viewFocus = FocusNode();
  FocusNode clearFocus = FocusNode();
  List<UserData> arrUserDataDropDown = [];

  List<creditData> arrCreditList = [];
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    isApiCallRunning = true;
    selectedType = constantValues!.transactionType!.first;
    arrCustomDateSelection.addAll(CommonCustomDateSelection().arrCustomDate);
    // getUserList();
    getCreditList();
  }

  getUserList() async {
    // arrUserDataDropDown = constantValues!.userFilterType!;
    var response = await service.getMyUserListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserDataDropDown = response.data ?? [];
        update();
      }
    }
  }

  getCreditList() async {
    var response = await service.getCreditListCall(userId: userData!.userId!);

    if (response?.statusCode == 200) {
      print(response!.toJson());
      arrCreditList = response.data ?? [];
      isApiCallRunning = false;
      for (var i = 0; i < arrCreditList.length; i++) {
        if (arrCreditList[i].transactionType == "credit") {
          if (i == 0) {
            arrCreditList[i].balance = arrCreditList[i].amount!;
          } else {
            arrCreditList[i].balance = arrCreditList[i - 1].balance + arrCreditList[i].amount!;
          }
        } else {
          if (i == 0) {
            arrCreditList[i].balance = arrCreditList[i].balance;
          } else {
            arrCreditList[i].balance = arrCreditList[i - 1].balance - arrCreditList[i].amount!;
          }
        }
      }

      update();
    }
  }
}
