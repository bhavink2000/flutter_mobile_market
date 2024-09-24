import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/constant/commonFunction.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/brokerListModelClass.dart';
import 'package:market/modelClass/constantModelClass.dart';
import 'package:market/modelClass/exchangeAllowModelClass.dart';
import 'package:market/modelClass/groupListModelClass.dart';
import 'package:market/modelClass/profileInfoModelClass.dart';
import 'package:number_to_indian_words/number_to_indian_words.dart';

import '../../../../constant/const_string.dart';
import '../../../../constant/utilities.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../../modelClass/userRoleListModelClass.dart';
import '../../../../navigation/routename.dart';
import '../../../BaseViewController/baseController.dart';

class SettingCreateNewUserControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingCreateNewUserController());
  }
}

class SettingCreateNewUserController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  TextEditingController userNameController = TextEditingController();
  FocusNode userNameFocus = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  TextEditingController retypeController = TextEditingController();
  FocusNode retypeFocus = FocusNode();
  TextEditingController numberController = TextEditingController();
  FocusNode numberFocus = FocusNode();
  TextEditingController cutOffController = TextEditingController();
  FocusNode cutOffFocus = FocusNode();
  TextEditingController creditController = TextEditingController();
  FocusNode creditFocus = FocusNode();
  TextEditingController remarkController = TextEditingController();
  FocusNode remarkFocus = FocusNode();
  TextEditingController profitController = TextEditingController();
  FocusNode profitFocus = FocusNode();
  TextEditingController brkController = TextEditingController();
  FocusNode brkFocus = FocusNode();
  RxBool isCutOffHasValue = false.obs;
  bool isDarkMode = false;
  List<String> clientNSElist = <String>['Master5', 'Client1'];
  List<String> clientMCXlist = <String>['Master2', 'Client2'];
  List<String> clientSGXlist = <String>['Master3', 'Client3'];
  List<String> arrLeverageSelection = <String>["AAAA", "BBBB"];
  List<String> arrBrokerSelection = <String>["AAAA", "BBBB"];
  List<String> arrMultiGroupSelection = <String>["AAAA", "BBBB"];
  Rx<userRoleListData> dropdownValue = userRoleListData().obs;
  RxString leverageSelectionValue = "".obs;
  RxString selectBrokerSelectionValue = "".obs;
  RxString selectedBrokerId = "".obs;
  RxString multiGroupSelectionValue = "".obs;
  String clientNSEValue = "";
  String clientMCXValue = "";
  String clientSGXValue = "";
  bool isEyeOpen = true;
  bool confirmIsEyeOpen = true;
  RxBool isSymbolWiseSL = false.obs;
  RxBool isFreshLimitSL = false.obs;

  FocusNode jobTypeFocus = FocusNode();

  bool masterExchNSE = false;
  bool masterExchMCX = false;
  bool masterExchSGX = false;
  bool NSE = false;
  bool MCX = false;
  bool SGX = false;

  bool clientExchNSE = false;
  bool clientExchMCX = false;
  bool clientExchSGX = false;
  bool clientTurnNSE = false;
  bool clientTurnMCX = false;
  bool clientTurnSGX = false;
  bool clientSymbolNSE = false;
  bool clientSymbolMCX = false;
  bool clientSymbolSGX = false;

  RxBool isAddMaster = false.obs;
  RxBool isChangePassword = false.obs;
  RxBool isModifyOrder = false.obs;
  RxBool isManualOrder = false.obs;
  RxBool isIntraday = false.obs;
  RxBool isSelectedallExchangeinMaster = false.obs;
  RxBool isAPICallRunning = false.obs;
  RxBool isUserDataLoadRunning = false.obs;
  List<ExchangeData> arrExchangeList = [];
  List<BrokerListModelData> arrBrokerList = [];
  List<groupListModelData> arrMastGroupListforOthers = [];
  List<groupListModelData> arrMastGroupListforNSE = [];
  List<groupListModelData> arrMastGroupListforMCX = [];
  RxString masterExchangeID = "".obs;
  List<ExchangeAllow> arrSelectedExchangeList = [];
  List<ExchangeAllowforMaster> arrSelectedExchangeListforMaster = [];
  List<String> arrSelectedMasterGroup = [];
  List<String> arrHighLowBetweenTradeSelectedList = [];
  List<String> arrSelectedGroupListIDforOthers = [];
  List<String> arrSelectedGroupListIDforNSE = [];
  List<String> arrSelectedGroupListIDforMCX = [];

  RxString selectedRoleId = "".obs;
  RxInt selectedLeverageID = 0.obs;
  UserData? arrUserDetailsData1;
  List<AddMaster> arrLeverageList = [];
  List<String> arrSelectedDropDownValueClient = [];
  RxBool isLoadingCreate = false.obs;
  var profitAndLossSharingDownLine;
  var brkSharingDownLine;
  var profitAndLossSharingUpLine;
  var brkSharingUpLine;
  ProfileInfoData? arrProfileData;
  Rx<BrokerListModelData> selectedBrokerType = BrokerListModelData().obs;

  TextEditingController brokerageSharingController = TextEditingController(text: "10");
  FocusNode brokerageSharingFocus = FocusNode();

  bool? isCmpOrder;
  bool? isAdminManualOrder;
  bool? isDeleteTrade;
  bool? isExecutePendingOrder;

  @override
  void onInit() async {
    super.onInit();
    dropdownValue.value = arrUserRoleList.first;
    // await callForRoleList();
    if (userData!.highLowSLLimitPercentage == true) {
      isSymbolWiseSL = true.obs;
    }
    profitAndLossSharingDownLine = await localStorage.read(localStorageKeys.profitAndLossSharingDownLine);
    brkSharingDownLine = await localStorage.read(localStorageKeys.brkSharingDownLine);

    profitAndLossSharingUpLine = await localStorage.read(localStorageKeys.profitAndLossSharingUpLine);
    brkSharingUpLine = await localStorage.read(localStorageKeys.brkSharingUpLine);
    isUserDataLoadRunning.value = true;
    update();
    await getExchangeList();
    await callForBrokerList();

    arrLeverageList = constantValues!.leverageList!;
    profitController.addListener(() {
      update();
    });
    brkController.addListener(() {
      update();
    });

    // profitController.text = await localStorage
    //     .read(localStorageKeys.profitAndLossSharingDownLine)
    //     .toString();
    // brkController.text =
    //     await localStorage.read(localStorageKeys.brkSharingDownLine).toString();
    // dropdownValue.value = "Client";
    clientNSEValue = clientNSElist.first;
    clientMCXValue = clientMCXlist.first;
    clientSGXValue = clientSGXlist.first;
    if (Get.arguments != null) {
      setUserData();
    } else {
      isUserDataLoadRunning.value = false;
      update();
    }

    // for (var index = 0; index < arrExchangeList.length; index++) {
    //   //API CALL FOR GROUP LIST
    //   if (arrExchangeList[index].isSelected == true) {
    //     arrExchangeList[index].arrGroupList =
    //         await callforGroupList(arrExchangeList[index].exchangeId);
    //   }
    // }
    // leverageSelectionValue.value = arrLeverageList.first.name!;
    update();
  }

  //*********************************************************************** */
  // Field Validation
  //*********************************************************************** */
  String validateFieldForUser() {
    var msg = "";

    if (dropdownValue.value.name == null) {
      msg = AppString.emptyUserType;
    } else if (nameController.text.trim().isEmpty) {
      msg = AppString.emptyName;
    } else if (userNameController.text.trim().isEmpty && arrUserDetailsData1 == null) {
      msg = AppString.emptyUserName;
    } else if (userNameController.text.length < 4 && arrUserDetailsData1 == null) {
      msg = AppString.rangeUserName;
    } else if (arrUserDetailsData1 == null) {
      if (passwordController.text.trim().isEmpty) {
        msg = AppString.emptyPassword;
      } else if (passwordController.text.trim().length < 6) {
        msg = AppString.wrongPassword;
      } else if (retypeController.text.trim().isEmpty) {
        msg = AppString.emptyConfirmPassword;
      } else if (retypeController.text.length < 6) {
        msg = AppString.wrongRetypePassword;
      } else if (passwordController.text.trim() != retypeController.text.trim()) {
        msg = AppString.passwordNotMatch;
      } else if (creditController.text.trim().isEmpty) {
        msg = AppString.emptyCredit;
      } else if (leverageSelectionValue.value.trim().isEmpty) {
        msg = AppString.emptyLeverageDropDown;
      } else if ((cutOffController.text.isNotEmpty && int.parse(cutOffController.text) < 60) || (cutOffController.text.isNotEmpty && int.parse(cutOffController.text) > 100)) {
        msg = AppString.cutOffValid;
      } else if (arrSelectedExchangeList.isEmpty) {
        msg = AppString.emptyExchangeGroup;
      } else if (selectedBrokerType.value.addMaster != null) {
        if (brokerageSharingController.text.trim().isEmpty) {
          msg = AppString.emptyBrokerageSharing;
        } else if (int.parse(brokerageSharingController.text) > 100) {
          msg = AppString.rangeBrokerageSharing;
        }
      }
    }
    // else if (numberController.text.trim().isEmpty) {
    //   msg = AppString.emptyMobileNumber;
    // } else if (numberController.text.trim().length < 9) {
    //   msg = AppString.mobileNumberLength;
    // }
    // else if (cutOffController.text.trim().isEmpty) {
    //   msg = AppString.emptyCutOff;
    // }
    else if ((cutOffController.text.isNotEmpty && int.parse(cutOffController.text) < 60) || (cutOffController.text.isNotEmpty && int.parse(cutOffController.text) > 100)) {
      msg = AppString.cutOffValid;
    } else if (creditController.text.trim().isEmpty) {
      msg = AppString.emptyCredit;
    } else if (arrSelectedExchangeList.isEmpty) {
      msg = AppString.emptyExchangeGroup;
    } else if (selectedBrokerType.value.addMaster != null) {
      if (brokerageSharingController.text.trim().isEmpty) {
        msg = AppString.emptyBrokerageSharing;
      } else if (int.parse(brokerageSharingController.text) > 100) {
        msg = AppString.rangeBrokerageSharing;
      }
    }
    return msg;
  }

  String validateFieldForBrocker() {
    var msg = "";

    if (dropdownValue.value.name == null) {
      msg = AppString.emptyUserType;
    } else if (nameController.text.trim().isEmpty) {
      msg = AppString.emptyName;
    } else if (userNameController.text.trim().isEmpty && arrUserDetailsData1 == null) {
      msg = AppString.emptyUserName;
    } else if (userNameController.text.length < 4 && arrUserDetailsData1 == null) {
      msg = AppString.rangeUserName;
    } else if (arrUserDetailsData1 == null) {
      if (passwordController.text.trim().isEmpty) {
        msg = AppString.emptyPassword;
      } else if (passwordController.text.trim().length < 6) {
        msg = AppString.wrongPassword;
      }
    }
    return msg;
  }

  String validateFieldForAdmin() {
    var msg = "";

    if (dropdownValue.value.name == null) {
      msg = AppString.emptyUserType;
    } else if (nameController.text.trim().isEmpty) {
      msg = AppString.emptyName;
    } else if (userNameController.text.trim().isEmpty && arrUserDetailsData1 == null) {
      msg = AppString.emptyUserName;
    } else if (userNameController.text.length < 4 && arrUserDetailsData1 == null) {
      msg = AppString.rangeUserName;
    } else if (arrUserDetailsData1 == null) {
      if (passwordController.text.trim().isEmpty) {
        msg = AppString.emptyPassword;
      } else if (passwordController.text.length < 6) {
        msg = AppString.wrongPassword;
      } else if (retypeController.text.trim().isEmpty) {
        msg = AppString.emptyConfirmPassword;
      } else if (retypeController.text.length < 6) {
        msg = AppString.wrongRetypePassword;
      } else if (passwordController.text.trim() != retypeController.text.trim()) {
        msg = AppString.passwordNotMatch;
      }
    } else if (numberController.text.trim().isEmpty) {
      msg = AppString.emptyMobileNumber;
    } else if (numberController.text.trim().length < 9) {
      msg = AppString.mobileNumberLength;
    }
    return msg;
  }

  String validateFieldForMaster() {
    var msg = "";

    if (dropdownValue.value.name == null) {
      msg = AppString.emptyUserType;
    } else if (nameController.text.trim().isEmpty) {
      msg = AppString.emptyName;
    } else if (userNameController.text.trim().isEmpty && arrUserDetailsData1 == null) {
      msg = AppString.emptyUserName;
    } else if (userNameController.text.length < 4 && arrUserDetailsData1 == null) {
      msg = AppString.rangeUserName;
    } else if (arrUserDetailsData1 == null) {
      if (passwordController.text.trim().isEmpty) {
        msg = AppString.emptyPassword;
      } else if (passwordController.text.length < 6) {
        msg = AppString.wrongPassword;
      } else if (retypeController.text.trim().isEmpty) {
        msg = AppString.emptyConfirmPassword;
      } else if (retypeController.text.length < 6) {
        msg = AppString.wrongRetypePassword;
      } else if (passwordController.text.trim() != retypeController.text.trim()) {
        msg = AppString.passwordNotMatch;
      } else if (creditController.text.trim().isEmpty) {
        msg = AppString.emptyCredit;
      } else if (leverageSelectionValue.value.trim().isEmpty) {
        msg = AppString.emptyLeverageDropDown;
      } else if (arrSelectedExchangeListforMaster.isEmpty) {
        msg = AppString.emptyExchangeGroup;
      } else if (profitController.text.trim().isEmpty) {
        msg = AppString.emptyProfitLossSharing;
      } else if (int.parse(profitController.text) > userData!.profitAndLossSharingDownLine!) {
        msg = "Profit and Loss should be between 0 to ${userData!.profitAndLossSharingDownLine!}";
      } else if (brkController.text.trim().isEmpty) {
        msg = AppString.emptyBrokerageSharing;
      } else if (int.parse(brkController.text) > userData!.brkSharingDownLine!) {
        msg = "Brokerage sharing should be between 0 to ${userData!.brkSharingDownLine!}";
      }
    } else if (creditController.text.trim().isEmpty) {
      msg = AppString.emptyCredit;
    } else if (arrSelectedExchangeListforMaster.isEmpty) {
      msg = AppString.emptyExchangeGroup;
    } else if (profitController.text.trim().isEmpty) {
      msg = AppString.emptyProfitLossSharing;
    } else if (int.parse(profitController.text) > userData!.profitAndLossSharingDownLine!) {
      msg = "Profit and Loss should be between 0 to ${userData!.profitAndLossSharingDownLine!}";
    } else if (brkController.text.trim().isEmpty) {
      msg = AppString.emptyBrokerageSharing;
    } else if (int.parse(brkController.text) > userData!.brkSharingDownLine!) {
      msg = "Brokerage sharing should be between 0 to ${userData!.brkSharingDownLine!}";
    }
    return msg;
  }

  //*********************************************************************** */
  // Api Calls
  //*********************************************************************** */

  onSubmitClicked() {
    arrSelectedExchangeList.clear();
    arrSelectedExchangeListforMaster.clear();
    for (var i = 0; i < arrExchangeList.length; i++) {
      for (var k = 0; k < arrExchangeList[i].arrGroupList.length; k++) {
        for (var l = 0; l < arrExchangeList[i].selectedItems.length; l++) {
          if (arrExchangeList[i].arrGroupList[k].name == arrExchangeList[i].selectedItems[l]) {
            if (!arrExchangeList[i].selectedItemsID.contains(arrExchangeList[i].arrGroupList[k].groupId!)) {
              arrExchangeList[i].selectedItemsID.add(arrExchangeList[i].arrGroupList[k].groupId!);
            }
          }
        }
        if (arrExchangeList[i].arrGroupList[k].name == arrExchangeList[i].isDropDownValueSelected.value) {
          if (!arrExchangeList[i].selectedItemsID.contains(arrExchangeList[i].arrGroupList[k].groupId!)) {
            arrExchangeList[i].selectedItemsID.add(arrExchangeList[i].arrGroupList[k].groupId!);
          }
        }
      }

      if (arrExchangeList[i].isSelected == true) {
        if (dropdownValue.value.roleId == UserRollList.master) {
          ExchangeAllowforMaster arrexchangeAllow = ExchangeAllowforMaster(
            exchangeId: arrExchangeList[i].exchangeId,
            groupId: arrExchangeList[i].selectedItemsID.toSet().toList(),
          );
          arrSelectedExchangeListforMaster.add(arrexchangeAllow);
        } else {
          ExchangeAllow arrexchangeAllow = ExchangeAllow(
            exchangeId: arrExchangeList[i].exchangeId,
            isTurnoverWise: arrExchangeList[i].isTurnOverSelected,
            isSymbolWise: arrExchangeList[i].isSymbolSelected,
            groupId: arrExchangeList[i].selectedItemsID.toSet().toList(),
          );
          arrSelectedExchangeList.add(arrexchangeAllow);
        }
      }
    }

    for (var i = 0; i < arrExchangeList.length; i++) {
      if (arrExchangeList[i].isHighLowTradeSelected! == true) {
        arrHighLowBetweenTradeSelectedList.add(arrExchangeList[i].exchangeId ?? "");
      }
    }
    for (var i = 0; i < arrUserRoleList.length; i++) {
      // ignore: unrelated_type_equality_checks
      if (arrUserRoleList[i].name! == dropdownValue.value.name) {
        selectedRoleId.value = arrUserRoleList[i].roleId!;
        update();
      }
    }
    for (var i = 0; i < arrLeverageList.length; i++) {
      // ignore: unrelated_type_equality_checks
      if (arrLeverageList[i].name! == leverageSelectionValue.value) {
        selectedLeverageID.value = arrLeverageList[i].id!;
        update();
      }
    }
    for (var i = 0; i < arrBrokerList.length; i++) {
      // ignore: unrelated_type_equality_checks
      if (arrBrokerList[i].name! == selectBrokerSelectionValue.value) {
        selectedBrokerId.value = arrBrokerList[i].userId ?? "";
        update();
      }
    }
    arrSelectedExchangeList = arrSelectedExchangeList.toSet().toList();
    arrSelectedExchangeList = arrSelectedExchangeList.toSet().toList();
    update();
    if (arrUserDetailsData1 != null) {
      if (dropdownValue.value.roleId == UserRollList.broker) {
        callForEditBrocker();
      } else if (dropdownValue.value.roleId == UserRollList.master) {
        callForEditMaster();
      } else if (dropdownValue.value.roleId == UserRollList.user) {
        callForEditUser();
      } else if (dropdownValue.value.roleId == UserRollList.admin) {
        callForEditAdmin();
      }
    } else {
      if (dropdownValue.value.roleId == UserRollList.broker) {
        callForCreateBrocker();
      } else if (dropdownValue.value.roleId == UserRollList.master) {
        callForCreateMaster();
      } else if (dropdownValue.value.roleId == UserRollList.user) {
        callForCreateUser();
      } else if (dropdownValue.value.roleId == UserRollList.admin) {
        callForCreateAdmin();
      }
    }
  }

  Future<List<groupListModelData>> callforGroupList(
    String? ExchangeId,
  ) async {
    update();
    var response = await service.getGroupListCall(ExchangeId);
    if (response != null) {
      if (response.statusCode == 200) {
        return response.data!;
      } else {
        showErrorToast(response.meta!.message ?? "", globalContext!);
        return [];
      }
    } else {
      showErrorToast(AppString.generalError, globalContext!);
      return [];
    }
  }

  callForCreateAdmin() async {
    var msg = validateFieldForAdmin();
    if (msg.isEmpty) {
      nameFocus.unfocus();
      userNameFocus.unfocus();
      passwordFocus.unfocus();
      retypeFocus.unfocus();
      numberFocus.unfocus();
      isAPICallRunning.value = true;
      update();
      var response = await service.createAdminCall(
        name: nameController.text.trim(),
        userName: userNameController.text.trim(),
        password: passwordController.text.trim(),
        phone: numberController.text.trim(),
        executePendingOrder: isExecutePendingOrder == null || isExecutePendingOrder == false ? 0 : 1,
        deleteTrade: isDeleteTrade == null || isDeleteTrade == false ? 0 : 1,
        manualOrder: isAdminManualOrder == null || isAdminManualOrder == false ? 0 : 1,
        cmpOrder: isCmpOrder == null || isCmpOrder == false ? 0 : 1,
        role: dropdownValue.value.roleId,
      );
      if (response != null) {
        if (response.statusCode == 200) {
          isAPICallRunning.value = false;
          Get.back();
          showSuccessToast(response.meta?.message ?? "", globalContext!);
          update();
        } else {
          showErrorToast(response.message ?? "", globalContext!);
          isAPICallRunning.value = false;
          update();
        }
      } else {
        showErrorToast(AppString.generalError, globalContext!);
        isAPICallRunning.value = false;
        update();
      }
    } else {
      showWarningToast(msg, globalContext!);
    }
  }

  callForEditAdmin() async {
    var msg = validateFieldForAdmin();
    if (msg.isEmpty) {
      nameFocus.unfocus();
      userNameFocus.unfocus();
      passwordFocus.unfocus();
      retypeFocus.unfocus();
      numberFocus.unfocus();
      isAPICallRunning.value = true;
      update();
      var response = await service.editAdminCall(
        name: nameController.text.trim(),
        userName: userNameController.text.trim(),
        phone: numberController.text.trim(),
        executePendingOrder: isExecutePendingOrder == null || isExecutePendingOrder == false ? 0 : 1,
        deleteTrade: isDeleteTrade == null || isDeleteTrade == false ? 0 : 1,
        manualOrder: isAdminManualOrder == null || isAdminManualOrder == false ? 0 : 1,
        cmpOrder: isCmpOrder == null || isCmpOrder == false ? 0 : 1,
      );
      isAPICallRunning.value = false;
      if (response != null) {
        if (response.statusCode == 200) {
          isAPICallRunning.value = false;
          Get.back();
          Get.back();

          showSuccessToast(response.meta?.message ?? "", globalContext!);
          update();
        } else {
          showErrorToast(response.message ?? "", globalContext!);
          isAPICallRunning.value = false;

          update();
        }
      } else {
        showErrorToast(AppString.generalError, globalContext!);
        isAPICallRunning.value = false;
        update();
      }
    } else {
      showWarningToast(msg, globalContext!);
    }
  }

  callForBrokerList() async {
    update();
    var response = await service.brokerListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrBrokerList = response.data!;
        print(arrBrokerList);
        print("Brocker List");
        update();
      } else {
        showErrorToast(response.meta!.message ?? "", globalContext!);
      }
    } else {
      showErrorToast(AppString.generalError, globalContext!);
      update();
    }
  }

  callForCreateBrocker() async {
    var msg = validateFieldForBrocker();
    if (msg.isEmpty) {
      nameFocus.unfocus();
      userNameFocus.unfocus();
      passwordFocus.unfocus();
      isAPICallRunning.value = true;
      update();
      var response = await service.createBrockerCall(
        name: nameController.text.trim(),
        userName: userNameController.text.trim(),
        password: passwordController.text.trim(),
        phone: numberController.text.trim(),
        changePassword: isChangePassword.value,
        role: selectedRoleId.value,
      );
      isAPICallRunning.value = false;
      if (response != null) {
        if (response.statusCode == 200) {
          Get.back();
          showSuccessToast(response.meta?.message ?? "", globalContext!);
          nameController.text = "";
          userNameController.text = "";
          passwordController.text = "";
          retypeController.text = "";
          numberController.text = "";
          cutOffController.text = "";
          creditController.text = "";
          remarkController.text = "";
          leverageSelectionValue.value = "1:10";
          profitController.text = "";
          brkController.text = "";
          isAddMaster.value = false;
          isModifyOrder.value = false;
          isManualOrder.value = false;
          isIntraday.value = false;
          isChangePassword.value = false;
          selectBrokerSelectionValue.value = "";
          for (var i = 0; i < arrExchangeList.length; i++) {
            if (arrExchangeList[i].isSelected == true) {
              arrExchangeList[i].isSelected = false;
            }
            if (arrExchangeList[i].isTurnOverSelected == true) {
              arrExchangeList[i].isTurnOverSelected = false;
            }
            if (arrExchangeList[i].isSymbolSelected == true) {
              arrExchangeList[i].isSymbolSelected = false;
            }
            if (arrExchangeList[i].isHighLowTradeSelected == true) {
              arrExchangeList[i].isHighLowTradeSelected = false;
            }
            if (arrExchangeList[i].isDropDownValueSelected.value != "") {
              arrExchangeList[i].isDropDownValueSelected.value = "";
            }
            if (arrExchangeList[i].selectedItems.isNotEmpty) {
              arrExchangeList[i].selectedItems.clear();
            }
          }
          arrSelectedGroupListIDforOthers.clear();
          arrSelectedGroupListIDforNSE.clear();
          arrSelectedGroupListIDforMCX.clear();
          arrSelectedDropDownValueClient.clear();
          arrSelectedExchangeList.clear();
          arrHighLowBetweenTradeSelectedList.clear();
          update();
        } else {
          showErrorToast(response.message ?? "", globalContext!);
          isAPICallRunning.value = false;
          arrSelectedExchangeList.clear();
          arrHighLowBetweenTradeSelectedList.clear();
          arrSelectedGroupListIDforOthers.clear();
          arrSelectedGroupListIDforNSE.clear();
          arrSelectedGroupListIDforMCX.clear();
          arrSelectedDropDownValueClient.clear();
          update();
        }
      } else {
        showErrorToast(AppString.generalError, globalContext!);
        isAPICallRunning.value = false;
        update();
      }
    } else {
      showWarningToast(msg, globalContext!);
    }
  }

  callForEditBrocker() async {
    var msg = validateFieldForBrocker();
    if (msg.isEmpty) {
      nameFocus.unfocus();
      userNameFocus.unfocus();
      passwordFocus.unfocus();
      isAPICallRunning.value = true;
      update();
      var response = await service.editBrokerCall(
        name: nameController.text.trim(),
        userName: userNameController.text.trim(),
        phone: numberController.text.trim(),
      );
      isAPICallRunning.value = false;
      if (response != null) {
        if (response.statusCode == 200) {
          Get.back();
          Get.back();

          // Get.offAndToNamed(RouterName.brkSettingScreen, arguments: {"userId": response.data!.userId!});

          update();
        } else {
          showErrorToast(response.message ?? "", globalContext!);
          isAPICallRunning.value = false;

          update();
        }
      } else {
        showErrorToast(AppString.generalError, globalContext!);
        isAPICallRunning.value = false;
        update();
      }
    } else {
      showWarningToast(msg, globalContext!);
    }
  }

  callForCreateUser() async {
    var msg = validateFieldForUser();
    if (msg.isEmpty) {
      nameFocus.unfocus();
      userNameFocus.unfocus();
      passwordFocus.unfocus();
      retypeFocus.unfocus();
      numberFocus.unfocus();
      cutOffFocus.unfocus();
      creditFocus.unfocus();
      remarkFocus.unfocus();
      brkFocus.unfocus();
      isAPICallRunning.value = true;
      update();
      var response = await service.createUserCall(
          name: nameController.text.trim(),
          userName: userNameController.text.trim(),
          password: passwordController.text.trim(),
          phone: numberController.text.trim(),
          role: selectedRoleId.value,
          credit: int.tryParse(creditController.text.trim()),
          cutOff: int.tryParse(cutOffController.text.trim()) ?? 0,
          leverage: selectedLeverageID.value,
          remark: remarkController.text.trim(),
          exchangeAllow: arrSelectedExchangeList,
          freshLimitSL: isFreshLimitSL.value,
          highLowBetweenTradeLimits: arrHighLowBetweenTradeSelectedList,
          autoSquareOff: isAddMaster.value ? 1 : 0,
          modifyOrder: isModifyOrder.value ? 1 : 0,
          symbolWiseSL: isSymbolWiseSL.value,
          closeOnly: isManualOrder.value,
          intraday: isIntraday.value ? 1 : 0,
          // brokerId: selectedBrokerId.value,
          // brkSharingDownLine: int.tryParse(brkController.text.trim()) ?? 0,
          changePassword: isChangePassword.value);
      isAPICallRunning.value = false;
      if (response != null) {
        if (response.statusCode == 200) {
          // Get.back();
          showSuccessToast(response.meta?.message ?? "", globalContext!);
          Get.offAndToNamed(RouterName.brkSettingScreen, arguments: {"userId": response.data!.userId!});
          // nameController.text = "";
          // userNameController.text = "";
          // passwordController.text = "";
          // retypeController.text = "";
          // numberController.text = "";
          // cutOffController.text = "";
          // creditController.text = "";
          // remarkController.text = "";
          // leverageSelectionValue.value = "";
          // profitController.text = "";
          // brkController.text = "";
          // isAddMaster.value = false;
          // isModifyOrder.value = false;
          // isManualOrder.value = false;
          // isIntraday.value = false;
          // isChangePassword.value = false;
          // selectBrokerSelectionValue.value = "";
          // for (var i = 0; i < arrExchangeList.length; i++) {
          //   if (arrExchangeList[i].isSelected == true) {
          //     arrExchangeList[i].isSelected = false;
          //   }
          //   if (arrExchangeList[i].isTurnOverSelected == true) {
          //     arrExchangeList[i].isTurnOverSelected = false;
          //   }
          //   if (arrExchangeList[i].isSymbolSelected == true) {
          //     arrExchangeList[i].isSymbolSelected = false;
          //   }
          //   if (arrExchangeList[i].isHighLowTradeSelected == true) {
          //     arrExchangeList[i].isHighLowTradeSelected = false;
          //   }
          //   if (arrExchangeList[i].isDropDownValueSelected.value != "") {
          //     arrExchangeList[i].isDropDownValueSelected.value = "";
          //   }
          //   if (arrExchangeList[i].selectedItems.isNotEmpty) {
          //     arrExchangeList[i].selectedItems.clear();
          //   }
          // }
          // arrSelectedGroupListIDforOthers.clear();
          // arrSelectedGroupListIDforNSE.clear();
          // arrSelectedGroupListIDforMCX.clear();
          // arrSelectedDropDownValueClient.clear();
          // arrSelectedExchangeList.clear();
          // arrHighLowBetweenTradeSelectedList.clear();
          update();
        } else {
          showErrorToast(response.message ?? "", globalContext!);
          isAPICallRunning.value = false;
          arrSelectedExchangeList.clear();
          arrHighLowBetweenTradeSelectedList.clear();
          arrSelectedGroupListIDforOthers.clear();
          arrSelectedGroupListIDforNSE.clear();
          arrSelectedGroupListIDforMCX.clear();
          arrSelectedDropDownValueClient.clear();
          update();
        }
      } else {
        showErrorToast(AppString.generalError, globalContext!);
        isAPICallRunning.value = false;
        update();
      }
    } else {
      showWarningToast(msg, globalContext!);
    }
  }

  callForEditUser() async {
    var msg = validateFieldForUser();
    if (msg.isEmpty) {
      nameFocus.unfocus();
      userNameFocus.unfocus();
      passwordFocus.unfocus();
      retypeFocus.unfocus();
      numberFocus.unfocus();
      cutOffFocus.unfocus();
      creditFocus.unfocus();
      remarkFocus.unfocus();
      profitFocus.unfocus();
      brkFocus.unfocus();
      isAPICallRunning.value = true;
      update();
      var response = await service.editUserCall(
          userId: arrUserDetailsData1!.userId,
          name: nameController.text.trim(),
          phone: numberController.text.trim(),
          cutOff: cutOffController.text.trim().isEmpty ? 0 : int.tryParse(cutOffController.text.trim()),
          remark: remarkController.text.trim(),
          exchangeAllow: arrSelectedExchangeList,
          highLowBetweenTradeLimits: arrHighLowBetweenTradeSelectedList,
          autoSquareOff: isAddMaster.value ? 1 : 0,
          modifyOrder: isModifyOrder.value ? 1 : 0,
          symbolWiseSL: isSymbolWiseSL.value,
          freshLimitSL: isFreshLimitSL.value);
      if (response != null) {
        if (response.statusCode == 200) {
          Get.back();
          Get.back();

          showSuccessToast(response.meta?.message ?? "", globalContext!);

          // Get.offAndToNamed(RouterName.brkSettingScreen, arguments: {"userId": response.data!.userId!});
        } else {
          isAPICallRunning.value = false;
          update();
          showErrorToast(response.meta?.message ?? response.message ?? "", globalContext!);
        }
      } else {
        showErrorToast(AppString.generalError, globalContext!);
        update();
      }
    } else {
      showWarningToast(msg, globalContext!);
    }
  }

  callForCreateMaster() async {
    var msg = validateFieldForMaster();
    if (msg.isEmpty) {
      nameFocus.unfocus();
      userNameFocus.unfocus();
      passwordFocus.unfocus();
      retypeFocus.unfocus();
      numberFocus.unfocus();
      creditFocus.unfocus();
      remarkFocus.unfocus();
      profitFocus.unfocus();
      brkFocus.unfocus();
      isAPICallRunning.value = true;
      update();
      var response = await service.createMasterCall(
        name: nameController.text.trim(),
        userName: userNameController.text.trim(),
        password: passwordController.text.trim(),
        phone: numberController.text.trim(),
        role: selectedRoleId.value,
        profitandLossSharingDownline: (userData!.profitAndLossSharingDownLine! - (num.tryParse(profitController.text) ?? 0)).toInt(),
        brkSharingDownline: (userData!.brkSharingDownLine! - (num.tryParse(brkController.text) ?? 0)).toInt(),
        credit: int.tryParse(creditController.text.trim()),
        leverage: selectedLeverageID.value,
        remark: remarkController.text.trim(),
        exchangeAllow: arrSelectedExchangeListforMaster,
        marketOrder: isManualOrder.value ? 1 : 0,
        highLowBetweenTradeLimits: arrHighLowBetweenTradeSelectedList,
        manualOrder: isManualOrder.value ? 1 : 0,
        addMaster: isAddMaster.value ? 1 : 0,
        symbolWiseSL: isSymbolWiseSL.value,
        modifyOrder: isModifyOrder.value ? 1 : 0,
        profitandLossSharing: int.tryParse(profitController.text.trim()),
        brkSharing: int.tryParse(brkController.text.trim()),
        changePassword: isChangePassword.value,
      );
      isAPICallRunning.value = false;
      if (response != null) {
        if (response.statusCode == 200) {
          showSuccessToast(response.meta?.message ?? "", globalContext!);
          Get.offAndToNamed(RouterName.brkSettingScreen, arguments: {"userId": response.data!.userId!});

          // nameController.text = "";
          // userNameController.text = "";
          // passwordController.text = "";
          // retypeController.text = "";
          // numberController.text = "";
          // cutOffController.text = "";
          // creditController.text = "";
          // remarkController.text = "";
          // leverageSelectionValue.value = "";
          // profitController.text = "";
          // brkController.text = "";
          // isAddMaster.value = false;
          // isModifyOrder.value = false;
          // isManualOrder.value = false;
          // isIntraday.value = false;
          // isChangePassword.value = false;
          // selectBrokerSelectionValue.value = "";
          // for (var i = 0; i < arrExchangeList.length; i++) {
          //   if (arrExchangeList[i].isSelected == true) {
          //     arrExchangeList[i].isSelected = false;
          //   }
          //   if (arrExchangeList[i].isTurnOverSelected == true) {
          //     arrExchangeList[i].isTurnOverSelected = false;
          //   }
          //   if (arrExchangeList[i].isSymbolSelected == true) {
          //     arrExchangeList[i].isSymbolSelected = false;
          //   }
          //   if (arrExchangeList[i].isHighLowTradeSelected == true) {
          //     arrExchangeList[i].isHighLowTradeSelected = false;
          //   }
          //   if (arrExchangeList[i].isDropDownValueSelected.value != "") {
          //     arrExchangeList[i].isDropDownValueSelected.value = "";
          //   }
          //   if (arrExchangeList[i].selectedItems.isNotEmpty) {
          //     arrExchangeList[i].selectedItems.clear();
          //   }
          // }
          // arrSelectedGroupListIDforOthers.clear();
          // arrSelectedGroupListIDforNSE.clear();
          // arrSelectedGroupListIDforMCX.clear();
          // arrSelectedDropDownValueClient.clear();
          // arrSelectedExchangeList.clear();
          // arrHighLowBetweenTradeSelectedList.clear();
          // update();
          // update();
        } else {
          showErrorToast(response.message ?? "", globalContext!);
          isAPICallRunning.value = false;
          arrSelectedExchangeList.clear();
          arrHighLowBetweenTradeSelectedList.clear();
          arrSelectedGroupListIDforOthers.clear();
          arrSelectedGroupListIDforNSE.clear();
          arrSelectedGroupListIDforMCX.clear();
          arrSelectedDropDownValueClient.clear();
          update();
        }
      } else {
        showErrorToast(AppString.generalError, globalContext!);
        isAPICallRunning.value = false;
        update();
      }
    } else {
      showWarningToast(msg, globalContext!);
    }
  }

  callForEditMaster() async {
    var msg = validateFieldForMaster();
    if (msg.isEmpty) {
      nameFocus.unfocus();
      userNameFocus.unfocus();
      passwordFocus.unfocus();
      numberFocus.unfocus();
      creditFocus.unfocus();
      remarkFocus.unfocus();
      isAPICallRunning.value = true;
      update();
      var response = await service.editMasterCall(
        userId: arrUserDetailsData1!.userId,
        name: nameController.text.trim(),
        phone: numberController.text.trim(),
        remark: remarkController.text.trim(),
        symbolWiseSL: isSymbolWiseSL.value,
        exchangeAllow: arrSelectedExchangeListforMaster,
        highLowBetweenTradeLimits: arrHighLowBetweenTradeSelectedList,
        marketOrder: isManualOrder.value ? 1 : 0,
        addMaster: isAddMaster.value ? 1 : 0,
      );

      if (response != null) {
        if (response.statusCode == 200) {
          isAPICallRunning.value = false;

          Get.back();
          Get.back();
          showSuccessToast(response.meta?.message ?? "", globalContext!);
          // Get.offAndToNamed(RouterName.brkSettingScreen, arguments: {"userId": response.data!.userId!});
          // arrUserDetailsData1 = null;
          // Get.find<UserListController>().updateUser();

          update();
        } else {
          isAPICallRunning.value = false;
          showErrorToast(response.message ?? "", globalContext!);
          update();
        }
      } else {
        showErrorToast(AppString.generalError, globalContext!);
        isAPICallRunning.value = false;
        update();
      }
    } else {
      isAPICallRunning.value = false;
      showWarningToast(msg, globalContext!);
    }
  }

  getExchangeList() async {
    var response = await service.getExchangeListUserWiseCall(userId: userData!.userId!);
    if (response != null) {
      if (response.statusCode == 200) {
        arrExchangeList = response.exchangeData ?? [];
        arrExchangeList.removeAt(0);
        for (var i = 0; i < arrExchangeList.length; i++) {
          var arrGropList = await callforGroupList(arrExchangeList[i].exchangeId);
          arrGropList.forEach((element) {
            arrExchangeList[i].arrGroupList.addIf(!arrExchangeList[i].arrGroupList.contains(element), element);
          });
        }
        update();
      }
    }
  }

  //*********************************************************************** */
  // General Functions
  //*********************************************************************** */
  String numericToWord() {
    var word = "";

    word = NumToWords.convertNumberToIndianWords(int.parse(creditController.text)).toUpperCase();

    // word.replaceAll("MILLION", "LAC.");
    // word.replaceAll("BILLION", "CR.");

    return word;
  }

  setUserData() {
    arrUserDetailsData1 = Get.arguments["isFromUserDetail"];
    update();
    dropdownValue.value = arrUserRoleList.firstWhere((element) => element.name == arrUserDetailsData1!.roleName);
    nameController.text = arrUserDetailsData1?.name ?? "";
    userNameController.text = arrUserDetailsData1?.userName ?? "";
    numberController.text = arrUserDetailsData1?.phone ?? "";
    creditController.text = arrUserDetailsData1?.credit.toString() ?? "";
    profitController.text = arrUserDetailsData1?.profitAndLossSharing.toString() ?? "";
    brkController.text = arrUserDetailsData1?.brkSharing.toString() ?? "";
    isChangePassword.value = arrUserDetailsData1?.changePasswordOnFirstLogin ?? false;
    remarkController.text = arrUserDetailsData1?.remark ?? "";
    cutOffController.text = arrUserDetailsData1!.cutOff! > 0 ? arrUserDetailsData1?.cutOff.toString() ?? "" : "";
    selectedLeverageID.value = arrLeverageList.indexWhere((element) => element.name == arrUserDetailsData1!.leverage);
    if (arrUserDetailsData1!.role == UserRollList.master) {
      isAddMaster.value = arrUserDetailsData1!.addMaster == 1 ? true : false;
      // isCloseOnly = arrUserDetailsData1!.marketOrder == 1 ? true : false;
      // profitController.text = arrUserDetailsData1!.profitAndLossSharing.toString();
      isFreshLimitSL.value = arrUserDetailsData1?.freshLimitSL ?? false;
      // brkController.text = arrUserDetailsData1!.brkSharing.toString();
      if (arrUserDetailsData1!.highLowBetweenTradeLimit != null) {
        for (var element in arrUserDetailsData1!.highLowBetweenTradeLimit!) {
          for (var i = 0; i < arrExchangeList.length; i++) {
            if (arrExchangeList[i].exchangeId == element) {
              arrExchangeList[i].isHighLowTradeSelected = true;
            }
          }
        }
      }
      if (arrUserDetailsData1!.exchangeAllow != null) {
        for (var i = 0; i < arrUserDetailsData1!.exchangeAllow!.length; i++) {
          for (var j = 0; j < arrExchangeList.length; j++) {
            if (arrExchangeList[j].exchangeId == arrUserDetailsData1!.exchangeAllow![i].exchangeId) {
              arrExchangeList[j].isSelected = true;
              for (var l = 0; l < arrExchangeList[j].arrGroupList.length; l++) {
                for (var k = 0; k < arrUserDetailsData1!.exchangeAllow![i].groupId!.length; k++) {
                  if (arrExchangeList[j].arrGroupList[l].groupId == arrUserDetailsData1!.exchangeAllow![i].groupId![k]) {
                    if (!arrExchangeList[j].selectedItems.contains(arrExchangeList[j].arrGroupList[l].name!)) {
                      arrExchangeList[j].selectedItems.add(arrExchangeList[j].arrGroupList[l].name!);
                    }
                  }
                }
              }
            }
          }
        }
      }
      if (arrExchangeList.every((exchange) => exchange.isSelected)) {
        isSelectedallExchangeinMaster.value = true;
      }
      if (userData!.highLowSLLimitPercentage == true) {
        isSymbolWiseSL.value = true;
      }
      update();
    } else if (arrUserDetailsData1!.role == UserRollList.user) {
      isAddMaster.value = arrUserDetailsData1!.autoSquareOff == 1 ? true : false;
      if (arrUserDetailsData1!.highLowBetweenTradeLimit != null) {
        for (var element in arrUserDetailsData1!.highLowBetweenTradeLimit!) {
          for (var i = 0; i < arrExchangeList.length; i++) {
            if (arrExchangeList[i].exchangeId == element) {
              arrExchangeList[i].isHighLowTradeSelected = true;
            }
          }
        }
      }
      if (arrUserDetailsData1 != null && arrUserDetailsData1!.exchangeAllow != null) {
        for (var i = 0; i < arrUserDetailsData1!.exchangeAllow!.length; i++) {
          var currentExchangeId = arrUserDetailsData1!.exchangeAllow![i].exchangeId;
          var groupId = arrUserDetailsData1!.exchangeAllow![i].groupId?[0];
          for (var j = 0; j < arrExchangeList.length; j++) {
            if (arrExchangeList[j].exchangeId == currentExchangeId) {
              arrExchangeList[j].isSelected = true;
              arrExchangeList[j].isTurnOverSelected = arrUserDetailsData1!.exchangeAllow![i].isTurnoverWise;
              arrExchangeList[j].isSymbolSelected = arrUserDetailsData1!.exchangeAllow![i].isSymbolWise;

              if (groupId != null) {
                int index = arrExchangeList[j].arrGroupList.indexWhere((item) => item.groupId == groupId);
                if (index != -1) {
                  arrExchangeList[j].isDropDownValueSelected.value = arrExchangeList[j].arrGroupList[index].name!;
                } else {
                  arrExchangeList[i].isDropDownValueSelected.value = "";
                }
              } else {
                arrExchangeList[i].isDropDownValueSelected.value = "";
              }
            }
          }
        }
      }

      if (arrExchangeList.every((exchange) => exchange.isSelected)) {
        isSelectedallExchangeinMaster.value = true;
      }
      if (userData!.highLowSLLimitPercentage == true) {
        isSymbolWiseSL.value = true;
      }

      update();
    }
    if (arrUserDetailsData1!.role == UserRollList.admin) {
      isCmpOrder = arrUserDetailsData1!.cmpOrder == 1;
      isAdminManualOrder = arrUserDetailsData1!.manualOrder == 1;
      isDeleteTrade = arrUserDetailsData1!.deleteTrade == 1;
      isExecutePendingOrder = arrUserDetailsData1!.executePendingOrder == 1;
      update();
    }
    isUserDataLoadRunning.value = false;
    update();
  }
}
