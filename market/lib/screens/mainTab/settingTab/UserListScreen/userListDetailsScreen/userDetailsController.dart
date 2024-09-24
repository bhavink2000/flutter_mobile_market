import 'dart:convert';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/screens/BaseViewController/baseController.dart';
import 'package:market/screens/mainTab/settingTab/UserListScreen/settingUserListController.dart';

import '../../../../../constant/color.dart';
import '../../../../../constant/utilities.dart';
import '../../../../../main.dart';
import '../../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../../modelClass/categoryDataModelClass.dart';
import '../../../../../modelClass/constantModelClass.dart';
import '../../../../../modelClass/exchangeListModelClass.dart';
import '../../../../../modelClass/getScriptFromSocket.dart';
import '../../../../../modelClass/myTradeListModelClass.dart';
import '../../../../../modelClass/myUserListModelClass.dart';
import '../../../../../modelClass/positionModelClass.dart';
import '../../../../../modelClass/profileInfoModelClass.dart';
import '../../../../../modelClass/userRoleListModelClass.dart';
import '../../../positionTab/positionController.dart';
import '../../../tradeTab/tradeController.dart';

class UserDetailsControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserDetailsController());
  }
}

class UserDetailsController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  //**************************************************** */
  //OVERVIEW SCREEN
  //**************************************************** */
  List<UserData> arrSearchUserData = [];
  List<UserData> arrUserListData = [];
  bool isLoadingData = false;
  Rx<AddMaster> userdropdownValue = AddMaster().obs;
  Rx<userRoleListData> selectUserdropdownValue = userRoleListData().obs;
  Rx<AddMaster> selectStatusdropdownValue = AddMaster().obs;
  List<AddMaster> userlist = [];
  List<userRoleListData> selectUserlist = [];
  List<AddMaster> selectStatuslist = [];
  //**************************************************** */
  //TRADELIST SCREEN
  //**************************************************** */
  ScrollController listcontrollers = ScrollController();
  DateTime? fromDate;
  DateTime? toDate;
  TextEditingController textController = TextEditingController();
  FocusNode textFocus = FocusNode();
  List<TradeData> arrTrade = [];
  bool isSuccessSelected = true;
  TradeData? selectedTrade;
  int pageNumber = 1;
  int totalPage = 0;
  int totalSuccessRecord = 0;
  int totalPendingRecord = 0;
  bool isLocalDataLoading = true;
  RxDouble totalPositionPercentWise = 0.0.obs;
  // List<UserData> arrUserList = [];
  List<ExchangeData> arrExchangeList = [];

  RxList<GlobalSymbolData> arrMainScript = RxList<GlobalSymbolData>();
  Rx<ExchangeData> selectExchangedropdownValue = ExchangeData().obs;
  Rx<GlobalSymbolData> selectedScriptDropDownValue = GlobalSymbolData().obs;
  RxString fromDateStr = "Start Date".obs;
  RxString endDateStr = "End Date".obs;

  List<UserData> arrUserDataDropDown = [];
  final TextEditingController textEditingController = TextEditingController();
  FocusNode textEditingFocus = FocusNode();
  Rx<UserData> selectUserDropdownValue = UserData().obs;

  //*********************************************************************** */
  // POSITION
  //*********************************************************************** */
  // ScrollController listcontroller = ScrollController();
  bool isTotalViewExpanded = false;
  // TextEditingController textController = TextEditingController();
  // FocusNode textFocus = FocusNode();
  List<positionListData> arrPositionScriptList = [];
  Rx<positionListData?>? selectedScript;
  // Rx<ScriptData> selectedScriptFromSocket = ScriptData().obs;
  RxDouble totalPosition = 0.0.obs;
  GlobalKey<ExpandableBottomSheetState>? buySellBottomSheetKey;
  ScrollController orderTypeListcontroller = ScrollController();
  RxInt selectedOptionBottomSheetTab = 0.obs;
  RxInt selectedIntraLongBottomSheetTab = 0.obs;
  Type? selectedOrderType;
  TextEditingController qtyController = TextEditingController();
  FocusNode qtyFocus = FocusNode();
  TextEditingController priceController = TextEditingController();
  FocusNode priceFocus = FocusNode();
  bool isForBuy = false;
  RxBool isTradeCallFinished = true.obs;
  String selectedUserId = "";
  bool isUserApiCallRunning = false;
  // ScrollController sheetController = ScrollController();

  //**************************************************** */
  //OVERVIEW SCREEN
  //**************************************************** */

  ScrollController listcontroller = ScrollController();
  ScrollController sheetController = ScrollController();
  bool isDetailSciptOn = false;
  // List<categoryDataModel> arrUserDetailsData = [];
  ProfileInfoData? arrUserDetailsData1;
  int selectedCategory = 1;
  String roll = "";
  List<categoryDataModel> arrUserDetailsData = [
    categoryDataModel(name: "User Name", values: "arrUserDetailsData1?.name ??", isMore: false, isSwitch: false),
    categoryDataModel(name: "Name", values: "59062", isMore: false, isSwitch: false),
    categoryDataModel(name: "Mobile Number", values: "2609", isMore: false, isSwitch: false),
    categoryDataModel(name: "City", values: "59121.63", isMore: false, isSwitch: false),
    categoryDataModel(name: "Remark", values: "18:12:55", isMore: false, isSwitch: false),
    categoryDataModel(name: "Created Date", values: "18:12:55", isMore: false, isSwitch: false),
    categoryDataModel(name: "Last Login", values: "18:12:55", isMore: false, isSwitch: false),
    categoryDataModel(name: "IP Address", values: "18:12:55", isMore: false, isSwitch: false),
    categoryDataModel(name: "Exchange", values: "18:12:55", isMore: false, isSwitch: false),
    categoryDataModel(name: "Bet", values: "", isMore: false, isSwitch: true),

    categoryDataModel(name: "Close Only", values: "", isMore: false, isSwitch: true),
    categoryDataModel(name: "Auto Square Off", values: "", isMore: false, isSwitch: true),
    categoryDataModel(name: "View Only", values: "", isMore: false, isSwitch: true),
    categoryDataModel(name: "Status", values: "", isMore: false, isSwitch: true),
    categoryDataModel(name: "Credit", values: "-", isMore: false, isSwitch: false),
    categoryDataModel(name: "Credit History", values: "", isMore: true, isSwitch: false),
    categoryDataModel(name: "Group Quantity Settings", values: "", isMore: true, isSwitch: false),
    // categoryDataModel(
    //     name: "Margin Square Off Settings",
    //     values: "97.0%",
    //     isMore: false,
    //     isSwitch: false),
    categoryDataModel(name: "Brk Setting", values: "", isMore: true, isSwitch: false),
    // categoryDataModel(
    //     name: "Intraday SquareOff", values: "", isMore: true, isSwitch: false),
    // categoryDataModel(
    //     name: "Trade Margin", values: "", isMore: true, isSwitch: false),
    categoryDataModel(name: "Sharing Details", values: "", isMore: true, isSwitch: false),
    categoryDataModel(name: "Change Password", values: "", isMore: true, isSwitch: false),
    categoryDataModel(name: "Add Order", values: "", isMore: true, isSwitch: false),
  ];

  @override
  void onClose() {
    Get.find<SettingUserListController>().updateList();
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    // //**************************************************** */
    // //POSITION SCREEN
    // //**************************************************** */

    selectedOrderType = constantValues!.orderType![0];

    //**************************************************** */
    //TRADELIST SCREEN
    //**************************************************** */

    getExchangeList();

    // getScriptList();

    listcontroller.addListener(() async {
      if ((listcontroller.position.pixels > listcontroller.position.maxScrollExtent / 2.5 && totalPage > 1 && pageNumber < totalPage && !isLocalDataLoading)) {
        isLocalDataLoading = true;
        pageNumber++;
        update();
        var response = await service.getMyTradeListCall(
          status: isSuccessSelected ? "executed" : "pending",
          page: pageNumber,
          text: textController.text.trim(),
          userId: selectUserDropdownValue.value.userId,
          symbolId: selectedScriptDropDownValue.value.symbolId,
          exchangeId: selectedScriptDropDownValue.value.exchangeId,
          startDate: fromDateStr.value != "Start Date" ? fromDateStr.value : "",
          endDate: endDateStr.value != "End Date" ? endDateStr.value : "",
        );
        if (response != null) {
          if (response.statusCode == 200) {
            totalPage = response.meta?.totalPage ?? 0;
            if (isSuccessSelected) {
              totalSuccessRecord = response.meta?.totalCount ?? 0;
            } else {
              totalPendingRecord = response.meta?.totalCount ?? 0;
            }

            for (var v in response.data!) {
              arrTrade.add(v);
            }
            isLocalDataLoading = false;
            update();
            var arrTemp = [];
            for (var element in response.data!) {
              if (!arrSymbolNames.contains(element.symbolName)) {
                arrTemp.insert(0, element.symbolName);
                arrSymbolNames.insert(0, element.symbolName!);
              }
            }

            var txt = {"symbols": arrSymbolNames};
            if ((arrSymbolNames.isNotEmpty)) {
              socket.connectScript(jsonEncode(txt));
            }
          }
        }
      }
    });

    //**************************************************** */
    //OVERVIEW SCREEN
    //**************************************************** */
    if (Get.arguments != null) {
      selectedUserId = Get.arguments["userId"];
      roll = Get.arguments["roll"];
      // Parse the DateTime string
      if (roll != UserRollList.user && roll != UserRollList.broker) {
        callForRoleList();
      }

      getUSerInfo();

      update();
    }
    // arrUserDetailsData.addAll(settingUserListDetailsClass().arrUserDetailsData);
    update();
  }

  callForRoleList() async {
    update();
    var response = await service.userRoleListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        selectUserlist = response.data!;
        update();
      }
    }
  }

  getUserList() async {
    print('====== calling get userList');
    isLoadingData = true;
    update();
    var response = await service.getChildUserListCall(
      text: textController.text.trim(),
      status: selectStatusdropdownValue.value.id?.toString() ?? "",
      roleId: selectUserdropdownValue.value.roleId ?? "",
      userId: selectedUserId,
      filterType: userdropdownValue.value.id?.toString() ?? "",
    );
    isLoadingData = false;
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserListData = response.data ?? [];
        arrSearchUserData.addAll(arrUserListData);
        update();
        print("============= in if");
      }
    }
  }

  getUSerInfo() async {
    isUserApiCallRunning = true;
    update();
    var userResponse = await service.profileInfoByUserIdCall(selectedUserId);
    if (userResponse != null) {
      if (userResponse.statusCode == 200) {
        arrUserDetailsData1 = userResponse.data;
        isUserApiCallRunning = false;
        update();
        getUserList();
        getTradeList();
        getPositionList("");

        String formattedCreatedDate = shortFullDateTime(arrUserDetailsData1!.createdAt!);
        arrUserDetailsData = [
          categoryDataModel(name: "User Name", values: arrUserDetailsData1?.userName ?? "", isMore: false, isSwitch: false),
          categoryDataModel(name: "Name", values: arrUserDetailsData1?.name ?? "", isMore: false, isSwitch: false),
          categoryDataModel(name: "Mobile Number", values: arrUserDetailsData1?.phone ?? "", isMore: false, isSwitch: false),
          // categoryDataModel(name: "City", values: arrUserDetailsData1?.city ?? "", isMore: false, isSwitch: false),
          categoryDataModel(name: "Remark", values: arrUserDetailsData1?.remark ?? "", isMore: false, isSwitch: false),
          categoryDataModel(name: "Created Date", values: "${formattedCreatedDate}", isMore: false, isSwitch: false),
          categoryDataModel(name: "Last Login", values: arrUserDetailsData1!.lastLoginTime ?? "", isMore: false, isSwitch: false),
          categoryDataModel(name: "IP Address", values: arrUserDetailsData1!.ipAddress ?? "", isMore: false, isSwitch: false),
          categoryDataModel(name: "Exchange", values: arrUserDetailsData1?.exchangeAllow!.join(',') ?? "", isMore: false, isSwitch: false),

          categoryDataModel(name: "Bet", values: null, isMore: false, isSwitch: arrUserDetailsData1!.bet!),

          categoryDataModel(name: "Close Only", values: null, isMore: false, isSwitch: arrUserDetailsData1!.closeOnly!),
          categoryDataModel(name: "Auto Square Off", values: null, isMore: false, isSwitch: arrUserDetailsData1!.autoSquareOff! == 1 ? true : false),
          categoryDataModel(name: "View Only", values: null, isMore: false, isSwitch: arrUserDetailsData1!.viewOnly!),
          categoryDataModel(name: "Status", values: null, isMore: false, isSwitch: arrUserDetailsData1!.status == 1 ? true : false),

          categoryDataModel(name: "Credit", values: arrUserDetailsData1?.credit.toString() ?? "", isMore: false, isSwitch: false),
          categoryDataModel(name: "Credit History", values: "", isMore: true, isSwitch: false),
          categoryDataModel(name: "Group Quantity Settings", values: "", isMore: true, isSwitch: false),
          // categoryDataModel(
          //     name: "Margin Square Off Settings",
          //     values: "97.0%",
          //     isMore: false,
          //     isSwitch: false),
          categoryDataModel(name: "Brk Setting", values: "", isMore: true, isSwitch: false),
          // categoryDataModel(
          //     name: "Intraday SquareOff",
          //     values: "",
          //     isMore: true,
          //     isSwitch: false),
          categoryDataModel(name: "Trade Margin", values: "", isMore: true, isSwitch: false),

          categoryDataModel(name: "Script Master", values: "", isMore: true, isSwitch: false),
          categoryDataModel(name: "Sharing Details", values: "", isMore: true, isSwitch: false),
          categoryDataModel(name: "Change Password", values: "", isMore: true, isSwitch: false),
          if (userData!.role == UserRollList.superAdmin) categoryDataModel(name: "Add Order", values: "", isMore: true, isSwitch: false),
        ];

        update();
      }
    }
  }

  //**************************************************** */
  //TRADELIST SCREEN
  //**************************************************** */
  updateUserStatus(Map<String, Object?>? payload) async {
    await service.userChangeStatusCall(payload: payload);
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
    var response = await service.allSymbolListCall(1, "", selectExchangedropdownValue.value.exchangeId!);
    arrMainScript.value = response!.data ?? [];

    update();
  }

  getTradeList() async {
    arrTrade.clear();
    pageNumber = 1;
    update();
    isLocalDataLoading = true;
    String strFromDate = "";
    String strToDate = "";
    if (fromDateStr.value != "Start Date") {
      strFromDate = DateFormat('yyyy-MM-dd').format(fromDate!);
    }
    if (endDateStr.value != "End Date") {
      strToDate = DateFormat('yyyy-MM-dd').format(toDate!);
    }

    var response = await service.getMyTradeListCall(
      status: "executed",
      page: pageNumber,
      text: textController.text.trim(),
      userId: arrUserDetailsData1?.userId!,
      symbolId: selectedScriptDropDownValue.value.symbolId,
      exchangeId: selectedScriptDropDownValue.value.exchangeId,
      startDate: strFromDate,
      endDate: strToDate,
    );
    isLocalDataLoading = false;
    if (response != null) {
      if (response.statusCode == 200) {
        var arrTemp = [];
        response.data?.forEach((v) {
          arrTrade.add(v);
        });
        update();
        totalPage = response.meta?.totalPage ?? 0;
        if (isSuccessSelected) {
          totalSuccessRecord = response.meta?.totalCount ?? 0;
        } else {
          totalPendingRecord = response.meta?.totalCount ?? 0;
        }
        for (var element in response.data!) {
          if (!arrSymbolNames.contains(element.symbolName)) {
            arrTemp.insert(0, element.symbolName);
            arrSymbolNames.insert(0, element.symbolName!);
          }
        }

        var txt = {"symbols": arrSymbolNames};

        if ((arrSymbolNames.isNotEmpty)) {
          socket.connectScript(jsonEncode(txt));
        }
      }
    }
  }

  listenTradeScriptFromScoket(GetScriptFromSocket socketData) {
    if (socketData.status == true) {
      var obj = arrTrade.firstWhereOrNull((element) => socketData.data!.symbol == element.symbolName);

      if (obj != null) {
        for (var i = 0; i < arrTrade.length; i++) {
          if (arrTrade[i].symbolName == socketData.data!.symbol) {
            arrTrade[i].currentPriceFromScoket = double.parse(socketData.data!.ltp.toString());
          }
        }
      }
      update();
    }
  }

  Color getPriceColor(double value) {
    if (value == 0.0) {
      return AppColors().fontColor;
    }
    if (value > 0.0) {
      return AppColors().blueColor;
    } else if (value < 0.0) {
      return AppColors().redColor;
    } else {
      return AppColors().fontColor;
    }
  }

  Color getTradePriceColor(String type, double currentPrice, double tradePrice) {
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
          return AppColors().fontColor;
        }
    }
  }

  num getPlPer({num? percentage, num? pl}) {
    var temp1 = pl! * percentage!;
    var temp2 = temp1 / 100;

    return userData!.role == UserRollList.user ? temp2 : temp2 * -1;
  }

  //**************************************************** */
  // //POSITION SCREEN
  // //**************************************************** */

  String validateForm() {
    var msg = "";
    if (selectedOrderType!.id == "market") {
      if (qtyController.text.isEmpty) {
        msg = AppString.emptyQty;
      }
    } else {
      if (qtyController.text.isEmpty) {
        msg = AppString.emptyQty;
      } else if (priceController.text.isEmpty) {
        msg = AppString.emptyPrice;
      }
    }
    return msg;
  }

  initiateTrade(StateSetter stateSetter) async {
    var msg = validateForm();
    isTradeCallFinished.value = true;
    if (msg.isEmpty) {
      isTradeCallFinished.value = false;

      var response = await service.tradeCall(
        symbolId: selectedScript!.value!.symbolId,
        quantity: double.parse(qtyController.text),
        price: double.parse(priceController.text),
        isFromStopLoss: selectedOrderType!.name == "StopLoss",
        marketPrice: selectedOrderType!.name == "StopLoss"
            ? selectedScript!.value!.scriptDataFromSocket.value.ltp!.toDouble()
            : isForBuy
                ? selectedScript!.value!.scriptDataFromSocket.value.ask!.toDouble()
                : selectedScript!.value!.scriptDataFromSocket.value.bid!.toDouble(),
        lotSize: selectedScript!.value!.lotSize!.toInt(),
        orderType: selectedOrderType!.id,
        tradeType: isForBuy ? "buy" : "sell",
        exchangeId: selectedScript!.value!.exchangeId,
        productType: "longTerm",
        refPrice: isForBuy ? selectedScript!.value!.scriptDataFromSocket.value.ask!.toDouble() : selectedScript!.value!.scriptDataFromSocket.value.bid!.toDouble(),
      );

      //longterm
      isTradeCallFinished.value = false;
      update();
      if (response != null) {
        // Get.back();
        if (response.statusCode == 200) {
          var tradeVC = Get.find<tradeController>();
          tradeVC.getTradeList();
          var positionVC = Get.find<positionController>();
          positionVC.getPositionList("");
          showSuccessToast(response.meta!.message!, globalContext!);
          isTradeCallFinished.value = true;
          update();
        } else {
          isTradeCallFinished.value = true;
          showErrorToast(response.message!, globalContext!);
          update();
        }

        qtyController.text = "";
        priceController.text = "";
      }
    } else {
      // stateSetter(() {});
      showWarningToast(msg, globalContext!);
      Future.delayed(const Duration(milliseconds: 100), () {
        isTradeCallFinished.value = true;
      });
    }
  }

  getPositionList(String text, {bool isFromRefresh = false}) async {
    // if (isApicall) {
    //   CancelToken().cancel();
    // }
    arrPositionScriptList.clear();

    update();
    var response = await service.positionListCall(1, text, userId: arrUserDetailsData1!.userId!);
    totalPosition.value = 0.0;
    totalPositionPercentWise.value = 0.0;
    response!.data!.forEach((element) {
      var index = arrPositionScriptList.indexWhere((internalObj) => element.symbolId == internalObj.symbolId);
      if (index != -1) {
        arrPositionScriptList[index] = positionListData.fromJson(element.toJson());
      } else {
        arrPositionScriptList.add(positionListData.fromJson(element.toJson()));
      }
    });

    update();
    var arrTemp = [];
    for (var indexOfScript = 0; indexOfScript < arrPositionScriptList.length; indexOfScript++) {
      arrPositionScriptList[indexOfScript].profitLossValue = arrPositionScriptList[indexOfScript].totalQuantity! < 0
          ? (double.parse(arrPositionScriptList[indexOfScript].ask!.toStringAsFixed(2)) - arrPositionScriptList[indexOfScript].price!) * arrPositionScriptList[indexOfScript].totalQuantity!
          : (double.parse(arrPositionScriptList[indexOfScript].bid!.toStringAsFixed(2)) - double.parse(arrPositionScriptList[indexOfScript].price!.toStringAsFixed(2))) * arrPositionScriptList[indexOfScript].totalQuantity!;
    }
    for (var element in arrPositionScriptList) {
      totalPosition.value += element.profitLossValue ?? 0.0;
      totalPositionPercentWise.value = totalPositionPercentWise.value + getPlPer(percentage: element.profitAndLossSharing!, pl: element.profitLossValue!);
    }
    for (var element in response.data!) {
      if (!arrSymbolNames.contains(element.symbolName)) {
        arrTemp.insert(0, element.symbolName);
        arrSymbolNames.insert(0, element.symbolName!);
      }
    }

    var txt = {"symbols": arrSymbolNames};

    if (arrSymbolNames.isNotEmpty) {
      socket.connectScript(jsonEncode(txt));
    }
  }

  getPositionListOld(String text) async {
    var response = await service.positionListCall(1, text, userId: arrUserDetailsData1!.userId!);
    arrPositionScriptList = response!.data ?? [];
    update();
    var arrTemp = [];
    for (var element in response.data!) {
      if (!arrSymbolNames.contains(element.symbolName)) {
        arrTemp.insert(0, element.symbolName);
        arrSymbolNames.insert(0, element.symbolName!);
      }
    }

    var txt = {"symbols": arrSymbolNames};
    if ((arrSymbolNames.isNotEmpty)) {
      socket.connectScript(jsonEncode(txt));
    }
  }

  double getTotal(bool isBuy) {
    var total = 0.0;
    if (isBuy) {
      for (var element in selectedScript!.value!.scriptDataFromSocket.value.depth!.buy!) {
        total = total + element.price!;
      }
    } else {
      for (var element in selectedScript!.value!.scriptDataFromSocket.value.depth!.sell!) {
        total = total + element.price!;
      }
    }
    return total;
  }

  listenPositionScriptFromScoket(GetScriptFromSocket socketData) {
    if (socketData.status == true) {
      var indexOfScript = arrPositionScriptList.indexWhere((element) => socketData.data!.symbol == element.symbolName);
      if (indexOfScript == -1) {
        return;
      }
      arrPositionScriptList[indexOfScript].scriptDataFromSocket.value = socketData.data!;
      arrPositionScriptList[indexOfScript].bid = socketData.data!.bid;
      arrPositionScriptList[indexOfScript].ask = socketData.data!.ask;
      arrPositionScriptList[indexOfScript].ltp = socketData.data!.ltp;

      if (arrPositionScriptList[indexOfScript].currentPriceFromSocket != 0.0) {
        arrPositionScriptList[indexOfScript].profitLossValue = arrPositionScriptList[indexOfScript].totalQuantity! < 0
            ? (double.parse(arrPositionScriptList[indexOfScript].ask!.toStringAsFixed(2)) - arrPositionScriptList[indexOfScript].price!) * arrPositionScriptList[indexOfScript].totalQuantity!
            : (double.parse(arrPositionScriptList[indexOfScript].bid!.toStringAsFixed(2)) - double.parse(arrPositionScriptList[indexOfScript].price!.toStringAsFixed(2))) * arrPositionScriptList[indexOfScript].totalQuantity!;
      }

      totalPosition.value = 0.0;
      totalPositionPercentWise.value = 0.0;
      for (var element in arrPositionScriptList) {
        totalPosition.value += element.profitLossValue ?? 0.0;
        totalPositionPercentWise.value = totalPositionPercentWise.value + getPlPer(percentage: element.profitAndLossSharing!, pl: element.profitLossValue!);
      }
    }
    if (selectedScript?.value?.symbolName == socketData.data?.symbol) {
      selectedScript!.value!.scriptDataFromSocket.value = socketData.data!;
      selectedScript!.value!.scriptDataFromSocket.value.copyObject(socketData.data!);
      // selectedScript.value!.ask = 1 + selectedScript.value!.ask!;
    }
    update();
  }

  Color getPriceColorss(double value) {
    if (value == 0.0) {
      return AppColors().fontColor;
    }
    if (value > 0.0) {
      return AppColors().blueColor;
    } else if (value < 0.0) {
      return AppColors().redColor;
    } else {
      return AppColors().fontColor;
    }
  }
}
