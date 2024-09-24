import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/tabWiseSymbolListModelClass.dart';
import '../../../BaseViewController/baseController.dart';

class FilterScriptControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterScriptController());
  }
}

class FilterScriptController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  TextEditingController exchangeSearchController = TextEditingController();
  TextEditingController scriptSearchController = TextEditingController();
  FocusNode exchangeSearchFocus = FocusNode();
  FocusNode scriptSearchFocus = FocusNode();
  List<GlobalSymbolData> arrMainScript = [];
  List<GlobalSymbolData> arrScript = [];
  List<GlobalSymbolData> arrSlectedScript = [];
  int pageNumber = 1;
  int totalPage = 0;
  bool isLocalDataLoading = true;
  int currentSelectedIndex = -1;
  bool isAddDeleteApiLoading = false;
  List<SymbolData> arrCurrentAvailableSymbol = [];
  List<ExchangeData> arrExchangeListWithCountOfSymbol = [];
  ExchangeData selectedExchange = ExchangeData();
  bool isExchangeSearchActive = false;
  String selectedTabId = "";
  Function? callBack;
  bool isApiCallRunning = true;
  bool isApiCallForScriptRunning = false;

  @override
  void onInit() async {
    super.onInit();
    getExchangeList();

    if (Get.arguments != null) {
      selectedTabId = Get.arguments["tabId"];
      callBack = Get.arguments["onSelectedCallBack"];
      arrCurrentAvailableSymbol = Get.arguments["currentSymbol"];
      if (Get.arguments["selectedExchange"] != null) {
        selectedExchange = Get.arguments["selectedExchange"];
        getSymbolListByKeyword("");
        update();
      }
    }
    exchangeSearchController.addListener(() {
      if (exchangeSearchController.text.isEmpty) {
        isExchangeSearchActive = false;
        arrScript.clear();
      } else {
        isExchangeSearchActive = true;
      }
      update();
      print(isExchangeSearchActive);
    });
  }

  getExchangeList() async {
    var response = await service.getExchangeListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrExchangeListWithCountOfSymbol = response.exchangeData ?? [];
        arrExchangeListWithCountOfSymbol.removeAt(0);
        isApiCallRunning = false;
        update();
      }
    }
  }

  getSymbolListByKeyword(String text) async {
    isApiCallForScriptRunning = true;
    update();
    var response = await service.allSymbolListCall(1, text, selectedExchange.exchangeId ?? "");
    arrMainScript = response!.data ?? [];
    arrScript.clear();
    arrMainScript.removeAt(0);
    arrMainScript = arrMainScript.reversed.toList();
    arrScript.addAll(arrMainScript);

    for (var element in arrCurrentAvailableSymbol) {
      var temp = arrScript.firstWhereOrNull((value) => value.symbolName == element.symbolName);
      if (temp != null) {
        arrSlectedScript.add(temp);
      }
    }
    isApiCallForScriptRunning = false;
    update();
  }

  deleteSymbolFromTab(String tabSymbolId) async {
    var response = await service.deleteSymbolFromTabCall(tabSymbolId);
    if (response?.statusCode == 200) {
      // showSuccessToast(response?.meta?.message ?? "");
      isAddDeleteApiLoading = false;
      arrCurrentAvailableSymbol.removeWhere((element) => element.userTabSymbolId == tabSymbolId);
      update();
    }
  }

  addSymbolToTab(String symbolId) async {
    var response = await service.addSymbolToTabCall(selectedTabId, symbolId);
    if (response?.statusCode == 200) {
      // showSuccessToast(response?.meta?.message ?? "");
      isAddDeleteApiLoading = false;
      arrCurrentAvailableSymbol.add(SymbolData(symbol: response!.data!.symbolName, symbolId: response.data!.symbolId, userTabId: response.data!.userTabId, userTabSymbolId: response.data!.userTabSymbolId));
      update();
    }
  }

  passSelectedScripts() {
    if (callBack != null) {
      callBack!();
      Get.back();
    }
  }
}
