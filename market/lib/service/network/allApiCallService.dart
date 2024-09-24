// ignore_for_file: unused_local_variable
import 'dart:developer';
import 'dart:io';

import 'package:market/modelClass/addSymbolToTabModelClass.dart';
import 'package:market/modelClass/allSymbolListModelClass.dart';
import 'package:market/modelClass/billGenerateModelClass.dart';
import 'package:market/modelClass/brokerListModelClass.dart';
import 'package:market/modelClass/changePasswordModelClass.dart';
import 'package:market/modelClass/commonModelClass.dart';
import 'package:market/modelClass/createUserModelClass.dart';
import 'package:market/modelClass/exchangeAllowModelClass.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/modelClass/groupListModelClass.dart';
import 'package:market/modelClass/groupSettingListModelClass.dart';
import 'package:market/modelClass/m2mProfitLossDataModelClass.dart';
import 'package:market/modelClass/marketTimingModelClass.dart';
import 'package:market/modelClass/positionModelClass.dart';
import 'package:market/modelClass/profileInfoModelClass.dart';
import 'package:market/modelClass/profitLossListModelClass.dart';
import 'package:market/modelClass/quantitySettingListMmodelClass.dart';
import 'package:market/modelClass/rejectLogLisTModelClass.dart';
import 'package:market/modelClass/scriptQuantityModelClass.dart';
import 'package:market/modelClass/serverNameModelClass.dart';
import 'package:market/modelClass/settingAccountSummaryModelClass.dart';
import 'package:market/modelClass/settingUserWiseNetpositionModelClass.dart';
import 'package:market/modelClass/signInModelClass.dart';
import 'package:market/modelClass/tabListModelClass.dart';
import 'package:market/modelClass/userLoginHistoryModelClass.dart';
import 'package:market/modelClass/userRoleListModelClass.dart';
import 'package:market/modelClass/userwiseBrokerageListModelClass.dart';
import 'package:path_provider/path_provider.dart';

import '../../main.dart';

import '../../modelClass/accountSummaryNewListModelClass.dart';
import '../../modelClass/bulkTradeModelClass.dart';
import '../../modelClass/constantModelClass.dart';
import '../../modelClass/creditListModelClass.dart';
import '../../modelClass/holidayListModelClass.dart';
import '../../modelClass/myTradeListModelClass.dart';
import '../../modelClass/myUserListModelClass.dart';
import '../../modelClass/notificationListModelClass.dart';
import '../../modelClass/notificationSettingModelClass.dart';
import '../../modelClass/positionTrackListModelClass.dart';
import '../../modelClass/settelementListModelClass.dart';
import '../../modelClass/squareOffPositionRequestModelClass.dart';
import '../../modelClass/tabWiseSymbolListModelClass.dart';
import '../../modelClass/tradeDetailModelClass.dart';
import '../../modelClass/tradeExecuteModelClass.dart';
import '../../modelClass/tradeLogsModelClass.dart';
import '../../modelClass/tradeMarginListModelClass.dart';
import '../../modelClass/userWiseProfitLossSummaryModelClass.dart';
import 'api.dart';
import 'apiService.dart';

class AllApiCallService {
  static final _dio = ApiService.dio;

