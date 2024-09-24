import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/modelClass/quantitySettingListMmodelClass.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

class QuantitySettingControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuantitySettingController());
  }
}

class QuantitySettingController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  TextEditingController lotMaxController = TextEditingController();
  FocusNode lotMaxFocus = FocusNode();
  TextEditingController qtyMaxController = TextEditingController();
  FocusNode qtyMaxFocus = FocusNode();
  TextEditingController brkQtyController = TextEditingController();
  FocusNode brkQtyFocus = FocusNode();
  TextEditingController brkLotController = TextEditingController();
  FocusNode brkLotFocus = FocusNode();
  TextEditingController textController = TextEditingController();
  FocusNode textFocus = FocusNode();
  List<QuantitySettingData> arrQuantitySetting = [];
  String selectedUserId = "";
  String selectedGroupId = "";
  bool isAllSelected = false;
  bool isSingleSelected = false;
  bool isApiCallRunning = false;
  List<String> arrTempSelected = [];
  int totalPage = 0;
  int currentPage = 1;
  bool isPagingApiCall = false;
  bool isDarkMode = false;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      selectedUserId = Get.arguments["userId"];
      selectedGroupId = Get.arguments["groupId"];
      isApiCallRunning = true;
      quantitySettingList();
    }
    lotMaxController.addListener(() {
      update();
    });
    qtyMaxController.addListener(() {
      update();
    });
    brkQtyController.addListener(() {
      update();
    });
    brkLotController.addListener(() {
      update();
    });
  }
  //*********************************************************************** */
  // Field Validation
  //*********************************************************************** */

  String validateField() {
    var msg = "";

    if (lotMaxController.text.trim().isEmpty) {
      msg = AppString.emptyLotMax;
    } else if (qtyMaxController.text.trim().isEmpty) {
      msg = AppString.emptyqtyMax;
    } else if (brkQtyController.text.trim().isEmpty) {
      msg = AppString.emptybrkQty;
    } else if (brkLotController.text.trim().isEmpty) {
      msg = AppString.emptybrkLot;
    } else if (arrTempSelected.isEmpty) {
      msg = AppString.emptyScriptSelection;
    }
    return msg;
  }

  quantitySettingList() async {
    if (isPagingApiCall) {
      return;
    }
    isPagingApiCall = true;

    update();
    var response = await service.quantitySettingListCall(
        userId: selectedUserId,
        page: currentPage,
        groupId: selectedGroupId,
        text: textController.text.trim());
    isApiCallRunning = false;
    arrQuantitySetting.addAll(response!.data!);
    isPagingApiCall = false;
    totalPage = response.meta!.totalPage!;
    if (totalPage >= currentPage) {
      currentPage = currentPage + 1;
    }
    update();
  }

  updateQuantity() async {
    for (var element in arrQuantitySetting) {
      if (element.isSelected) {
        arrTempSelected.add(element.userWiseGroupDataAssociationId!);
      }
    }
    var msg = validateField();
    if (msg.isEmpty) {
      isApiCallRunning = true;
      update();

      var response = await service.updateQuantityCall(
          arrIDs: arrTempSelected,
          quantityMax: qtyMaxController.text.trim(),
          userId: selectedUserId,
          lotMax: lotMaxController.text.trim(),
          breakQuantity: brkQtyController.text.trim(),
          breakUpLot: brkLotController.text.trim());
      // isApiCallRunning = false;
      update();
      if (response != null) {
        if (response.statusCode == 200) {
          showSuccessToast(response.meta!.message ?? "",globalContext!);
          qtyMaxController.clear();
          lotMaxController.clear();
          brkLotController.clear();
          brkQtyController.clear();
          qtyMaxFocus.unfocus();
          lotMaxFocus.unfocus();
          brkLotFocus.unfocus();
          brkQtyFocus.unfocus();
          isAllSelected = false;
          arrTempSelected.clear();
          currentPage = 1;
          arrQuantitySetting.clear();
          quantitySettingList();
          quantitySettingList();
        } else {
          showErrorToast(response.message ?? "",globalContext!);
        }
      }
    } else {
      showWarningToast(msg,globalContext!);
    }
  }

  bool isAllNotEmpty() {
    return lotMaxController.text.isNotEmpty &&
        qtyMaxController.text.isNotEmpty &&
        brkQtyController.text.isNotEmpty &&
        brkLotController.text.isNotEmpty;
  }
}
