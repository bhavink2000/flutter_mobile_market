import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market/constant/assets.dart';
import 'package:market/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'color.dart';
import 'constantTextStyle.dart';
import 'font_family.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

void showWarningToast(String msg, BuildContext context) {
  showToastWidget(
      Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        color: AppColors().blueColor,
        child: Row(
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
                msg,
                style: TextStyles().drawerTitleText,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
      context: context,
      position: StyledToastPosition(align: Alignment.topCenter));
  // Get.showSnackbar(GetSnackBar(
  //   messageText: Row(
  //     children: [
  //       Icon(
  //         Icons.warning,
  //         color: AppColors().whiteColor,
  //       ),
  //       const SizedBox(
  //         width: 10,
  //       ),
  //       SizedBox(
  //         width: 80.w,
  //         child: Text(
  //           msg,
  //           style: TextStyles().drawerTitleText,
  //           maxLines: 3,
  //         ),
  //       ),
  //     ],
  //   ),
  //   duration: const Duration(seconds: 3),
  //   snackPosition: SnackPosition.TOP,
  //   backgroundColor: AppColors().blueColor,
  // ));
}

void showErrorToast(String msg, BuildContext context, {bool isPlayAudio = false}) {
  if (isPlayAudio) {
    try {
      if (isTreadingSoundOn) {
        AssetsAudioPlayer.newPlayer().open(
          Audio(AppImages.failAudio),
          autoStart: true,
          showNotification: false,
        );
      }
    } catch (e) {
      print(e);
    }
  }
  showToastWidget(
      Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        color: AppColors().redColor,
        child: Row(
          children: [
            Icon(
              Icons.error,
              color: AppColors().whiteColor,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 80.w,
              child: Text(
                msg,
                style: TextStyles().drawerTitleText,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
      context: context,
      position: StyledToastPosition(align: Alignment.topCenter));
  // Get.showSnackbar(GetSnackBar(
  //   messageText: Row(
  //     children: [
  //       Icon(
  //         Icons.error,
  //         color: AppColors().whiteColor,
  //       ),
  //       const SizedBox(
  //         width: 10,
  //       ),
  //       SizedBox(
  //         width: 80.w,
  //         child: Text(
  //           msg,
  //           style: TextStyles().drawerTitleText,
  //           maxLines: 3,
  //         ),
  //       ),
  //     ],
  //   ),
  //   duration: const Duration(seconds: 3),
  //   snackPosition: SnackPosition.TOP,
  //   backgroundColor: AppColors().redColor,
  // ));
}

void showSuccessToast(String msg, BuildContext context, {bool isPlayAudio = false}) async {
  if (isPlayAudio) {
    try {
      if (isTreadingSoundOn) {
        AssetsAudioPlayer.newPlayer().open(
          Audio(AppImages.successAudio),
          autoStart: true,
          showNotification: false,
        );
      }
    } catch (e) {
      print(e);
    }
  }
  showToastWidget(
      Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        color: Colors.green,
        child: Row(
          children: [
            Icon(
              Icons.error,
              color: AppColors().whiteColor,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 80.w,
              child: Text(
                msg,
                style: TextStyles().drawerTitleText,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
      context: context,
      position: StyledToastPosition(align: Alignment.topCenter));
  // Get.showSnackbar(GetSnackBar(
  //   messageText: Row(
  //     children: [
  //       Icon(
  //         Icons.check,
  //         color: AppColors().whiteColor,
  //       ),
  //       const SizedBox(
  //         width: 10,
  //       ),
  //       SizedBox(
  //         width: 80.w,
  //         child: Text(
  //           msg,
  //           style: TextStyles().drawerTitleText,
  //           maxLines: 3,
  //         ),
  //       ),
  //     ],
  //   ),
  //   duration: const Duration(seconds: 3),
  //   snackPosition: SnackPosition.TOP,
  //   backgroundColor: Colors.green,
  // ));
}

String serverFormatDateTime(DateTime time) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(time.toLocal());
}

DateTime stringToDate(String time) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.parse(time);
}

String shortTime(DateTime time) {
  final DateFormat formatter = DateFormat('hh:mm a');
  return formatter.format(time.toLocal());
}

String fullTime(DateTime time) {
  final DateFormat formatter = DateFormat('hh:mm:ss a');
  return formatter.format(time.toLocal());
}

String shortFullDateTime(DateTime time) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss a');
  return formatter.format(time.toLocal());
}

String shortDate(DateTime date) {
  var utcTime = DateTime.utc(date.year, date.month, date.day, date.hour, date.minute, date.second, date.millisecond, date.microsecond);
  final DateFormat formatter = DateFormat('dd-MMM-yyyy');
  return formatter.format(utcTime);
}

String veryShortDate(DateTime date) {
  var utcTime = DateTime.utc(date.year, date.month, date.day, date.hour, date.minute, date.second, date.millisecond, date.microsecond);
  final DateFormat formatter = DateFormat('dd-MMM');
  return formatter.format(utcTime);
}

extension DateTimeExtension on DateTime {
  String timeAgo() {
    Duration diff = DateTime.now().difference(this);
    if (diff.inDays > 365) return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30) return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7) return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0) return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0) return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0) return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    return "just now";
  }

  String formatDate() {
    final formatter = DateFormat('MMMM dd, y');
    return formatter.format(this);
  }

  String formatDateInHours() {
    final formatter = DateFormat('hh:mm aa');
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    var difference = now.difference(this).inDays;
    if (difference == 0) {
      if (now.day - 1 == day) {
        return 1;
      } else {
        return 0;
      }
    }
    return difference;
  }
}

Widget displayIndicator() {
  return Container(
    child: Center(
      child: CircularProgressIndicator(
        color: AppColors().blueColor,
        strokeWidth: 2,
      ),
    ),
  );
}

Widget dataNotFoundView(String msg) {
  return Container(
      width: 100.w,
      child: Center(
        child: Text(
          msg,
          style: TextStyle(fontSize: 15, fontFamily: Appfonts.family1Regular, color: AppColors().fontColor),
        ),
      ));
}

updateSystemOverlay() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Platform.isAndroid ? Brightness.light : Brightness.dark,
    statusBarBrightness: Platform.isAndroid ? Brightness.light : Brightness.dark,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarDividerColor: Colors.black,
  ));
}

