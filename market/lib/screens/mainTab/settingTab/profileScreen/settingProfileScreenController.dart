import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market/modelClass/profileInfoModelClass.dart';

import '../../../BaseViewController/baseController.dart';

class SettingProfileControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingProfileController());
  }
}

class SettingProfileController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  var arrProfileDetails = [
    {"id": 1, "name": "Name :", "values": "MAN07"},
    {"id": 2, "name": "Display Name :", "values": "manish panvel"},
    {"id": 3, "name": "Device Name :", "values": "iPhone"},
    {"id": 4, "name": "Version Code :", "values": "1.7"},
  ];
  ProfileInfoData? arrProfileData;
  List<ProfileInfoData> arrProfileDataList = [];
  @override
  void onInit() async {
    super.onInit();
    getProfileInfoCall();
    update();
  }

  getProfileInfoCall() async {
    var response = await service.profileInfoCall();
    if (response != null) {
      if (response.statusCode == 200) {//bhavin change statuscode 1 to 200
        arrProfileData = response.data;
        update();
      }
    }
  }
}