  Future<ConstantListModel?> getConstantCall() async {
    try {
      _dio.options.headers = getHeaders();

      final data = await _dio.post(Api.getConstant, data: null);
      print(data.data);
      return ConstantListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<ServerNameModel?> getServerNameCall() async {
    try {
      _dio.options.headers = getHeaders();

      final data = await _dio.get(Api.getServerName);
      print(data.data);
      return ServerNameModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<LoginModel?> signInCall({String? userName, String? password, String? serverName}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "userName": userName,
        "password": password,
        "serverName": serverName,
        "deviceToken": fcmToken ?? "xxxxx",
        "loginBy": deviceName,
        "ip": myIpAddress,
        'deviceId': Platform.isAndroid ? androidInfo?.id ?? "AndroidDevice" : iOsInfo?.identifierForVendor ?? "iOsDeivce",
        "systemToken": "",
        "deviceType": Platform.isAndroid ? "Android" : "iOS"
      };

      final data = await _dio.post(Api.login, data: payload);
      print(data.data);
      return LoginModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<TradeExecuteModel?> tradeCall({String? symbolId, double? quantity, double? totalQuantity, double? price, int? lotSize, String? orderType, String? tradeType, String? exchangeId, bool? isFromStopLoss, double? marketPrice, String? productType, double? refPrice}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "symbolId": symbolId,
        "quantity": quantity,
        "totalQuantity": totalQuantity! < 0 ? (totalQuantity * -1) : totalQuantity,
        "price": orderType == "limit" ? price : marketPrice,
        "lotSize": lotSize,
        "stopLoss": isFromStopLoss == true ? price : "0",
        "orderType": orderType,
        "tradeType": tradeType,
        "exchangeId": exchangeId,
        "productType": productType,
        "ipAddress": myIpAddress,
        'deviceId': deviceId,
        "orderMethod": deviceName,
        "referencePrice": refPrice
      };

      log(payload.toString());
      final data = await _dio.post(Api.createTrade, data: payload);
      print(data.data);
      return TradeExecuteModel.fromJson(data.data);
    } catch (e) {
      print(e);
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<TradeExecuteModel?> manualTradeCall({String? userId, String? symbolId, double? quantity, double? totalQuantity, double? price, int? lotSize, String? orderType, String? tradeType, String? exchangeId, String? executionTime, String? manuallyTradeAddedFor, double? refPrice}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "userId": userId,
        "symbolId": symbolId,
        "quantity": quantity,
        "totalQuantity": totalQuantity,
        "price": price,
        "stopLoss": 0,
        "lotSize": lotSize,
        "orderType": "market",
        "tradeType": tradeType,
        "exchangeId": exchangeId,
        "productType": "longTerm",
        "ipAddress": myIpAddress,
        "deviceId": deviceId,
        "orderMethod": deviceName,
        "executionDateTime": executionTime,
        "manuallyTradeAddedFor": manuallyTradeAddedFor,
        "referencePrice": refPrice
      };
      print(payload);
      final data = await _dio.post(Api.manualOrderCreate, data: payload);
      //print(data.data);
      return TradeExecuteModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<MyTradeListModel?> getMyTradeListCall({
    String? status,
    String? tradeStatus,
    int? page,
    String? text,
    String? userId,
    String? symbolId,
    String? exchangeId,
    String? startDate,
    String? endDate,
    String? orderType,
    String? tradeTypeFilter,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "status": status,
        "page": page,
        "limit": 20,
        "search": text,
        "userId": userId ?? "",
        "symbolId": symbolId ?? "",
        "exchangeId": exchangeId ?? "",
        "startDate": startDate,
        "endDate": endDate,
        "orderTypeFilter": orderType,
        "tradeStatusFilter": tradeStatus,
        "tradeTypeFilter": tradeTypeFilter,
      };
      print(payload);
      final data = await _dio.post(Api.myTradeList, data: payload);
      print(data.data);
      return MyTradeListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<TradeExecuteModel?> modifyTradeCall({String? symbolId, double? quantity, double? totalQuantity, double? price, double? lotSize, String? orderType, String? tradeType, String? exchangeId, double? marketPrice, String? productType, String? tradeId, double? refPrice}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "tradeId": tradeId,
        "symbolId": symbolId,
        "quantity": quantity,
        "totalQuantity": totalQuantity,
        "price": marketPrice,
        "lotSize": lotSize,
        "stopLoss": "0",
        "orderType": orderType,
        "tradeType": tradeType,
        "exchangeId": exchangeId,
        "productType": productType,
        "ipAddress": myIpAddress,
        'deviceId': deviceId,
        "orderMethod": deviceName,
        "referencePrice": refPrice
      };
      print(payload);
      final data = await _dio.post(Api.modifyTrade, data: payload);
      print("--------------------------------");
      print(data.data);
      return TradeExecuteModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<TradeMarginListModel?> tradeMarginListCall({
    int? page,
    String? text,
    String? exchangeId,
    String? userId,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "page": page,
        "limit": 20,
        "search": text,
        "userId": userId,
        "sortKey": "createdAt",
        "sortBy": -1,
        "exchangeId": exchangeId,
      };

      final data = await _dio.post(Api.tradeMargin, data: payload);
      //print(data.data);
      return TradeMarginListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<AccountSummaryNewListModel?> accountSummaryNewListCall(
    int page,
    String search, {
    String userId = "",
    String exchangeId = "",
    String symbolId = "",
    String startDate = "",
    String endDate = "",
    String productType = "",
  }) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {
        "page": page,
        "limit": 50,
        "search": search,
        "userId": userId,
        "startDate": startDate,
        "endDate": endDate,
        "symbolId": symbolId,
        "exchangeId": exchangeId,
        "productType": productType,
      };
      print(payload);
      final data = await _dio.post(Api.accountSummaryNewList, data: payload);
      print(data.data);
      return AccountSummaryNewListModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<UserWiseProfitLossSummaryModel?> userWiseProfitLossListCall(int page, String search, String userId) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {"page": page, "limit": 20, "search": search, "userId": userId};
      final data = await _dio.post(Api.userWiseProfitLoss, data: payload);
      //print(data.data);
      return UserWiseProfitLossSummaryModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }
  Future<AccountSummaryNewListModel?> symbolWisePositionListCall(
    int page,
    String search, {
    String userId = "",
    String exchangeId = "",
    String symbolId = "",
    String startDate = "",
    String endDate = "",
    String productType = "",
  }) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {
        "page": page,
        "limit": 50,
        "search": search,
        "userId": userId,
        "startDate": startDate,
        "endDate": endDate,
        "symbolId": symbolId,
        "exchangeId": exchangeId,
        "productType": productType,
      };
      print(payload);
      final data = await _dio.post(Api.symbolWisePositionReport, data: payload);
      print(data.data);
      return AccountSummaryNewListModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<ScriptQuantityModel?> getScriptQuantityListCall({String? text, String? userId, String? groupId, int? page}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {"page": page, "limit": 20, "search": text, "sortKey": "createdAt", "sortBy": -1, "userId": userId, "groupId": groupId};
      final data = await _dio.post(Api.scriptQuantityList, data: payload);
      print(data.data);
      return ScriptQuantityModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<UserListModel?> getMyUserListCall({String? text, String? filterType, String? roleId, String? userId, String? status, int? page}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "page": page,
        "limit": 200000,
        "search": text,
        "filterType": filterType,
        "roleId": roleId,
        "status": status,
        "userId": userId,
      };
      final data = await _dio.post(Api.myUserList, data: payload);
      print("=======================");
      print(data.data);
      return UserListModel.fromJson(data.data);
    } catch (e) {
      print('catch e->$e');
      return null;
    }
  }

  Future<UserListModel?> getChildUserListCall({String? text, String? filterType, String? roleId, String? userId, String? status, int? page}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "page": page,
        "limit": 1000,
        "search": text,
        "filterType": filterType,
        "roleId": roleId,
        "status": status,
        "userId": userId,
      };
      final data = await _dio.post(Api.childUserList, data: payload);
      print(data.data);
      return UserListModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<ExchangeListModel?> getExchangeListCall() async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {"page": 1, "limit": 10, "search": "", "sortKey": "createdAt", "sortBy": -1};
      final data = await _dio.post(Api.getExchangeList, data: payload);
      print(data.data);
      var value = ExchangeListModel.fromJson(data.data);
      value.exchangeData!.insert(0, ExchangeData(name: "ALL"));
      return value;
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<TabListModel?> getUserTabListCall() async {
    try {
      _dio.options.headers = getHeaders();
      print(_dio.options.headers);
      final data = await _dio.get(Api.getAllUserTabList);
      print(data.data);
      return TabListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<TabWiseSymbolListModel?> getAllSymbolTabWiseListCall(String tabId) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "userTabId": tabId,
      };
      print(_dio.options.headers);
      print(payload);
      final data = await _dio.post(Api.getAllSymbolTabWiseList, data: payload);
      print(data.data);
      return TabWiseSymbolListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<NotificationListModel?> notificaitonListCall(int page) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {"page": page, "limit": "20"};
      final data = await _dio.post(Api.notificationList, data: payload);
      //print(data.data);
      return NotificationListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<AllSymbolListModel?> allSymbolListCall(int page, String search, String exchangeId) async {
    try {
      _dio.options.headers = getHeaders();
      print(_dio.options.headers);
      final payload = {"page": page, "limit": 1000000, "search": search, "sortKey": "createdAt", "sortBy": -1, "exchangeId": exchangeId};
      final data = await _dio.post(Api.getAllSymbol, data: payload);
      var value = AllSymbolListModel.fromJson(data.data);
      ;
      value.data!.insert(0, GlobalSymbolData(symbolName: "ALL", symbolTitle: "ALL"));
      return value;
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<NotificationSettingModel?> getNotificationSettingCall() async {
    try {
      _dio.options.headers = getHeaders();
      print(_dio.options.headers);
      final payload = {
        "userId": userData!.userId,
      };
      // //print(payload);
      final data = await _dio.post(Api.getNotificationSetting, data: payload);
      //print(data);
      return NotificationSettingModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<NotificationSettingModel?> updateNotificationSettingCall({bool? marketOrder, bool? pendingOrder, bool? executePendingOrder, bool? deletePendingOrder, bool? tradingSound}) async {
    try {
      _dio.options.headers = getHeaders();
      print(_dio.options.headers);
      final payload = {"userId": userData!.userId, "marketOrder": marketOrder, "pendingOrder": pendingOrder, "executePendingOrder": executePendingOrder, "deletePendingOrder": deletePendingOrder, "treadingSound": tradingSound};
      // //print(payload);
      final data = await _dio.post(Api.updateNotificationSetting, data: payload);
      //print(data);
      return NotificationSettingModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<AddSymbolListModel?> addSymbolToTabCall(String tabId, String symbolId) async {
    try {
      _dio.options.headers = getHeaders();
      // print(_dio.options.headers);
      final payload = {
        "userTabId": tabId,
        "symbolId": symbolId,
      };
      // print(payload);
      final data = await _dio.post(Api.addSymbolToTab, data: payload);
      print(data);
      return AddSymbolListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<AddSymbolListModel?> deleteSymbolFromTabCall(String tabSymbolId) async {
    try {
      _dio.options.headers = getHeaders();
      // print(_dio.options.headers);
      final payload = {
        "userTabSymbolId": tabSymbolId,
      };
      // print(payload);
      final data = await _dio.post(Api.deleteSymbolFromTab, data: payload);
      print(data);
      return AddSymbolListModel.fromJson(data.data);
    } catch (e) {
      print("error ->$e");
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CreateUserModel?> createBrockerCall({
    String? name,
    String? userName,
    String? password,
    String? phone,
    bool? changePassword,
    String? role,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "name": name,
        "userName": userName,
        "password": password,
        "phone": phone,
        "changePasswordOnFirstLogin": changePassword,
        "role": role,
        "deviceToken": "xxxxx",
        'deviceId': Platform.isAndroid ? androidInfo?.id ?? "AndroidDevice" : iOsInfo?.identifierForVendor ?? "iOsDeivce",
        "deviceType": Platform.isAndroid ? "Android" : "iOS",
        "ipAddress": "0.0.0.0",
      };
      final data = await _dio.post(Api.createUser, data: payload);
      print(data.data);
      return CreateUserModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CreateUserModel?> editBrokerCall({
    String? name,
    String? userName,
    String? phone,
    bool? changePassword,
    String? role,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "name": name,
        "phone": phone,
        "changePasswordOnFirstLogin": changePassword,
        "role": role,
      };
      final data = await _dio.post(Api.editUser, data: payload);
      print(data.data);
      return CreateUserModel.fromJson(data.data);
    } catch (e) {
      print(e);
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CreateUserModel?> createAdminCall({String? name, String? userName, String? password, String? phone, String? role, int? cmpOrder, int? manualOrder, int? deleteTrade, int? executePendingOrder}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "name": name,
        "userName": userName,
        "password": password,
        "phone": phone,
        "role": role,
        "cmpOrder": cmpOrder,
        "manualOrder": manualOrder,
        "deleteTrade": deleteTrade,
        "executePendingOrder": executePendingOrder,
        "deviceToken": "xxxxx",
        'deviceId': Platform.isAndroid ? androidInfo?.id ?? "AndroidDevice" : iOsInfo?.identifierForVendor ?? "iOsDeivce",
        "deviceType": Platform.isAndroid ? "Android" : "iOS",
        "ipAddress": "0.0.0.0",
      };
      final data = await _dio.post(Api.createUser, data: payload);
      print(data.data);
      return CreateUserModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CreateUserModel?> editAdminCall(
      {String? name,
      String? userName,
      // String? password,
      String? phone,
      String? role,
      int? cmpOrder,
      int? manualOrder,
      int? deleteTrade,
      int? executePendingOrder}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "name": name,
        "phone": phone,
        "cmpOrder": cmpOrder,
        "manualOrder": manualOrder,
        "deleteTrade": deleteTrade,
        "executePendingOrder": executePendingOrder,
      };
      final data = await _dio.post(Api.editUser, data: payload);
      return CreateUserModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CreateUserModel?> createUserCall({
    String? name,
    String? userName,
    String? password,
    String? phone,
    int? credit,
    List<ExchangeAllow>? exchangeAllow,
    List<String>? highLowBetweenTradeLimits,
    bool? changePassword,
    String? role,
    int? modifyOrder,
    int? autoSquareOff,
    int? leverage,
    int? cutOff,
    bool? closeOnly,
    bool? freshLimitSL,
    // String? brokerId,
    // int? brkSharingDownLine,
    bool? symbolWiseSL,
    int? intraday,
    String? remark,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "name": name,
        "userName": userName,
        "password": password,
        "phone": phone,
        "changePasswordOnFirstLogin": changePassword,
        "remark": remark,
        "modifyOrder": modifyOrder,
        "autoSquareOff": autoSquareOff,
        "leverage": leverage,
        "cutOff": cutOff,
        "freshLimitSL": freshLimitSL,
        "closeOnly": closeOnly,
        "credit": credit,
        "highLowSLLimitPercentage": symbolWiseSL,
        "role": role,
        "deviceToken": "xxxxx",
        'deviceId': Platform.isAndroid ? androidInfo?.id ?? "AndroidDevice" : iOsInfo?.identifierForVendor ?? "iOsDeivce",
        "deviceType": Platform.isAndroid ? "Android" : "iOS",
        "ipAddress": "0.0.0.0",
        // "brkSharingDownLine": brkSharingDownLine,
        "intraday": intraday,
        "exchangeAllow": exchangeAllow == null ? [] : List<dynamic>.from(exchangeAllow.map((x) => x.toJson())),
        "highLowBetweenTradeLimit": highLowBetweenTradeLimits == null ? [] : List<dynamic>.from(highLowBetweenTradeLimits.map((x) => x)),
      };
      print(payload);
      final data = await _dio.post(Api.createUser, data: payload);
      print(data.data);
      return CreateUserModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CreateUserModel?> editUserCall({
    String? userId,
    String? name,
    String? userName,
    // String? password,
    String? phone,
    int? credit,
    List<ExchangeAllow>? exchangeAllow,
    List<String>? highLowBetweenTradeLimits,
    bool? changePassword,
    String? role,
    int? modifyOrder,
    int? autoSquareOff,
    int? leverage,
    int? cutOff,
    bool? closeOnly,
    String? brokerId,
    int? intraday,
    String? remark,
    int? brkSharingDownLine,
    bool? symbolWiseSL,
    bool? freshLimitSL,
  }) async {
    try {
      _dio.options.headers = getHeaders();

      final payload = {
        "userId": userId,
        "name": name,
        "phone": phone,
        "remark": remark,
        "autoSquareOff": autoSquareOff,
        "cutOff": cutOff,
        "highLowSLLimitPercentage": symbolWiseSL,
        "highLowBetweenTradeLimit": highLowBetweenTradeLimits == null ? [] : List<dynamic>.from(highLowBetweenTradeLimits.map((x) => x)),
        "freshLimitSL": freshLimitSL,
        "exchangeAllow": exchangeAllow == null ? [] : List<dynamic>.from(exchangeAllow.map((x) => x.toJson())),
      };
      print(payload);
      final data = await _dio.post(Api.editUser, data: payload);
      print(data.data);
      return CreateUserModel.fromJson(data.data);
    } catch (e) {
      print(e);
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CommonModel?> userChangeStatusCall({
    Map<String, Object?>? payload,
  }) async {
    try {
      _dio.options.headers = getHeaders();

      print(payload);
      final data = await _dio.post(Api.userChangeStatus, data: payload);
      print(data.data);
      return CommonModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CreateUserModel?> createMasterCall({
    String? name,
    String? userName,
    String? password,
    String? phone,
    int? credit,
    int? profitandLossSharing,
    int? brkSharing,
    int? profitandLossSharingDownline,
    int? brkSharingDownline,
    List<ExchangeAllowforMaster>? exchangeAllow,
    List<String>? highLowBetweenTradeLimits,
    bool? changePassword,
    String? role,
    int? manualOrder,
    int? addMaster,
    int? modifyOrder,
    int? leverage,
    int? marketOrder,
    String? remark,
    bool? symbolWiseSL,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "name": name,
        "userName": userName,
        "password": password,
        "phone": phone,
        "profitAndLossSharing": profitandLossSharing,
        "brkSharing": brkSharing,
        "profitAndLossSharingDownLine": profitandLossSharingDownline,
        "brkSharingDownLine": brkSharingDownline,
        "changePasswordOnFirstLogin": changePassword,
        "manualOrder": manualOrder,
        "addMaster": addMaster,
        "marketOrder": marketOrder,
        "modifyOrder": modifyOrder,
        "leverage": leverage,
        "credit": credit,
        "role": role,
        "remark": remark,
        "highLowSLLimitPercentage": symbolWiseSL,
        "highLowBetweenTradeLimit": highLowBetweenTradeLimits == null ? [] : List<dynamic>.from(highLowBetweenTradeLimits.map((x) => x)),
        "deviceToken": "xxxxx",
        'deviceId': Platform.isAndroid ? androidInfo?.id ?? "AndroidDevice" : iOsInfo?.identifierForVendor ?? "iOsDeivce",
        "deviceType": Platform.isAndroid ? "Android" : "iOS",
        "ipAddress": "0.0.0.0",
        "exchangeAllow": exchangeAllow == null ? [] : List<dynamic>.from(exchangeAllow.map((x) => x.toJson())),
      };
      print(payload.toString());
      final data = await _dio.post(Api.createUser, data: payload);
      print(data.data);
      return CreateUserModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CreateUserModel?> editMasterCall({
    String? userId,
    String? name,
    String? userName,
    // String? password,
    String? phone,
    int? credit,
    int? profitandLossSharing,
    int? brkSharing,
    int? profitandLossSharingDownline,
    int? brkSharingDownline,
    List<ExchangeAllowforMaster>? exchangeAllow,
    List<String>? highLowBetweenTradeLimits,
    bool? changePassword,
    String? role,
    int? manualOrder,
    int? addMaster,
    int? modifyOrder,
    int? leverage,
    int? marketOrder,
    String? remark,
    bool? symbolWiseSL,
  }) async {
    try {
      _dio.options.headers = getHeaders();

      final payload = {
        "userId": userId,
        "name": name,
        "phone": phone,
        "addMaster": addMaster,
        "remark": remark,
        "marketOrder": marketOrder,
        "exchangeAllow": exchangeAllow == null ? [] : List<dynamic>.from(exchangeAllow.map((x) => x.toJson())),
        "highLowBetweenTradeLimit": highLowBetweenTradeLimits == null ? [] : List<dynamic>.from(highLowBetweenTradeLimits.map((x) => x)),
        "highLowSLLimitPercentage": symbolWiseSL,
      };
      print(payload["exchangeAllow"]);
      final data = await _dio.post(Api.editUser, data: payload);
      print(data.data);
      return CreateUserModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<UserRoleListModel?> userRoleListCall() async {
    try {
      _dio.options.headers = getHeaders();

      final data = await _dio.post(Api.userRoleList, data: null);
      print(data.data);
      print('========================================');
      return UserRoleListModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<UserLoginHistoryModel?> userLoginHistoryCall(int page) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "page": page,
        "limit": 10,
      };
      final data = await _dio.post(Api.userLoginHistory, data: payload);
      print(data.data);
      return UserLoginHistoryModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<ChangePasswordModel?> changePasswordCall(String? oldPassword, String? newPassword, {String userId = ""}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {"oldPassword": oldPassword, "newPassword": newPassword, "userId": userId, "changePasswordOnFirstLogin": false};
      final data = await _dio.post(userId == "" ? Api.changePassword : Api.otherUserchangePassword, data: payload);
      return ChangePasswordModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<AccountSuumaryListModel?> creditHistoryCall({String? search, String? userId, String? type, String? startDate, String? endDate, int? page}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "page": page,
        "limit": 1000000,
        "search": search,
        "userId": userId,
        "type": type,
        "startDate": startDate,
        "endDate": endDate,
        "sortKey": "createdAt",
        "sortBy": -1,
      };
      print(payload);
      final data = await _dio.post(Api.accountSummary, data: payload);
      print(data.data);
      return AccountSuumaryListModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<CommonModel?> logoutCall() async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {
        "deviceToken": "xxxxxx",
        "loginBy": Platform.isMacOS ? "Mac" : "Window",
        "deviceId": deviceId,
        "ip": myIpAddress,
        "systemToken": "Bearer ${userToken}",
      };
      final data = await _dio.post(Api.logout, data: payload);
      print(data.data);

      return CommonModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<ViewProfileModel?> profileInfoCall() async {
    try {
      _dio.options.headers = getHeaders();

      final data = await _dio.post(Api.viewProfile, data: null);
      // print(data.data);
      return ViewProfileModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<ViewProfileModel?> profileInfoByUserIdCall(String userId) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "userId": userId,
      };
      print(payload);
      final data = await _dio.post(Api.viewProfile, data: payload);
      print(data.data);
      return ViewProfileModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<UserWiseBrokerageListModel?> userWiseBrokerageListCall({String? search, String? userId, String? type, String? exchangeId, int? page}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {"page": page, "limit": 10000000, "search": search, "sortKey": "createdAt", "brokerageType": type, "sortBy": -1, "userId": userId, "exchangeId": exchangeId};
      print(payload);
      final data = await _dio.post(Api.userWiseBrokerageList, data: payload);
      print(data.data);
      return UserWiseBrokerageListModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<CommonModel?> updateBrkCall({
    List<String>? arrIDs,
    String? brokerageType,
    String? userId,
    String? brokeragePrice,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "userWiseBrokerageId": arrIDs,
        "userId": userId,
        "brokerageType": brokerageType,
        "brokeragePrice": brokeragePrice,
      };

      print(payload);
      final data = await _dio.post(Api.updateUserWiseBrokerage, data: payload);
      print(data.data);
      return CommonModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<TradeLogsModel?> tradeLogsListCall(
    int page, {
    String search = "",
    String exchangeId = "",
    String symbolId = "",
    String userId = "",
    String startDate = "",
    String endDate = "",
  }) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {
        "search": search,
        "exchangeId": exchangeId,
        "symbolId": symbolId,
        "userId": userId,
        "page": page,
        "limit": 20,
        "startDate": startDate,
        "endDate": endDate,
      };
      final data = await _dio.post(Api.tradeLogs, data: payload);
      print(data.data);
      return TradeLogsModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<PostitionModel?> positionListCall(int page, String search, {String userId = "", String exchangeId = "", String symbolId = ""}) async {
    try {
      _dio.options.headers = getHeaders();
      print(_dio.options.headers);
      final payload = {
        "page": page,
        "limit": 200000,
        "search": search,
        "userId": userId,
        "exchangeId": exchangeId,
        "symbolId": symbolId,
      };
      final data = await _dio.post(Api.positionList, data: payload);
      return PostitionModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<CommonModel?> rollOverTradeCall({
    List<String>? symbolId,
    String? userId,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "symbolId": symbolId,
        "userId": userId,
        "ipAddress": myIpAddress,
        "deviceId": deviceId,
        "orderMethod": deviceName,
      };

      print(payload);
      final data = await _dio.post(Api.tradeRollOver, data: payload);
      print(data.data);
      return CommonModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CommonModel?> squareOffPositionCall({List<SymbolRequestData>? arrSymbol}) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      var symbolData = List<dynamic>.from(arrSymbol!.map((x) => x.toJson()));

      final payload = {
        "userId": userData!.userId,
        "symbolData": symbolData,
        "ipAddress": myIpAddress,
        "deviceId": deviceId,
        "orderMethod": Platform.isAndroid ? "Android" : "iOS",
      };
      print(payload);
      final data = await _dio.post(Api.squareOffPosition, data: payload);
      print(data.data);
      return CommonModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<UserWiseNetPositionModel?> userWiseNetPosition({String? search, String? eId, String? sId, String? uId, int? page, int? limit}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {"search": "$search", "exchangeId": "$eId", "symbolId": "$sId", "userId": "$uId", "page": 1, "limit": 1000000};
      final data = await _dio.post(Api.positionList, data: payload);
      return UserWiseNetPositionModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<PositionTrackListModel?> positionTrackingListCall({
    int? page,
    String? text,
    String? userId,
    String? symbolId,
    String? exchangeId,
    String? endDate,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "page": page,
        "limit": 20,
        "search": text,
        "userId": userId ?? "",
        "symbolId": symbolId ?? "",
        "exchangeId": exchangeId ?? "",
        "endDate": endDate,
      };

      final data = await _dio.post(Api.positionTracking, data: payload);
      print(data.data);
      return PositionTrackListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<ProfitLossListModel?> profitLossListCall({String userId = ""}) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {
        "page": 1,
        "limit": 100000,
        "search": "",
        "userId": userId,
      };
      final data = await _dio.post(Api.profitLossList, data: payload);

      return ProfitLossListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CommonModel?> addCreditCall({String? userId, String? amount, String? type, String? transactionType, String? comment}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {"userId": userId, "amount": amount, "type": type, "transactionType": transactionType, "comment": comment};
      final data = await _dio.post(Api.addCredit, data: payload);
      //print(data.data);
      return CommonModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<AccountSuumaryListModel?> accountSummary({String? search, String? uId, String? type, String? sDate, String? eDate, String? sortKey, int? page, int? limit}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {"page": page, "limit": 10, "search": "$search", "userId": "$uId", "type": "$type", "startDate": "$sDate", "endDate": "$eDate", "sortKey": "$sortKey", "sortBy": -1};
      print("---------------------");
      print(payload);
      print("---------------------");
      final data = await _dio.post(Api.accountSummary, data: payload);
      return AccountSuumaryListModel.fromJson(data.data);
    } catch (e) {
      print("error ->$e");
      return null;
    }
  }

  Future<CommonModel?> cancelAllTradeCall() async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {"userId": userData!.userId};
      final data = await _dio.post(Api.cancelAllTrade, data: payload);
      //print(data.data);
      return CommonModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CommonModel?> cancelTradeCall(
    String tradeId,
  ) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {"tradeId": tradeId};
      final data = await _dio.post(Api.cancelTrade, data: payload);
      //print(data.data);
      return CommonModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<GroupListModel?> getGroupListCall(String? exchangeId) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "page": 1,
        "limit": 100,
        "search": "",
        "exchangeId": exchangeId,
        "sortKey": "createdAt",
        "sortBy": -1,
      };
      final data = await _dio.post(Api.groupList, data: payload);
      print(data.data);
      return GroupListModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<BrokerListModel?> brokerListCall() async {
    try {
      _dio.options.headers = getHeaders();
      final data = await _dio.post(Api.brokerList, data: null);
      print(data.data);
      return BrokerListModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<M2MProfitLossModel?> m2mProfitLossListCall(int page, String search, String userId) async {
    try {
      _dio.options.headers = getHeaders();
      print(_dio.options.headers);
      final payload = {"page": page, "limit": 100000, "search": search, "userId": userId};
      final data = await _dio.post(Api.m2mProfitLoss, data: payload);

      return M2MProfitLossModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<GroupSettingListModel?> groupSettingListCall({
    int? page,
    String? text,
    String? userId,
    String? groupId,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {"page": 1, "limit": 1000000, "search": text, "sortKey": "createdAt", "sortBy": -1, "groupId": groupId, "userId": userId};

      final data = await _dio.post(Api.groupSettingList, data: payload);
      print(data.data);
      return GroupSettingListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<QuantitySettingListModel?> quantitySettingListCall({
    int? page,
    String? text,
    String? userId,
    String? groupId,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {"page": page, "limit": 10, "search": text, "sortKey": "createdAt", "sortBy": -1, "userId": userId, "groupId": groupId};

      print(payload);
      final data = await _dio.post(Api.quantitySettingList, data: payload);
      print(data.data);
      return QuantitySettingListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CommonModel?> updateQuantityCall({
    List<String>? arrIDs,
    String? quantityMax,
    String? userId,
    String? lotMax,
    String? breakQuantity,
    String? breakUpLot,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {"userWiseGroupDataAssociationId": arrIDs, "userId": userId, "quantityMax": quantityMax, "lotMax": lotMax, "breakQuantity": breakQuantity, "breakUpLot": breakUpLot, "status": 1};

      print(payload);
      final data = await _dio.post(Api.updateQuantity, data: payload);
      print(data.data);
      return CommonModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<RejectLogListModel?> getRejectLogListCall({
    int? page,
    String? text,
    String? userId,
    String? symbolId,
    String? exchangeId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "page": page,
        "limit": 1000000,
        "search": text,
        "userId": userId ?? "",
        "symbolId": symbolId ?? "",
        "exchangeId": exchangeId ?? "",
        "startDate": startDate,
        "endDate": endDate,
      };

      final data = await _dio.post(Api.rejectLog, data: payload);
      print(data.data);
      return RejectLogListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<SettlementListModel?> settelementListCall(int page, String search, String userId) async {
    try {
      _dio.options.headers = getHeaders();
      print(_dio.options.headers);
      final payload = {"page": page, "limit": 100000, "search": search, "userId": userId};
      final data = await _dio.post(Api.settelmentList, data: payload);
      print(data.data);
      return SettlementListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<BillGenerateModel?> billGenerateCall(String startDate, String search, String endDate, String userId, int billType) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {"startDate": startDate, "endDate": endDate, "search": search, "userId": userId, "billType": billType};
      final data = await _dio.post(Api.billGenerate, data: payload);
      //print(data.data);
      return BillGenerateModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<HolidayListModel?> holidayListCall(String exchangeId) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {"exchangeId": exchangeId};
      final data = await _dio.post(Api.holidayList, data: payload);
      //print(data.data);
      return HolidayListModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<CreditListModel?> getCreditListCall({String? userId}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {
        "userId": userId,
      };
      final data = await _dio.post(Api.creditList, data: payload);
      //print(data.data);
      return CreditListModel.fromJson(data.data);
    } catch (e) {
      return null;
    }
  }

  Future<BulkTradeModel?> bulkTradeListCall(int page, String exchnageId, String symbolId, String userId) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {"page": page, "limit": 20, "search": "", "exchangeId": exchnageId, "symbolId": symbolId, "userId": userId, "sortKey": "createdAt", "sortBy": -1};
      final data = await _dio.post(Api.bulkTradeList, data: payload);
      //print(data.data);
      return BulkTradeModel.fromJson(data.data);
    } catch (e) {
      print(e);
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<TradeDetailModel?> getTradeDetailCall(String tradeID) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {"tradeId": tradeID};
      final data = await _dio.post(Api.tradeDetail, data: payload);
      print(data.data);
      return TradeDetailModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<ExchangeListModel?> getExchangeListUserWiseCall({String userId = "", String brokerageType = ""}) async {
    try {
      _dio.options.headers = getHeaders();
      final payload = {"page": 1, "limit": 10000000, "search": "", "sortKey": "createdAt", "sortBy": -1, "userId": userId, "brokerageType": brokerageType};
      final data = await _dio.post(Api.getExchangeListUserWise, data: payload);
      //print(data.data);
      var value = ExchangeListModel.fromJson(data.data);
      value.exchangeData!.insert(0, ExchangeData(name: "ALL"));
      return value;
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<MarketTimingModel?> getMarketTimingCall(String exchangeId) async {
    try {
      _dio.options.headers = getHeaders();
      //print(_dio.options.headers);
      final payload = {"exchangeId": exchangeId};
      final data = await _dio.post(Api.marketTiming, data: payload);
      print(data.data);
      return MarketTimingModel.fromJson(data.data);
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  Future<File?> downloadFilefromUrl(String url, {String type = ""}) async {
    try {
      _dio.options.headers = getHeaders();
      var temp = await getTemporaryDirectory();
      var fileName = "${DateTime.now().millisecondsSinceEpoch}";
      var filePath = "${temp.path}/" + fileName;

      if (type.isNotEmpty) {
        filePath += ".${type}";
      } else {
        filePath += ".${url.split("/").last}";
      }
      final data = await _dio.download(url, filePath);

      // String path = await FileSaver.instance.saveFile(
      //   name: fileName,
      //   //link:  linkController.text,
      //   // bytes: Uint8List.fromList(excel.encode()!),
      //   file: File(filePath),
      //   ext: filePath.split(".").last,

      //   ///extController.text,
      //   mimeType: MimeType.pdf,
      // );

      return Future.value(File(filePath));
    } catch (e) {
      return null;
      // final errMsg = e.response?.data['message'];
      // throw Exception(errMsg);
    }
  }

  getHeaders() {
    return {
      'Accept': 'application/json',
      'apptype': Platform.isAndroid ? 'android' : 'ios',
      'deviceId': Platform.isAndroid ? androidInfo?.id ?? "AndroidDevice" : iOsInfo?.identifierForVendor ?? "iOsDeivce",
      'deviceToken': fcmToken ?? "xxxxxx",
      'Authorization': "Bearer ${userToken}",
      'userId': userId,
      'version': packageInfo == null ? "" : packageInfo?.version,
    };
  }
}
