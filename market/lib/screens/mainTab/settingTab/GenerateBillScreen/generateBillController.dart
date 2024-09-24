import 'package:better_open_file/better_open_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/constantModelClass.dart';
import 'package:market/navigation/routename.dart';
import 'package:market/screens/BaseViewController/baseController.dart';

import '../../../../constant/const_string.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/myUserListModelClass.dart';

class GenerateBillControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenerateBillController());
  }
}

class GenerateBillController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  List<String> arrCustomDateSelection = [];
  RxString selectedDateValue = "".obs;
  Rx<UserData> selectedUser = UserData().obs;
  RxString selectedExchangeValue = "".obs;
  Rx<AddMaster> selectedBillType = AddMaster().obs;
  final TextEditingController textEditingController = TextEditingController();
  FocusNode textEditingFocus = FocusNode();
  bool isDarkMode = false;
  bool isApiCall = false;
  String fromDate = "";
  String toDate = "";
  String billHtml = "";
  List<UserData> arrUserDataDropDown = [];
  List<ExchangeData> arrExchangeList = [];
  RxString selectStatusdropdownValue = "".obs;

  @override
  void onInit() async {
    super.onInit();
    if (constantValues!.billType!.isNotEmpty && constantValues!.billType!.length > 3) {
      constantValues!.billType!.removeAt(0);
    }
    getUserList();
    getExchangeList();
    arrCustomDateSelection.addAll(CommonCustomDateSelection().arrCustomDate);
    // if (userData!.role != UserRollList.superAdmin) {
    //   arrCustomDateSelection.removeAt(0);
    // }
    update();
    if (userData!.role == UserRollList.user) {
      selectedUser.value = UserData(userId: userData!.userId);
    }
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

  getBill() async {
    if (selectStatusdropdownValue.toString().isNotEmpty) {
      if (selectStatusdropdownValue.toString() != 'Custom Period') {
        String thisWeekDateRange = "$selectStatusdropdownValue";
        List<String> dateParts = thisWeekDateRange.split(" to ");
        fromDate = dateParts[0].trim().split('Week').last;
        toDate = dateParts[1];
      } else {
        // fromDate = '';
        // toDate = '';
      }
    }
    if (selectedUser.value.userId == null) {
      showWarningToast("Please select user", globalContext!);
      return;
    }
    isApiCall = true;
    update();
    var response = await service.billGenerateCall(fromDate != "" ? fromDate.trim() : "", "", toDate != "" ? toDate.trim() : "", selectedUser.value.userId ?? "", selectedBillType.value.id!);
    if (response?.statusCode == 200) {
      print(response!.data);
      if (selectedBillType.value.id == 1) {
        var fileObj = await service.downloadFilefromUrl(response.data!.pdfUrl!);
        OpenFile.open(fileObj!.path);
      } else if (selectedBillType.value.id == 2) {
        var fileObj = await service.downloadFilefromUrl(response.data!.excelUrl!, type: "xlsx");
        OpenFile.open(fileObj!.path);
      } else if (selectedBillType.value.id == 3) {
        billHtml = response.data!.html ?? "";
        Get.toNamed(RouterName.htmlViewerScreen);
      }
      // selectedUser.value = UserData();
      if (userData!.role == UserRollList.user) {
        selectedUser.value = UserData(userId: userData!.userId);
      }
      // fromDate = "";
      // toDate = "";
      // showSuccessToast("File successfully saved on your download folder.");
    } else {
      showErrorToast(response!.message ?? "", globalContext!);
    }
    isApiCall = false;
    print(response);

    update();
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
}
