import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constant/color.dart';
import '../../constant/constantTextStyle.dart';
import '../../main.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../../navigation/routename.dart';
import 'api.dart';

class ApiService {
  static BaseOptions options = BaseOptions(
    baseUrl: Api.baseUrl,
    responseType: ResponseType.json,
    connectTimeout: const Duration(seconds: 300),
    receiveTimeout: const Duration(seconds: 300),
    contentType: "application/json",
    headers: {'Accept': 'application/json', 'apptype': Platform.isAndroid ? 'android' : 'ios', 'deviceId': '123456', 'deviceToken': "xxxxxx", 'deviceTypeId': '1', 'Authorization': "Bearer ${userToken}", 'userId': userId},
    // ignore: missing_return

    validateStatus: (code) {
      if (code == 401) {
        final localStorage = GetStorage();
        localStorage.erase();
        userId = null;
        userToken = null;
        if (isAccessTokenExpired == false) {
          if (Get.currentRoute != RouterName.signInScreen) {
            Get.showSnackbar(GetSnackBar(
              messageText: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: AppColors().whiteColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      "Your access token has been expired.",
                      style: TextStyles().drawerTitleText,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
              duration: const Duration(seconds: 3),
              snackPosition: SnackPosition.TOP,
              backgroundColor: AppColors().blueColor,
            ));
            arrSymbolNames.clear();
            socket.channel?.sink.close(status.normalClosure);
            // socketIO.socketForTrade.emit('unsubscribe', userData!.userName);
            // socketIO.socketForTrade.disconnect();
            // socketIO.socketForTrade.dispose();
            Get.offAllNamed(RouterName.signInScreen);
            isAccessTokenExpired = true;
          }
        }

        return false;
      } else if (code == 302) {
        // Get.offAllNamed(RouterName.acceptedThankYouScreen);
        return false;
      } else {
        return true;
      }
    },
  );

  static final dio = Dio(options);
  // ..interceptors.add(PrettyDioLogger(
  //   requestHeader: isProduction,
  //   requestBody: isProduction,
  //   responseBody: isProduction,
  //   responseHeader: false,
  //   compact: false,
  // ));
}

Future<String> getMyIP() async {
  try {
    /// Initialize Ip Address
    var ipAddress = IpAddress(type: RequestType.json);

    /// Get the IpAddress based on requestType.
    dynamic data = await ipAddress.getIpAddress();
    print(data.toString());
    return data["ip"];
  } on IpAddressException catch (exception) {
    /// Handle the exception.
    print(exception.message);
    return "0.0.0.0";
  }
}
