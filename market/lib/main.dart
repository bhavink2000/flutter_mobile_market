import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:market/constant/commonFunction.dart';
import 'package:market/constant/utilities.dart';
import 'package:market/modelClass/profileInfoModelClass.dart';
import 'package:market/service/network/allApiCallService.dart';
import 'package:market/service/network/apiService.dart';
import 'package:market/service/network/socket_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'constant/const_string.dart';
import 'modelClass/constantModelClass.dart';
import 'navigation/navigation.dart';
import 'navigation/routename.dart';
import 'service/network/socket_io_service.dart';

bool isMarketOrderOn = false;
bool isPendingOrderOn = false;
bool isExecutePendingOrderOn = false;
bool isDeletePendingOrderOn = false;
bool isTreadingSoundOn = false;
bool isProduction = false;
var userId;
var userToken;
var serverName = "";
Timer? sleepTimer;
int sleepSeconds = 180;
bool isSleepActive = false;
ProfileInfoData? userData;

ConstantData? constantValues;
List<String> arrSymbolNames = [];
final socket = SocketService();
final socketIO = SocketIOService();
AndroidDeviceInfo? androidInfo;
IosDeviceInfo? iOsInfo;
String? fcmToken;
bool isLogoutRunning = false;
bool isThemeChange = false;
Timer? profileTimer;
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
bool currentisDarkModeOn = false;
bool isAccessTokenExpired = false;
// AllApiCallService service = AllApiCallService();
PackageInfo? packageInfo;
var deviceName = "";
var deviceId = "";
final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
var myIpAddress = "0.0.0.0";

void main() async {
  await GetStorage.init();
  getMyIP().whenComplete(() async {
    myIpAddress = await getMyIP();
  });

  final localStorage = GetStorage();
  currentisDarkModeOn = await localStorage.read(localStorageKeys.isDarkMode) ?? false;
  userId = await localStorage.read(localStorageKeys.userId);
  userToken = await localStorage.read(localStorageKeys.userToken);
  await Firebase.initializeApp();
  handelFcm();
  SystemChrome.setSystemUIOverlayStyle(getSystemUiOverlayStyle());

  if (userId != null) {
    // await socket.connectSocket();
    var sleepTimer = stringToDate(localStorage.read(localStorageKeys.sleepTime) ?? DateTime.now().toString());

    var diffrenceSecond = DateTime.now().difference(sleepTimer).inSeconds;

    if (diffrenceSecond > 180) {
      try {
        AllApiCallService().logoutCall();
        socket.channel?.sink.close(status.normalClosure);
        socketIO.socketForTrade?.disconnect();
        socketIO.socketForTrade?.dispose();
      } catch (e) {
        print(e);
      } finally {
        Future.delayed(Duration(seconds: 5), () {
          arrSymbolNames.clear();
          localStorage.erase();
          Get.changeTheme(ThemeData.light());
          currentisDarkModeOn = false;
          localStorage.write(localStorageKeys.isDarkMode, false);
          userData = null;
          SystemChrome.setSystemUIOverlayStyle(getSystemUiOverlayStyle());
          Get.offAllNamed(RouterName.signInScreen);
        });
      }
    } else {
      AllApiCallService service = AllApiCallService();
      await socket.channel?.sink.close(status.normalClosure);

      await socketIO.socketForTrade?.disconnect();
      socketIO.socketForTrade?.dispose();

      await socket.connectSocket();

      var userResponse = await service.profileInfoCall();
      if (userResponse != null) {
        if (userResponse.statusCode == 200) {
          userData = userResponse.data;
          socketIO.init();
          if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker) {
            await callForRoleList();
          }
        }
      }
      var response = await service.getConstantCall();
      if (response != null) {
        constantValues = response.data;

        await getExchangeList();
      }
    }
  }
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo!.id;
    deviceName = androidInfo!.model;
  } else {
    iOsInfo = await deviceInfo.iosInfo;
    deviceId = iOsInfo!.identifierForVendor!;
    deviceName = iOsInfo!.model;
  }
  getMyIP().whenComplete(() async {
    myIpAddress = await getMyIP();
  });

  Timer.periodic(const Duration(seconds: 2), (timer) {
    internetConnectivity();
  });

  packageInfo = await PackageInfo.fromPlatform();
  runApp(const MyApp());
}

