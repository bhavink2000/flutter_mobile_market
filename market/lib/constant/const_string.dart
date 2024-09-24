import 'package:intl/intl.dart';
import 'package:market/main.dart';
import 'package:market/modelClass/categoryDataModelClass.dart';
import 'package:market/modelClass/settingIntradayHistoryListModelClass.dart';
import 'package:market/modelClass/settingMessageListModelClass.dart';
import 'package:market/modelClass/settingPLListModelClass.dart';
import 'package:market/modelClass/settingScriptQuantityListModelClass.dart';
import 'package:market/modelClass/settingUserListModelClass.dart';
import 'package:market/modelClass/settingWeeklyAdminListModel.dart';

import '../modelClass/settingListModelClass.dart';
import 'assets.dart';

class AppString {
  static const String emptyServer = "Please Enter Server Name.";
  static const String invalidServer = "Please Enter Valid Server name.";
  static const String emptyUserName = "Please Enter User Name.";
  static const String emptyPassword = "Please Enter Your Password.";
  static const String emptyNewPassword = "Please Enter Your New Password.";
  static const String rangeUserName = "User Name Should Be Min 4 Characters.";
  static const String emptyQty = "Please Enter Quantity.";
  static const String inValidQty = "Please Enter valid Quantity.";
  static const String emptyPrice = "Please Enter Price.";
  static const String generalError = "Something Went Wrong.";
  static const String emptyName = "Please Enter Name.";
  static const String emptyRetypePassword = " Please Retype Your Password.";
  static const String emptyConfirmPasswords = "Please Retype Your Password in Confirm Password.";
  static const String emptyConfirmPassword = "Please Confirm Password.";
  static const String emptyMasterPassword = "Please Enter Master Password.";
  static const String incorrectPassword = "Your Password or Confirm Password is Incorrect.";
  static const String emptyAmount = "Please Enter Amount";
  static const String emptyMobileNumber = "Please Enter Mobile Number.";
  static const String emptyCutOff = "Please Enter Cut Off.";
  static const String emptyCredit = "Please Enter Credit.";
  static const String emptyLeverageDropDown = "Please Select Leverage.";
  static const String emptyRemark = "Please Enter Remark.";
  static const String emptyProfitandLoss = "Please Enter Profit and Loss Sharing.";
  static const String emptyBrkSharing = "Please Enter Brk Sharing.";
  static const String emptyUserType = "Please Select User Type.";
  static const String wrongPassword = "Password Should be Atleast 6 Characters.";
  static const String wrongRetypePassword = "Retype Password Should be Atleast 6 Characters.";
  static const String mobileNumberLength = "Mobile Number Should Not be Less than 10 Characters.";
  static const String cutOffValid = "Cut Off Should be Between 60% to 100%.";
  static const String passwordNotMatch = "Your Password and Retype Password Doesn't Match.";
  static const String emptyProfitLossSharing = "Please Enter Profit and Loss Sharing .";
  static const String rangeProfitLossSharing = "Profit and Loss Should be Between 0 to 100 %.";
  static const String emptyBrokerageSharing = "Please Enter Brokerage Sharing.";
  static const String rangeBrokerageSharing = "Brokerage Should be Between 0 to 100 %.";
  static const String exchangeGroupEmpty = "Select Group for";
  static const String accessRestricted = "You Don't Have Access";
  static const String emptyLotMax = "Please enter max lot";
  static const String emptyqtyMax = "Please enter quantity max";
  static const String emptybrkQty = "Please enter breakup quantity";
  static const String emptybrkLot = "Please enter breakup lot";
  static const String emptyScriptSelection = "Please select script";
  static const String emptyExchangeGroup = "Please select atleast one exchange group";
  static const String noAccessForManualOrder = "You are not authorized for manual order.";
  static const String emptyExchange = "Please select exchange.";
  static const String emptyScript = "Please select script.";
}

