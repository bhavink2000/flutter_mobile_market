import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../constant/utilities.dart';
import '../../../../main.dart';
import '../../../BaseViewController/baseController.dart';

class SettingNotificationControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingNotificationController());
  }
}

class SettingNotificationController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();

  bool isDarkMode = false;
  bool isApiCallRunning = false;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getNotificationSettings();
  }

  getNotificationSettings() async {
    isApiCallRunning = true;
    update();

    var response = await service.getNotificationSettingCall();
    isApiCallRunning = false;

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

  updateNotificationSettings({bool isFromReset = false}) async {
    isApiCallRunning = true;

    update();
    var response = await service.updateNotificationSettingCall(
        marketOrder: isMarketOrderOn,
        pendingOrder: isPendingOrderOn,
        executePendingOrder: isExecutePendingOrderOn,
        deletePendingOrder: isDeletePendingOrderOn,
        tradingSound: isTreadingSoundOn);
    isApiCallRunning = false;

    update();
    if (response?.statusCode == 200) {
      isMarketOrderOn = response!.data!.marketOrder!;
      isPendingOrderOn = response.data!.pendingOrder!;
      isExecutePendingOrderOn = response.data!.executePendingOrder!;
      isDeletePendingOrderOn = response.data!.deletePendingOrder!;
      isTreadingSoundOn = response.data!.treadingSound!;
      showSuccessToast(response.meta!.message ?? "",globalContext!);
      update();
    }
  }
}
