import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/modelClass/categoryDataModelClass.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/modelClass/userwiseBrokerageListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

class BrkSettingControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BrkSettingController());
  }
}

class BrkSettingController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  TextEditingController amountController = TextEditingController();
  FocusNode amountFocus = FocusNode();
  List<String> selectStatuslist = <String>['ALL', 'Active', 'Inactive'];
  List<String> selectPercentagelist = <String>['Percentage', 'Amount'];
  RxString selectStatusdropdownValue = "".obs;
  RxString selectPercentagedropdownValue = "".obs;
  TextEditingController textController = TextEditingController();
  FocusNode textFocus = FocusNode();
  bool isDarkMode = false;
  bool isCheckBoxSelected = false;
  List<categoryDataModel> arrData = [];
  String selectedUserId = "";
  bool isAllSelected = false;
  List<String> arrTempSelected = [];
  List<userWiseBrokerageData> arrBrokerage = [];
  bool isApiCallRunning = false;
  bool isupdateCallRunning = false;
  List<ExchangeData> arrExchangeList = [];
  Rx<ExchangeData> selectExchangedropdownValue = ExchangeData().obs;
  int totalPage = 0;
  int currentPage = 1;
  bool isPagingApiCall = false;

  String isTurnOverBtnSelected = "1";
  @override
  void onInit() async {
    super.onInit();

    if (Get.arguments != null) {
      selectedUserId = Get.arguments["userId"];
      getExchangeList();
    }

    update();
  }

  getExchangeList() async {
    var response = await service.getExchangeListUserWiseCall(
        userId: selectedUserId,
        brokerageType:
            isTurnOverBtnSelected == "1" ? "turnoverwise" : "symbolwise");
    if (response != null) {
      if (response.statusCode == 200) {
        arrExchangeList = response.exchangeData ?? [];
      }
    }
  }

  userWiseBrkList({bool isFromFilter = false}) async {
    if (isPagingApiCall) {
      return;
    }
    isPagingApiCall = true;

    update();
    var response = await service.userWiseBrokerageListCall(
        page: 1,
        userId: selectedUserId,
        search: textController.text.trim(),
        exchangeId: selectExchangedropdownValue.value.exchangeId ?? "",
        type: isTurnOverBtnSelected == "1" ? "turnoverwise" : "symbolwise");

    isupdateCallRunning = false;
    isApiCallRunning = false;
    update();
    if (isFromFilter) {
      arrBrokerage.clear();
    }
    arrBrokerage.addAll(response!.data!);
    isPagingApiCall = false;
    totalPage = response.meta!.totalPage!;
    if (totalPage >= currentPage) {
      currentPage = currentPage + 1;
    }
    update();
  }
  //*********************************************************************** */
  // Field Validation
  //*********************************************************************** */

  String validateField() {
    var msg = "";

    if (amountController.text.trim().isEmpty) {
      msg = AppString.emptyPrice;
    } else if (arrTempSelected.isEmpty) {
      msg = AppString.emptyScriptSelection;
    }
    return msg;
  }

  updateBrk() async {
    for (var element in arrBrokerage) {
      if (element.isSelected) {
        arrTempSelected.add(element.userWiseBrokerageId!);
      }
    }
    var msg = validateField();
    if (msg.isEmpty) {
      isupdateCallRunning = true;
      update();

      var response = await service.updateBrkCall(
        arrIDs: arrTempSelected,
        brokeragePrice: amountController.text.trim(),
        brokerageType:
            isTurnOverBtnSelected == "1" ? "turnoverwise" : "symbolwise",
        userId: selectedUserId,
      );
      isApiCallRunning = false;
      isupdateCallRunning = false;
      update();
      arrTempSelected.clear();
      isAllSelected = false;
      if (response != null) {
        if (response.statusCode == 200) {
          showSuccessToast(response.meta!.message ?? "",globalContext!);
          amountController.clear();
          currentPage = 1;
          userWiseBrkList(isFromFilter: true);
        } else {
          showErrorToast(response.message ?? "",globalContext!);
        }
      }
    } else {
      showWarningToast(msg,globalContext!);
    }
  }
}