class localStorageKeys {
  static const String userToken = "userToken";
  static const String userId = "userId";
  static const String userData = "userData";
  static const String userType = "userType";
  static const String isDetailSciptOn = "isDetailSciptOn";
  static const String isDarkMode = "isDarkMode";
  static const String sleepTime = "sleepTime";
  static const String profitAndLossSharingDownLine = "profitAndLossSharingDownLine";
  static const String brkSharingDownLine = "brkSharingDownLine";
  static const String profitAndLossSharingUpLine = "profitAndLossSharingUpLine";
  static const String brkSharingUpLine = "brkSharingUpLine";
}

class TradeMarginClass {
  static const String isFromTradeMarginClass = "";
}

class CommonCustomDateSelection {
  List<String> arrCustomDate = <String>[];
  List<String> arrCustomDate1 = <String>[];

  CommonCustomDateSelection() {
    DateTime currentDate = DateTime.now();
    // Calculate the start and end dates for "This Week"
    DateTime thisWeekStartDate = currentDate.subtract(Duration(days: currentDate.weekday - 1));
    DateTime thisWeekEndDate = thisWeekStartDate.add(Duration(days: 6));
    // Calculate the start and end dates for "Previous Week"
    DateTime previousWeekEndDate = thisWeekStartDate.subtract(Duration(days: 1));
    DateTime previousWeekStartDate = previousWeekEndDate.subtract(Duration(days: 6));
    // Format the dates as strings
    String thisWeekDateRange = 'This Week \n${DateFormat('yyyy-MM-dd').format(thisWeekStartDate)} to ${DateFormat('yyyy-MM-dd').format(thisWeekEndDate)}';
    String previousWeekDateRange = 'Previous Week \n${DateFormat('yyyy-MM-dd').format(previousWeekStartDate)} to ${DateFormat('yyyy-MM-dd').format(previousWeekEndDate)}';

    // Initialize the arrCustomDate list
    arrCustomDate = <String>[thisWeekDateRange, previousWeekDateRange, 'Custom Period'];
  }

  CommonCustomDateSelection1() {
    DateTime currentDate = DateTime.now();
    // Calculate the start and end dates for "This Week"
    DateTime previusDay = currentDate.subtract(Duration(days: currentDate.day - 1));

    // Format the dates as strings
    String today = 'Today \n${DateFormat('yyyy-MM-dd').format(currentDate)}';
    String yesterday = 'Yesterday \n${DateFormat('yyyy-MM-dd').format(previusDay)}';

    // Initialize the arrCustomDate list
    arrCustomDate1 = <String>[today, yesterday, 'Custom Period'];
  }
}

class CommonCustomDateSelection1 {
  List<String> arrCustomDate = <String>[];

  CommonCustomDateSelection1() {
    DateTime currentDate = DateTime.now();
    // Calculate the start and end dates for "This Week"
    DateTime previusDay = currentDate.subtract(Duration(days: 1));

    // Format the dates as strings
    String today = 'Today \n${DateFormat('yyyy-MM-dd').format(currentDate)}';
    String yesterday = 'Yesterday \n${DateFormat('yyyy-MM-dd').format(previusDay)}';

    // Initialize the arrCustomDate list
    arrCustomDate = <String>[today, yesterday, 'Custom Period'];
  }
}

class CommonCustomUserSelection {
  final List<String> arrUserDatas = [
    'A_Item1',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];
}

class currentUserType {
  static const int user = 1;
  static const int recr = 2;
}

