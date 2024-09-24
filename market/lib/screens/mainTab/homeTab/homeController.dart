import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/modelClass/categoryDataModelClass.dart';
import 'package:market/modelClass/getScriptFromSocket.dart';
import 'package:market/modelClass/tabWiseSymbolListModelClass.dart';
import 'package:market/screens/mainTab/positionTab/positionController.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:market/screens/mainTab/tradeTab/tradeController.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../constant/color.dart';
import '../../../constant/font_family.dart';
import '../../../main.dart';
import '../../../modelClass/constantModelClass.dart';
import '../../../modelClass/ltpUpdateModelClass.dart';
import '../../../modelClass/tabListModelClass.dart';
import '../../../navigation/routename.dart';
import '../../BaseViewController/baseController.dart';
import '../../../constant/const_string.dart';

class HomeControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class HomeController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */

  ScrollController listcontroller = ScrollController();
  ScrollController buySellBottomSheetScrollcontroller = ScrollController();
  ScrollController orderTypeListcontroller = ScrollController();
  ScrollController scriptController = ScrollController();
  ScrollController sheetController = ScrollController();
  TextEditingController qtyController = TextEditingController();
  FocusNode qtyFocus = FocusNode();
  TextEditingController priceController = TextEditingController();
  FocusNode priceFocus = FocusNode();
  bool isForBuy = false;
  RxInt selectedOptionBottomSheetTab = 0.obs;
  RxInt selectedIntraLongBottomSheetTab = 0.obs;
  Type? selectedOrderType;
  Type? selectedProductType;
  List<TabData> arrCategory = [];
  List<categoryDataModel> arrCategoryData = [];
  List<LtpUpdateModel> arrLtpUpdate = [];
  GlobalKey<ExpandableBottomSheetState>? buySellBottomSheetKey;
  RxBool isInfoClick = false.obs;
  int quantity = 0;
  num totalQuantity = 0;
  Rx<TabData> selectedTab = TabData().obs;
  RxBool isTradeCallFinished = true.obs;
  RxBool isPlayerOpen = false.obs;
  bool isDetailSciptOn = false;
  // List<ScriptData> arrScript = [];
  RxList<ScriptData> arrScript = RxList();

  List<SymbolData> arrSymbol = [];
  Rx<ScriptData?> selectedScript = ScriptData().obs;
  SymbolData? selectedSymbol;
  RxBool isApiCallRunning = false.obs;
  int isFilterClicked = 0;
  bool isAddDeleteApiLoading = false;
  RxList<ScriptData> arrPreScript = RxList<ScriptData>();
  int selectedScriptIndex = -1;
  int currentSelectedIndex = -1;
  RxBool isValidQty = true.obs;
  RxDouble lotSizeConverted = 1.0.obs;
  YoutubePlayerController? playerController;
  @override
  void onInit() async {
    super.onInit();
    playerController = YoutubePlayerController(
      params: YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    playerController!.loadVideoById(videoId: "TD0A7fHAxKw");
    if (Platform.isAndroid) {
      playerController!.pauseVideo();
    }

    var index = constantValues!.orderType!.indexWhere((element) => element.name == "ALL");
    if (index != -1) {
      constantValues!.orderType!.removeAt(index);
    }
    selectedOrderType = constantValues!.orderType![0];
    selectedProductType = constantValues!.productType![0];
    if (constantValues!.orderType!.indexWhere((element) => element.id == "123") == -1) {
      constantValues!.orderType!.add(Type(name: "Intraday", id: "123"));
    }

    isDetailSciptOn = localStorage.read(localStorageKeys.isDetailSciptOn) ?? false;
    // update();
    isApiCallRunning.value = true;
    var response = await service.getUserTabListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrCategory = response.data ?? [];
        if (arrCategory.isNotEmpty) {
          selectedTab.value = arrCategory[0];
          await getSymbolListTabWise();
          Future.delayed(const Duration(seconds: 1), () {
            Get.find<positionController>().getPositionList("", isFromRefresh: true);

            Get.find<tradeController>().getTradeList();
            // update();
          });
        }
        // update();
      }
    }
    Future.delayed(Duration(milliseconds: 1000), () {
      refreshSciptLayout();
    });
    if (userData!.changePasswordOnFirstLogin == true) {
      Get.toNamed(RouterName.UserListChangePasswordScreen);
    }
    if (profileTimer != null) {
      profileTimer!.cancel();
      profileTimer = null;
    }
    profileTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (userToken != null) {
        getOwnProfile();
      }
    });
  }

  bool hasNonZeroDecimalPart(num number) {
    String numberString = number.toString();

    // Check if the number contains a decimal point
    if (numberString.contains('.')) {
      // Extract the decimal part and convert it to double
      double decimalPart = double.parse('0.${numberString.split('.')[1]}');

      // Check if the decimal part is greater than 0
      return decimalPart > 0;
    } else {
      // If there is no decimal point, there is no decimal part
      return false;
    }
  }

  getOwnProfile() async {
    var userResponse = await service.profileInfoCall();
    if (userResponse != null) {
      if (userResponse.statusCode == 200) {
        userData = userResponse.data;

        // update();
        //print("data Updated");
      }
    }
  }

  void scrollToIndex(int index) {
    listcontroller.animateTo(
      index * 65, // Replace itemHeight with the actual height of each list item
      duration: const Duration(milliseconds: 500), // Adjust the duration as needed
      curve: Curves.easeInOut, // Adjust the scroll animation curve as needed
    );
  }

  Widget modifyPriceStyle(int index, num currentPrice, num oldPrice) {
    var price = currentPrice.toStringAsFixed(2).split(".");

    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
              text: price.first,
              style: TextStyle(
                fontFamily: Appfonts.family2,
                color: currentPrice < oldPrice
                    ? AppColors().redColor
                    : currentPrice > oldPrice
                        ? AppColors().blueColor
                        : AppColors().DarkText,
                fontSize: 14,
                fontFeatures: [FontFeature.subscripts()],
              )),
          TextSpan(
              text: price.length > 1 ? "." : "",
              style: TextStyle(
                fontFamily: Appfonts.family2,
                color: currentPrice < oldPrice
                    ? AppColors().redColor
                    : currentPrice > oldPrice
                        ? AppColors().blueColor
                        : AppColors().DarkText,
                fontSize: 14,
              )),
          TextSpan(
              text: price.length > 1 ? price.last : "",
              style: TextStyle(
                fontFamily: Appfonts.family2,
                color: currentPrice < oldPrice
                    ? AppColors().redColor
                    : currentPrice > oldPrice
                        ? AppColors().blueColor
                        : AppColors().DarkText,
                fontSize: 22,
                fontFeatures: [FontFeature.subscripts()],
              )),
        ],
      ),
    );
  }

  String validateForm() {
    var msg = "";
    if (selectedOrderType!.id != "limit") {
      log("----------------------");
      log(selectedSymbol!.tradeSecond!.toString());
      log("----------------------");
      if (selectedSymbol!.tradeSecond! != 0) {
        var ltpObj = arrLtpUpdate.firstWhereOrNull((element) => element.symbolTitle == selectedScript.value!.symbol);

        if (ltpObj == null) {
          return "INVALID SERVER TIME";
        } else {
          var difference = DateTime.now().difference(ltpObj.dateTime!);
          var differenceInSeconds = difference.inSeconds;
          if (differenceInSeconds >= selectedSymbol!.tradeSecond!) {
            return "INVALID SERVER TIME";
          }
        }
      }
    }

    if (selectedOrderType!.id == "market" || selectedOrderType!.id == "123") {
      if (qtyController.text.isEmpty) {
        msg = AppString.emptyQty;
      } else if (num.parse(qtyController.text) == 0) {
        msg = AppString.emptyQty;
      } else if (isValidQty == false) {
        msg = AppString.inValidQty;
      }
    } else {
      if (qtyController.text.isEmpty) {
        msg = AppString.emptyQty;
      } else if (num.parse(qtyController.text) == 0) {
        msg = AppString.emptyQty;
      } else if (isValidQty == false) {
        msg = AppString.inValidQty;
      } else if (priceController.text.isEmpty) {
        msg = AppString.emptyPrice;
      }
    }
    return msg;
  }

  double getTotal(bool isBuy) {
    var total = 0.0;
    if (isBuy) {
      for (var element in selectedScript.value!.depth!.buy!) {
        total = total + element.price!;
      }
    } else {
      for (var element in selectedScript.value!.depth!.sell!) {
        total = total + element.price!;
      }
    }
    return total;
  }

  double getLimitPrice(double inputPrice, bool isFromBuy) {
    if (isFromBuy) {
      if (inputPrice > selectedScript.value!.ask!.toDouble()) {
        return selectedScript.value!.ask!.toDouble();
      } else {
        return inputPrice;
      }
    } else {
      if (inputPrice < selectedScript.value!.bid!.toDouble()) {
        return selectedScript.value!.bid!.toDouble();
      } else {
        return inputPrice;
      }
    }
  }

  bool isFromLimitCheck(double inputPrice, bool isFromBuy) {
    if (isFromBuy) {
      if (inputPrice > selectedScript.value!.ask!.toDouble()) {
        return false;
      } else {
        return true;
      }
    } else {
      if (inputPrice < selectedScript.value!.bid!.toDouble()) {
        return false;
      } else {
        return true;
      }
    }
  }

  initiateTrade(StateSetter stateSetter) async {
    var msg = validateForm();
    isTradeCallFinished.value = true;
    if (msg.isEmpty) {
      isTradeCallFinished.value = false;
      if (selectedOrderType!.id != "limit" && selectedOrderType!.id != "stopLoss") {
        priceController.text = isForBuy == 1 ? selectedScript.value!.ask!.toString() : selectedScript.value!.bid!.toString();
      }

      var response = await service.tradeCall(
        symbolId: selectedSymbol!.symbolId,
        quantity: selectedScript.value!.exchange!.toLowerCase() == "mcx" ? totalQuantity.toDouble() : lotSizeConverted.value,
        totalQuantity: selectedScript.value!.exchange!.toLowerCase() == "mcx" ? lotSizeConverted.value : totalQuantity.toDouble(),
        price: double.parse(priceController.text.isEmpty ? "0" : priceController.text),
        isFromStopLoss: selectedOrderType!.id == "stopLoss",
        marketPrice: selectedOrderType!.id == "stopLoss"
            ? isForBuy
                ? selectedScript.value!.ask!.toDouble()
                : selectedScript.value!.bid!.toDouble()
            : selectedOrderType!.id == "limit"
                ? getLimitPrice(double.parse(priceController.text), isForBuy)
                : isForBuy
                    ? selectedScript.value!.ask!.toDouble()
                    : selectedScript.value!.bid!.toDouble(),
        lotSize: selectedSymbol!.lotSize!,
        orderType: selectedOrderType!.id == "123" || (selectedOrderType!.id == "limit" && isFromLimitCheck(double.parse(priceController.text), isForBuy) == false) ? "market" : selectedOrderType!.id,
        tradeType: isForBuy ? "buy" : "sell",
        exchangeId: selectedSymbol!.exchangeId,
        productType: selectedOrderType!.id == "123" ? "intraday" : "longTerm",
        refPrice: isForBuy ? selectedScript.value!.ask!.toDouble() : selectedScript.value!.bid!.toDouble(),
      );
      //longterm
      isTradeCallFinished.value = false;
      // update();
      if (response != null) {
        // Get.back();
        if (response.statusCode == 200) {
          selectedOptionBottomSheetTab.value = 0;
          var tradeVC = Get.find<tradeController>();
          tradeVC.getTradeList();
          var positionVC = Get.find<positionController>();
          positionVC.getPositionList("", isFromRefresh: true);
          showSuccessToast(response.meta!.message!, globalContext!, isPlayAudio: true);
          isTradeCallFinished.value = true;
          // update();
          if (selectedOrderType!.id == "market" || selectedOrderType!.id == "123") {
            selectedIndex = 0;
            Get.find<MainTabController>().update();
          } else {
            if (selectedOrderType!.id == "limit" && isFromLimitCheck(double.parse(priceController.text), isForBuy) == false) {
              selectedIndex = 0;
            } else {
              selectedIndex = 1;
            }

            Get.find<MainTabController>().update();
          }
          selectedOrderType = constantValues!.orderType![0];
        } else {
          isTradeCallFinished.value = true;
          showErrorToast(response.message!, globalContext!, isPlayAudio: true);
          // update();
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

  getSymbolListTabWise() async {
    var response = await service.getAllSymbolTabWiseListCall(selectedTab.value.userTabId!);
    isApiCallRunning.value = false;
    if (response?.statusCode == 200) {
      var arrTemp = [];
      arrSymbol = response!.data!.toSet().toList();
      for (var element in arrSymbol) {
        if (arrSymbolNames.indexWhere((value) => value == element.symbolName) == -1) {
          arrTemp.insert(0, element.symbolName);
          arrSymbolNames.insert(0, element.symbolName!);
        }
      }
      var txt = {"symbols": arrSymbolNames};

      arrScript.clear();
      arrPreScript.clear();
      // update();
      arrSymbol.forEach((element) {
        if (arrScript.indexWhere((value) => value.symbol == element.symbol) == -1) {
          arrScript.add(ScriptData.fromJson(element.toJson()));
          arrPreScript.add(ScriptData.fromJson(element.toJson()));
        }
      });
      if (arrSymbolNames.isNotEmpty) {
        socket.connectScript(jsonEncode(txt));
      }
    }
  }

  deleteSymbolFromTab(String tabSymbolId) async {
    var response = await service.deleteSymbolFromTabCall(tabSymbolId);
    if (response?.statusCode == 200) {
      // showSuccessToast(response?.meta?.message ?? "");
      isAddDeleteApiLoading = false;
      // update();
      getSymbolListTabWise();
    }
  }

  refreshSciptLayout() async {
    isDetailSciptOn = localStorage.read(localStorageKeys.isDetailSciptOn) ?? false;
    // update();
  }

  Function? updateBottomSheet;
  listenScriptFromScoket(GetScriptFromSocket socketData) {
    if (socketData.status == true) {
      var obj = arrScript.firstWhereOrNull((element) => socketData.data!.symbol == element.symbol);
      if (obj?.symbol == selectedScript.value?.symbol) {
        try {
          // selectedScript.value = socketData.data!;
          selectedScript.value!.copyObject(socketData.data!);
          // selectedScript.value!.ask = 1 + selectedScript.value!.ask!;

          if (updateBottomSheet != null) {
            updateBottomSheet!(() {});
          }
          // update();
          // selectedScript.value!.ltp = 255;
        } catch (e) {
          print(e);
        }
      }
      if (obj != null) {
        // print(socketData.data!.symbol);

        var index = arrScript.indexOf(obj);
        var ltpObj = LtpUpdateModel(symbolId: "", ltp: socketData.data!.ltp!, symbolTitle: socketData.data!.symbol, dateTime: DateTime.now());
        var isAvailableObj = arrLtpUpdate.firstWhereOrNull((element) => socketData.data!.symbol == element.symbolTitle);
        if (isAvailableObj == null) {
          arrLtpUpdate.add(ltpObj);
        } else {
          var index = arrLtpUpdate.indexWhere((element) => element.symbolTitle == ltpObj.symbolTitle);
          arrLtpUpdate[index] = ltpObj;
          // print(ltpObj.symbolTitle);
          // print(ltpObj.ltp);
        }
        var preIndex = arrPreScript.indexWhere((element) => element.symbol == obj.symbol);
        arrPreScript.removeAt(preIndex);
        arrPreScript.insert(preIndex, arrScript[index]);
        arrScript[index] = socketData.data!;
      }

      //else {
      //   var obj = arrSymbol.firstWhereOrNull((element) => socketData.data!.symbol == element.symbolName);
      //   if (obj != null) {
      //     arrScript.add(socketData.data!);
      //   }
      // }
      // update();
    }
  }
}
