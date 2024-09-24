import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/modelClass/allSymbolListModelClass.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

import '../../../../../../constant/utilities.dart';
import '../../../../../../modelClass/profileInfoModelClass.dart';

class UserListDetailsAddOrderControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserListDetailsAddOrderController());
  }
}

class UserListDetailsAddOrderController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  TextEditingController searchTextController = TextEditingController();
  FocusNode searchTextFocus = FocusNode();
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  TextEditingController rateBoxOneController = TextEditingController();
  FocusNode rateBoxOneFocus = FocusNode();
  TextEditingController rateBoxTwoController = TextEditingController();
  FocusNode rateBoxTwoFocus = FocusNode();
  TextEditingController quantityController = TextEditingController();
  FocusNode quantityFocus = FocusNode();
  Rx<GlobalSymbolData> selectedScriptDropDownValue = GlobalSymbolData().obs;
  Rx<ExchangeData> selectExchangedropdownValue = ExchangeData().obs;
  RxString typedropdownValue = "".obs;
  RxString orderTypedropdownValue = "".obs;
  RxString rateaBydropdownValue = "".obs;
  bool isDarkMode = false;
  ProfileInfoData? userDetailsObj;
  RxBool isBuy = true.obs;
  RxList<GlobalSymbolData> arrMainScript = RxList<GlobalSymbolData>();
  bool isApicall = false;
  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      userDetailsObj = Get.arguments["userObj"];
      nameController.text = userDetailsObj?.userName ?? "";
      update();
    }
    await getScriptList();
    update();
  }

  getScriptList() async {
    var response = await service.allSymbolListCall(1, "", selectExchangedropdownValue.value.exchangeId ?? "");
    arrMainScript.value = response!.data ?? [];
  }

  String validateForm() {
    var msg = "";

    if (selectExchangedropdownValue.value.exchangeId == null) {
      msg = AppString.emptyExchange;
    } else if (selectedScriptDropDownValue.value.symbolId == null) {
      msg = AppString.emptyScript;
    } else if (rateBoxOneController.text.trim().isEmpty) {
      msg = AppString.emptyPrice;
    } else if (quantityController.text.trim().isEmpty) {
      msg = AppString.emptyQty;
    }
    return msg;
  }

  initiateManualTrade() async {
    var msg = validateForm();

    if (msg.isEmpty) {
      isApicall = true;
      update();
      var response = await service.manualTradeCall(
        // symbolId: selectedScriptDropDownValue.value.symbolId,
        // quantity: double.parse(quantityController.text),
        // price: double.parse(rateBoxOneController.text),
        // lotSize: selectedScriptDropDownValue.value.lotSize!.toInt(),
        // orderType: "market",
        // tradeType: isBuy.value ? "buy" : "sell",
        // exchangeId: selectExchangedropdownValue.value.exchangeId,
        // userId: userDetailsObj!.userId!,

        executionTime: serverFormatDateTime(DateTime.now()),
        symbolId: selectedScriptDropDownValue.value.symbolId,
        totalQuantity: double.parse(quantityController.text),
        quantity: double.parse(quantityController.text),
        price: double.parse(rateBoxOneController.text),
        lotSize: selectedScriptDropDownValue.value.lotSize!.toInt(),
        orderType: "market",
        tradeType: isBuy.value ? "buy" : "sell",
        exchangeId: selectExchangedropdownValue.value.exchangeId,
        userId: userDetailsObj!.userId!,
        // manuallyTradeAddedFor: selectedManualType.value.id,
      );

      //longterm
      isApicall = false;
      update();
      if (response != null) {
        // Get.back();
        if (response.statusCode == 200) {
          selectExchangedropdownValue = ExchangeData().obs;
          selectedScriptDropDownValue = GlobalSymbolData().obs;
          rateBoxOneController.clear();
          quantityController.clear();
          showSuccessToast(response.meta!.message!,globalContext!);
        } else {
          isApicall = false;
          showErrorToast(response.message!,globalContext!);
          update();
        }
      }
    } else {
      // stateSetter(() {});
      showWarningToast(msg,globalContext!);
      Future.delayed(const Duration(milliseconds: 100), () {});
    }
  }
}