class settingListClass {
  List<GroupModel> arrSettingCategoryData = [
    if (userData!.role != UserRollList.user)
      GroupModel(name: "Account", items: [
        ItemModel(name: "Create New User", ImageName: AppImages.settingUser1),
        ItemModel(name: "User List", ImageName: AppImages.settingUser2),
        ItemModel(name: "Search User", ImageName: AppImages.settingUser3),
      ]),
    GroupModel(name: "Reports", items: [
      if (userData!.role == UserRollList.superAdmin) ItemModel(name: "Bulk Trade", ImageName: AppImages.settingUser4),
      ItemModel(name: "Account Report", ImageName: AppImages.settingUser4),
      ItemModel(name: "Generate Bill", ImageName: AppImages.settingUser5),
      // if (userData!.role != UserRollList.user) ItemModel(name: "Weekly Admin", ImageName: AppImages.settingUser6),
      // ItemModel(name: "Intraday History", ImageName: AppImages.settingUser7),
      // if (userData!.role != UserRollList.user) ItemModel(name: "P&L", ImageName: AppImages.settingUser8),
      // ItemModel(name: "M2M P&L", ImageName: AppImages.settingUser9),
      if (userData!.role != UserRollList.user) ItemModel(name: "Settlements Report", ImageName: AppImages.settingUser23),
      ItemModel(name: "Trade Margin", ImageName: AppImages.settingUser10),
      if (userData?.role == UserRollList.master || userData?.role == UserRollList.superAdmin) ItemModel(name: "Trade Logs", ImageName: AppImages.settingUser20),
      // ItemModel(name: "Script Master", ImageName: AppImages.settingUser18),
      if (userData!.role != UserRollList.user) ItemModel(name: "User Wise Position", ImageName: AppImages.settingUser21),
      // if (userData!.role != UserRollList.user) ItemModel(name: "Open Position", ImageName: AppImages.settingUser22),
      // ItemModel(name: "% Open Position", ImageName: AppImages.settingUser10),
      ItemModel(name: "Rejection Log", ImageName: AppImages.settingUser11),
      ItemModel(name: "Script Quantity", ImageName: AppImages.settingUser19),
      if (userData!.role != UserRollList.user) ItemModel(name: "Symbol Wise Position Report", ImageName: AppImages.settingUser19),
      if (userData!.role != UserRollList.user) ItemModel(name: "User Script Position Tracking", ImageName: AppImages.settingUser19),
      if (userData!.role != UserRollList.user) ItemModel(name: "Profit & Loss", ImageName: AppImages.settingUser19),
      if (userData!.role != UserRollList.user) ItemModel(name: "Credit History", ImageName: AppImages.settingUser19),
    ]),
    GroupModel(name: "Setting", items: [
      ItemModel(name: "Theme", ImageName: AppImages.moonIcon),
      ItemModel(name: "Market Timings", ImageName: AppImages.settingUser12),

      // ItemModel(
      //     name: "Set  Quantity Values", ImageName: AppImages.settingUser10),
      // ItemModel(name: "Messages", ImageName: AppImages.settingUser13),
      ItemModel(name: "Change Password", ImageName: AppImages.settingUser14),
      ItemModel(name: "Invite Friends", ImageName: AppImages.settingUser15),
      ItemModel(name: "Notification Settings", ImageName: AppImages.notificationIcon),
      ItemModel(name: "Login History", ImageName: AppImages.settingUser16),
      ItemModel(name: "Intraday History", ImageName: AppImages.settingUser16),
      ItemModel(name: "Profile", ImageName: AppImages.settingUser17),
      ItemModel(name: "Privacy Policy", ImageName: AppImages.settingUser4),
      ItemModel(name: "Terms & Conditions", ImageName: AppImages.settingUser4),
      ItemModel(name: "Contact Us", ImageName: AppImages.settingUser4),
      ItemModel(name: "Delete Account", ImageName: AppImages.settingUser4),
    ]),
  ];
}

class SearchUserListScreenClass {
  List<settingUserListModel> arrUserListDatas = [
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "30,540", credit: "500,000", profitPer: "0", userType: AppImages.userListImageClient),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImageClient),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
    settingUserListModel(name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage),
  ];
}

