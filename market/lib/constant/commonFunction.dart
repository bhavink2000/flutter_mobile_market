import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/modelClass/allSymbolListModelClass.dart';
import 'package:market/modelClass/exchangeListModelClass.dart';
import 'package:market/modelClass/userRoleListModelClass.dart';
import 'package:market/screens/mainTab/tabScreen/MainTabController.dart';
import 'package:market/service/network/allApiCallService.dart';

AllApiCallService service = AllApiCallService();
List<userRoleListData> arrUserRoleList = [];
List<ExchangeData> arrExchangeList = [];
RxList<GlobalSymbolData> arrMainScript = RxList<GlobalSymbolData>();

callForRoleList() async {
  var response = await service.userRoleListCall();
  if (response != null) {
    if (response.statusCode == 200) {
      arrUserRoleList = response.data!;
    } else {
      showErrorToast(response.message ?? "", Get.find<MainTabController>().globalContext!);
    }
  } else {
    showErrorToast(AppString.generalError, Get.find<MainTabController>().globalContext!);
  }
}

getExchangeList() async {
  var response = await service.getExchangeListCall();
  if (response != null) {
    if (response.statusCode == 200) {
      arrExchangeList = response.exchangeData ?? [];
    }
  }
}