SystemUiOverlayStyle getSystemUiOverlayStyle() {
  if (Platform.isAndroid) {
    if (currentisDarkModeOn) {
      return const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      );
    } else {
      return const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      );
    }
  } else {
    if (currentisDarkModeOn) {
      return const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      );
    } else {
      return const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      );
    }
  }
}

showPermissionDialog({String? message, String? acceptButtonTitle, String? rejectButtonTitle, Function? yesClick, Function? noclick}) {
  showDialog<String>(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
            titlePadding: EdgeInsets.zero,
            backgroundColor: AppColors().footerColor,
            surfaceTintColor: AppColors().fontColor,
            contentPadding: const EdgeInsets.only(top: 10, bottom: 16, left: 20, right: 20),
            // title: Container(
            //   //color: Colors.red,
            //   // width: 100.w,
            //   padding:  EdgeInsets.only(right: 60, left: 50),
            //   margin:  EdgeInsets.symmetric(vertical: 20),
            //   child: Image.asset(
            //     AppImages.logoNameImage,
            //     width: 30.w,
            //   ),
            // ),
            content: Padding(
              padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
              child: Text(
                message!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors().fontColor,
                  fontFamily: Appfonts.family1Medium,
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.only(bottom: 25),
            actions: <Widget>[
              Container(
                  width: 32.w,
                  height: 40,
                  // color: AppColors().extralightGrayThemeColor,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.transparent, width: 1), color: AppColors().redColor),
                  child: TextButton(
                    // style: ButtonStyle(

                    //   foregroundColor:
                    //       MaterialStateProperty.all<Color>(
                    //           AppColors().blackThemeColor),
                    // ),
                    onPressed: () {
                      if (noclick == null) {
                        Get.back();
                      } else {
                        noclick();
                      }
                    },
                    child: Text('No', style: TextStyle(fontFamily: Appfonts.family1Medium, fontSize: 14, color: AppColors().whiteColor)),
                  )),
              Container(
                  width: 32.w,
                  height: 40,
                  // color: AppColors().extralightGrayThemeColor,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.transparent, width: 1), color: AppColors().blueColor),
                  child: TextButton(
                    onPressed: () {
                      if (yesClick == null) {
                        Get.back();
                      } else {
                        yesClick();
                      }
                    },
                    child: Text('Yes', style: TextStyle(fontFamily: Appfonts.family1Medium, fontSize: 14, color: AppColors().whiteColor)),
                  )),
            ],
          ));
}

hideKeyboard() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  // FocusScope.of(context ?? Get.context!).requestFocus(FocusNode());
}