class SettingUserListScreenClass {
  List<settingUserListModel> arrUserListData = [
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)",
        Balance: "0",
        credit: "500,000",
        profitPer: "0",
        userType: AppImages.userListImage,
        tradetime: "2023-07-26 11:55:14.983",
        tradeClvalue: "443663.431",
        tradeLValue: "59411.0",
        tradePValue: "1",
        tradeRate: "100.0",
        tradetype: "MCX GOLD Aug 4",
        tradeTypes: "sell"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)",
        Balance: "0",
        credit: "500,000",
        profitPer: "0",
        userType: AppImages.userListImage,
        tradetime: "2023-07-26 11:55:14.983",
        tradeClvalue: "443663.431",
        tradeLValue: "59411.0",
        tradePValue: "1",
        tradeRate: "100.0",
        tradetype: "MCX GOLD Aug 4",
        tradeTypes: "sell"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jaycant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
    settingUserListModel(
        name: "MAN19 (Jayvant Jadhav)", Balance: "0", credit: "500,000", profitPer: "0", userType: AppImages.userListImage, tradetime: "2023-07-26 11:55:14.983", tradeClvalue: "443663.431", tradeLValue: "59411.0", tradePValue: "1", tradeRate: "100.0", tradetype: "MCX GOLD Aug 4", tradeTypes: "buy"),
  ];
}

class settingUserListDetailsClass {
  List<categoryDataModel> arrUserDetailsData = [
    categoryDataModel(name: "User Name", values: "MAN08", isMore: false, isSwitch: false),
    categoryDataModel(name: "Name", values: "59062", isMore: false, isSwitch: false),
    categoryDataModel(name: "Mobile Number", values: "2609", isMore: false, isSwitch: false),
    categoryDataModel(name: "City", values: "59121.63", isMore: false, isSwitch: false),
    categoryDataModel(name: "Remark", values: "18:12:55", isMore: false, isSwitch: false),
    categoryDataModel(name: "Create Date", values: "18:12:55", isMore: false, isSwitch: false),
    categoryDataModel(name: "Last Login", values: "18:12:55", isMore: false, isSwitch: false),
    categoryDataModel(name: "IP Address", values: "18:12:55", isMore: false, isSwitch: false),
    categoryDataModel(name: "Exchange", values: "18:12:55", isMore: false, isSwitch: false),
    categoryDataModel(name: "BET", values: "", isMore: false, isSwitch: true),
    categoryDataModel(name: "Status", values: "", isMore: false, isSwitch: true),
    categoryDataModel(name: "Close Only", values: "", isMore: false, isSwitch: true),
    categoryDataModel(name: "Margin Square Off", values: "", isMore: false, isSwitch: true),
    categoryDataModel(name: "Fresh Stop - Loss", values: "", isMore: false, isSwitch: true),
    categoryDataModel(name: "Credit", values: "-", isMore: false, isSwitch: false),
    categoryDataModel(name: "Group Quantity Settings", values: "", isMore: true, isSwitch: false),
    categoryDataModel(name: "Margin Square Off Settings", values: "97.0%", isMore: false, isSwitch: false),
    categoryDataModel(name: "Brk Setting", values: "", isMore: true, isSwitch: false),
    categoryDataModel(name: "Intraday SquareOff", values: "", isMore: true, isSwitch: false),
    categoryDataModel(name: "Trade Margin", values: "", isMore: true, isSwitch: false),
    categoryDataModel(name: "Sharing Details", values: "", isMore: true, isSwitch: false),
    categoryDataModel(name: "Change Password", values: "", isMore: true, isSwitch: false),
    categoryDataModel(name: "Add Order", values: "", isMore: true, isSwitch: false),
  ];
}

class settingWeeklyAdminClass {
  List<settingWeeklyAdmimListModel> settingWeeklyAdmimListData = [
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
    settingWeeklyAdmimListModel(userName: "MAN19 (Jayvant Jadhav)", releasePL: "0.00", MMPL: "0.00", totalPL: "0.00", adminProfit: "0.00", adminBrokerage: "0.00", totalAdminProfil: "0.00"),
  ];
}

