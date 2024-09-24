import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../modelClass/notificationListModelClass.dart';
import '../../../BaseViewController/baseController.dart';

class notificationListControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => notificationListController());
  }
}

class notificationListController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  bool isTotalViewExpanded = false;
  TextEditingController textController = TextEditingController();
  FocusNode textFocus = FocusNode();

  bool isApiCallRunning = false;
  bool isPagingApiCall = false;
  int totalPage = 0;
  int currentPage = 1;
  ScrollController mainScroll = ScrollController();
  List<NotificationData> arrNotification = [];

  @override
  void onInit() async {
    super.onInit();
    isApiCallRunning = true;
    notificationList();
  }

  notificationList() async {
    if (isPagingApiCall) {
      return;
    }
    isPagingApiCall = true;
    update();
    var response = await service.notificaitonListCall(currentPage);
    arrNotification.addAll(response!.data!);
    isApiCallRunning = false;
    isPagingApiCall = false;
    totalPage = response.meta!.totalPage!;
    if (totalPage >= currentPage) {
      currentPage = currentPage + 1;
    }
    update();
  }
}
