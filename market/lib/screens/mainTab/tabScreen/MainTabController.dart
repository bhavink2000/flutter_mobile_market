import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/screens/mainTab/orderTab/orderController.dart';
import 'package:market/screens/mainTab/orderTab/orderWrapper.dart';
import 'package:market/screens/mainTab/settingTab/settingWrapper.dart';
import 'package:market/screens/mainTab/tradeTab/tradeController.dart';
import 'package:market/screens/mainTab/tradeTab/tradeWrapper.dart';
import 'package:market/screens/mainTab/positionTab/positionController.dart';
import 'package:market/screens/mainTab/positionTab/positionWrapper.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../../../constant/utilities.dart';
import '../../../main.dart';
import '../../../navigation/routename.dart';
import '../../BaseViewController/baseController.dart';
import '../../drawerMenu/drawerController.dart';
import '../homeTab/homeController.dart';
import '../homeTab/homeWrapper.dart';
import '../settingTab/settingController.dart';

class MainTabBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainTabController());
    Get.put(CustomDrawerController());
  }
}

int selectedIndex = 4;

class MainTabController extends BaseController with WidgetsBindingObserver {
  final List<Widget> widgetOptions = <Widget>[
    const tradeScreen(),
    const orderScreen(),
    const positionScreen(),
    const SettingScreen(),
    const HomeScreen(),
  ];

  String unVerifiedHelpCount = "0";
  final debouncer = Debouncer(milliseconds: 5000);
  @override
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextStyle optionStyle = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late Widget currentScreen;
  @override
  void onInit() async {
    Get.put(HomeController());
    Get.put(orderController());
    Get.put(positionController());
    Get.put(tradeController());
    Get.put(SettingController());
    selectedIndex = 4;
    super.onInit();
    getNotificationSettings();
    WidgetsBinding.instance.addObserver(this);

    // Future.delayed(const Duration(milliseconds: 1000), () async {
    //   await socket.connectSocket();
    //   update();
    // });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  refreshView() {
    update();
  }

  setMarketIndex() {
    selectedIndex = 4;
    Get.find<MainTabController>().update();
  }

  getNotificationSettings() async {
    update();

    var response = await service.getNotificationSettingCall();

    update();
    if (response?.statusCode == 200) {
      isMarketOrderOn = response!.data!.marketOrder!;
      isPendingOrderOn = response.data!.pendingOrder!;
      isExecutePendingOrderOn = response.data!.executePendingOrder!;
      isDeletePendingOrderOn = response.data!.deletePendingOrder!;
      isTreadingSoundOn = response.data!.treadingSound!;

      update();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (userData == null) {
        return;
      }
      if (isSleepActive) {
        isSleepActive = false;
      } else {
        return;
      }
      // App has come to the foreground
      var sleepTimer = stringToDate(localStorage.read(localStorageKeys.sleepTime));
      var diffrenceSecond = DateTime.now().difference(sleepTimer).inSeconds;

      if (diffrenceSecond > 180) {
        await socket.channel?.sink.close(status.normalClosure);
        socket.channel = null;
        isThemeChange = true;
        Get.offAllNamed(RouterName.mainTab);
        // service.logoutCall();
        // socket.channel?.sink.close(status.normalClosure);
        // socketIO.socketForTrade?.disconnect();
        // socketIO.socketForTrade?.dispose();
        // arrSymbolNames.clear();
        // localStorage.erase();
        // Get.changeTheme(ThemeData.light());
        // currentisDarkModeOn = false;
        // localStorage.write(localStorageKeys.isDarkMode, false);
        // userData = null;
        // SystemChrome.setSystemUIOverlayStyle(getSystemUiOverlayStyle());
        // Get.offAllNamed(RouterName.signInScreen);

        // Get.deleteAll(force: true);
      } else if (diffrenceSecond > 60) {
        // socket.channel?.sink.close(status.normalClosure);
        // socketIO.socketForTrade?.disconnect();
        // socketIO.socketForTrade?.dispose();
        // arrSymbolNames.clear();
        await socket.channel?.sink.close(status.normalClosure);
        socket.channel = null;
        isThemeChange = true;
        Get.offAllNamed(RouterName.mainTab);
      } else {
        selectedIndex = 4;
        Get.find<MainTabController>().update();

        print('App has resumed from the background : ${sleepSeconds}');
        sleepSeconds = 180;
      }

      SystemChrome.setSystemUIOverlayStyle(getSystemUiOverlayStyle());
    } else {
      if (isSleepActive) {
        return;
      }
      print(stringToDate(DateTime.now().toString()));
      isSleepActive = true;
      await localStorage.write(localStorageKeys.sleepTime, DateTime.now().toString());
      // Perform actions when the app is in the background
    }
  }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if (state == AppLifecycleState.resumed) {
  //     if (userData == null) {
  //       return;
  //     }
  //     selectedIndex = 4;
  //     update();
  //     // App has come to the foreground
  //     print('App has resumed from the background');
  //     await socket.connectSocket();
  //     var arrTemp = [];
  //     var homeVc = Get.find<HomeController>();

  //     for (var element in homeVc.arrSymbol) {
  //       if (!arrSymbolNames.contains(element.symbolName)) {
  //         arrTemp.insert(0, element.symbolName);
  //         arrSymbolNames.insert(0, element.symbolName!);
  //       }
  //     }
  //     var txt = {"symbols": arrSymbolNames};

  //     update();

  //     if (homeVc.arrScript.isNotEmpty) {
  //       socket.connectScript(jsonEncode(txt));
  //     }
  //     SystemChrome.setSystemUIOverlayStyle(getSystemUiOverlayStyle());
  //     // Get.offAllNamed(RouterName.mainTab);
  //   } else if (state == AppLifecycleState.paused) {
  //     // App has gone into the background
  //     // socket.channel?.sink.close(status.normalClosure);
  //     // socketIO.socketForTrade.disconnect();
  //     // socketIO.socketForTrade.dispose();

  //     print('App has gone into the background');
  //     // Perform actions when the app is in the background
  //   }
  // }

  void onItemTapped(int index) {
    selectedIndex = index;

    update();
    if (index == 3) {
      if (userData!.role == UserRollList.user) {
        var positionVC = Get.find<positionController>();
        positionVC.currentPage = 1;
        positionVC.getPositionList("", isFromRefresh: true);
      }
    }
  }
}