handelFcm() async {
  var status = await Permission.notification.request();
  print(status.isGranted);
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  try {
    FirebaseMessaging.instance.getToken().then((value) async {
      try {
        fcmToken = value;
        print("firebase Token : ${fcmToken}");

        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
        await setupFlutterNotifications();
      } catch (e) {
        print(e);
      }
    });
    FirebaseMessaging.instance.getInitialMessage().then((event) async {
      try {
        print("firebase getInitialMessage : ${event}");
        if (event != null) {
          Future.delayed(Duration(milliseconds: 2000), () {
            handelAndroidNotification("", iOSData: event.data);
          });
        }
      } catch (e) {
        print(e);
      }
    });
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handelAndroidNotification("", iOSData: event.data);
    });
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        initialRoute: userId != null ? RouterName.mainTab : RouterName.signInScreen, //change intial route from heare
        debugShowCheckedModeBanner: false,
        getPages: Pages.pages(),
      );
    });
  }
}

showAlert(String message) {
  showDialog(
    context: Get.context!,
    builder: (builder) => Material(
      color: Colors.transparent,
      child: AlertDialog(
        content: Text(
          message,
          maxLines: 3,
        ),
      ),
    ),
  );
}

internetConnectivity() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      if (Get.isDialogOpen!) {
        socket.channel?.sink.close(status.normalClosure);
        bouncer.run(() async {
          await socket.connectSocket();
          var txt = {"symbols": arrSymbolNames};
          if (arrSymbolNames.isNotEmpty) {
            socket.connectScript(jsonEncode(txt));
          }
        });
        Get.back();
        // Get.offAllNamed(userId == null
        //     ? RouterName.searchWithoutLoginScreen
        //     : RouterName.homeScreen);
      }
    }
  } on SocketException catch (_) {
    print("There is no internet");
    if (Get.isDialogOpen == false) {
      Get.dialog(Material(
        color: Colors.transparent,
        child: PopScope(
          canPop: false,
          onPopInvoked: (canpop) {},
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            content: SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  "There is no internet connection".tr,
                  maxLines: 3,
                ),
              ),
            ),
          ),
        ),
      ));
      // showAlert("There is no internet connection");
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${jsonEncode(message.data)}');
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  try {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(onDidReceiveLocalNotification: (i, a, b, c) {});
    final LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin, linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? payload) async {
        Future.delayed(Duration(seconds: 2), () {
          handelAndroidNotification(payload!.payload!);
        });
      },
    );

    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((value) {
      if (value!.didNotificationLaunchApp) {
        if (value.notificationResponse != null) {
          Future.delayed(Duration(seconds: 2), () {
            handelAndroidNotification(value.notificationResponse!.payload!);
          });
        }
      }
    });

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.

    isFlutterLocalNotificationsInitialized = true;
  } catch (e) {
    print(e);
  }
}

handelAndroidNotification(String payload, {Map<String, dynamic>? iOSData}) {
  print("-------------------------------------");
  print(payload);
  print("-------------------------------------");
  // var payloadJson = null;
  // if (iOSData != null) {
  //   payloadJson = iOSData;
  // } else {
  //   payloadJson = jsonDecode(payload);
  // }
  flutterLocalNotificationsPlugin.cancelAll();
}

void onNotificationTap(event) {
  // log(event.data["type"]);
  // var mainVC = Get.find<MainTabController>();
  // if (mainVC.selectedIndex != 0) {
  //   mainVC.onItemTapped(0);
  // }
}

void showFlutterNotification(RemoteMessage message) {
  if (Platform.isAndroid) {
    var data = message.data;
    if (data.isEmpty) {
      data = {"title": message.notification?.title ?? "", "body": message.notification?.body ?? ""};
    }
    if (message.data["message"] != null) {
      data = jsonDecode(message.data["message"]);
    }

    RemoteNotification? notification = RemoteNotification(
      title: data["title"],
      body: data["body"],
    );

    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
            // icon: "logo_splash",
          ),
        ),
        payload: jsonEncode(data));

    print('Handling a background message ${jsonEncode(data)}');
  }
}
