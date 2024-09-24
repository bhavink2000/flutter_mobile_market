import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:number_to_indian_words/number_to_indian_words.dart';

import '../../../../../../constant/const_string.dart';
import '../../../../../../constant/utilities.dart';
import '../../../../../../modelClass/creditListModelClass.dart';

class CreditGiveControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreditGiveController());
  }
}

enum TransType { Credit, Debit }

class CreditGiveController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  Rx<TransType> selectedTransType = TransType.Credit.obs;
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
  TextEditingController commentController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  List<creditData> arrCreditList = [];

  @override
  void onInit() async {
    super.onInit();

    if (Get.arguments != null) {
      userId = Get.arguments["userId"];
    } else {
      userId = userData!.userId!;
    }
    getCreditList();
  }

  getCreditList() async {
    var response = await service.getCreditListCall(userId: userId);
    if (response?.statusCode == 200) {
      arrCreditList = response!.data ?? [];
      for (var i = 0; i < arrCreditList.length; i++) {
        if (arrCreditList[i].transactionType == "credit") {
          if (i == 0) {
            arrCreditList[i].balance = arrCreditList[i].amount!;
          } else {
            arrCreditList[i].balance = arrCreditList[i - 1].balance + arrCreditList[i].amount!;
          }
        } else {
          arrCreditList[i].balance = arrCreditList[i - 1].balance - arrCreditList[i].amount!;
        }
      }
      update();
    }
  }

  String numericToWord() {
    var word = "";

    word = NumToWords.convertNumberToIndianWords(int.parse(amountController.text)).toUpperCase();

    // word.replaceAll("MILLION", "LAC.");
    // word.replaceAll("BILLION", "CR.");

    return word;
  }

  String validateField() {
    var msg = "";

    if (amountController.text.trim().isEmpty) {
      msg = AppString.emptyAmount;
    }
    return msg;
  }

  callForAddAmount() async {
    var msg = validateField();
    if (msg.isEmpty) {
      isApiCallRunning = true;
      update();
      var response = await service.addCreditCall(userId: userId, comment: commentController.text.trim(), amount: amountController.text.trim(), type: "credit", transactionType: selectedTransType == TransType.Credit ? "credit" : "debit");
      isApiCallRunning = false;
      update();
      if (response != null) {
        if (response.statusCode == 200) {
          amountController.clear();
          commentController.clear();

          showSuccessToast(response.meta?.message ?? "", globalContext!);
        }
        getCreditList();
      }
    } else {
      showWarningToast(msg, globalContext!);
    }
  }
}