class settingIntradayHistoryClass {
  List<settingIntradayHistoryListModel> arrSettingIntradayHistoryListData = [
    settingIntradayHistoryListModel(timing: "09:15:00", high: "1937.5", low: "1937.5", volume: "193789", open: "1937.5", close: "1937"),
    settingIntradayHistoryListModel(timing: "09:15:00", high: "1937.5", low: "1937.5", volume: "193789", open: "1937.5", close: "1937"),
    settingIntradayHistoryListModel(timing: "09:15:00", high: "1937.5", low: "1937.5", volume: "193789", open: "1937.5", close: "1937"),
    settingIntradayHistoryListModel(timing: "09:15:00", high: "1937.5", low: "1937.5", volume: "193789", open: "1937.5", close: "1937"),
    settingIntradayHistoryListModel(timing: "09:15:00", high: "1937.5", low: "1937.5", volume: "193789", open: "1937.5", close: "1937"),
    settingIntradayHistoryListModel(timing: "09:15:00", high: "1937.5", low: "1937.5", volume: "193789", open: "1937.5", close: "1937"),
    settingIntradayHistoryListModel(timing: "09:15:00", high: "1937.5", low: "1937.5", volume: "193789", open: "1937.5", close: "1937"),
    settingIntradayHistoryListModel(timing: "09:15:00", high: "1937.5", low: "1937.5", volume: "193789", open: "1937.5", close: "1937"),
    settingIntradayHistoryListModel(timing: "09:15:00", high: "1937.5", low: "1937.5", volume: "193789", open: "1937.5", close: "1937"),
    settingIntradayHistoryListModel(timing: "09:15:00", high: "1937.5", low: "1937.5", volume: "193789", open: "1937.5", close: "1937"),
  ];
}

class settingProfitLossClass {
  List<settingPLListModel> arrUserData = [
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
    settingPLListModel(userName: "MAN11", releasedPL: "0", MMPL: "0.00", total: "0"),
  ];
}

class settingScriptQuantityListClass {
  List<settingScriptQuantityListModel> arrsettingScriptQuantityListClass = [
    settingScriptQuantityListModel(symbol: "AARTIIND", brkQty: "500.0", maxQty: "1000.0", brkLot: "0.0", maxLot: "0.0"),
    settingScriptQuantityListModel(symbol: "ABBOTNDIAAAAAAA", brkQty: "500.0", maxQty: "1000.0", brkLot: "0.0", maxLot: "0.0"),
    settingScriptQuantityListModel(symbol: "ABBOTNDIA", brkQty: "500.0", maxQty: "1000.0", brkLot: "0.0", maxLot: "0.0"),
    settingScriptQuantityListModel(symbol: "ABBOTNDIA", brkQty: "500.0", maxQty: "1000.0", brkLot: "0.0", maxLot: "0.0"),
    settingScriptQuantityListModel(symbol: "ABBOTNDIA", brkQty: "500.0", maxQty: "1000.0", brkLot: "0.0", maxLot: "0.0"),
    settingScriptQuantityListModel(symbol: "ABBOTNDIA", brkQty: "500.0", maxQty: "1000.0", brkLot: "0.0", maxLot: "0.0"),
    settingScriptQuantityListModel(symbol: "ABBOTNDIA", brkQty: "500.0", maxQty: "1000.0", brkLot: "0.0", maxLot: "0.0"),
    settingScriptQuantityListModel(symbol: "ABBOTNDIA", brkQty: "500.0", maxQty: "1000.0", brkLot: "0.0", maxLot: "0.0"),
    settingScriptQuantityListModel(symbol: "ABBOTNDIA", brkQty: "500.0", maxQty: "1000.0", brkLot: "0.0", maxLot: "0.0"),
  ];
}

class SettingMessageListClass {
  List<settingMessageListModel> arrsettingMessageListModel = [
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
    settingMessageListModel(text: "New Contract Open 27th July Thursday MCX - GOLD AND GOLDM Current contract settle on 28th July, Friday ay last bid ask", date: "26-07-2023", time: "11:21:53"),
  ];
}

class UserRollList {
  static const String superAdmin = "64b63755c71461c502ea4713";
  static const String admin = "64b63755c71461c502ea4714";
  static const String master = "64b63755c71461c502ea4715";
  static const String broker = "64b63755c71461c502ea4716";
  static const String user = "64b63755c71461c502ea4717";
}
