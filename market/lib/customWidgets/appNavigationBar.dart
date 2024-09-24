import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/navigation/routename.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constant/assets.dart';
import '../constant/color.dart';
import '../constant/constantTextStyle.dart';
import '../constant/font_family.dart';
import '../constant/utilities.dart';

// ignore_for_file: must_be_immutable
class appNavigationBar extends AppBar {
  appNavigationBar(
      {Key? key,
      this.scaffoldKey,
      this.headerTitle,
      this.isBackDisplay,
      this.isTrailingDisplay,
      this.isMoreDisplay,
      this.isTVDisplay,
      this.onTVButtonPress,
      this.isForEdit,
      this.isForShare,
      this.onDrawerButtonPress,
      this.onTrailingButtonPress,
      this.onMoreButtonPress,
      this.onBackButtonPress,
      this.centerIcon,
      this.backGroundColor,
      this.trailingIcon,
      this.isAddDisplay,
      this.onAddButtonPress,
      this.isMarketDisplay,
      this.leadingTitleText,
      this.leadingTitleColor})
      : super(key: key);
  GlobalKey<ScaffoldState>? scaffoldKey;
  String? headerTitle;
  bool? isBackDisplay;
  bool? isTrailingDisplay;
  bool? isMoreDisplay;
  bool? isTVDisplay;
  bool? isAddDisplay;
  bool? isForEdit;
  bool? isForShare;
  Widget? centerIcon;
  Function? onDrawerButtonPress;
  Function? onBackButtonPress;
  Function? onTVButtonPress;
  Function? onMoreButtonPress;
  Function? onAddButtonPress;
  Function? onTrailingButtonPress;
  Color? backGroundColor;
  Widget? trailingIcon;
  bool? isMarketDisplay;
  String? leadingTitleText;
  Color? leadingTitleColor;
  bool turnedValue = false;
  @override
  State<appNavigationBar> createState() => _appNavigationBar();
}

class _appNavigationBar extends State<appNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        systemOverlayStyle: getSystemUiOverlayStyle(),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: widget.backGroundColor ?? AppColors().headerBgColor,
        foregroundColor: widget.backGroundColor ?? AppColors().fontColor,
        flexibleSpace: Container(color: widget.backGroundColor ?? AppColors().whiteColor),
        leading: widget.isBackDisplay != null
            ? SizedBox(
                height: 24.sp,
                width: 24.sp,
                child: widget.isBackDisplay != null
                    ? IconButton(
                        //Menu Icon Start
                        onPressed: () {
                          if (widget.isBackDisplay == true) {
                            widget.onBackButtonPress!();
                          } else if (widget.isBackDisplay != null) {
                            Get.back();
                          } else {
                            widget.onDrawerButtonPress!();
                          }
                        },
                        icon: widget.isBackDisplay != null
                            ? Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Image.asset(
                                  AppImages.backIcon,
                                  color: AppColors().fontColor,
                                ),
                              )
                            : Image.asset(
                                AppImages.settingIcon,
                                width: 24,
                                color: AppColors().footerColor,
                              ),
                      )
                    : null)
            : null,
        title: widget.centerIcon != null
            ? Center(
                child: widget.centerIcon,
              )
            : Row(
                mainAxisAlignment: widget.isMarketDisplay == null ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  widget.isMarketDisplay != null
                      ? Center(
                          child: Text(widget.leadingTitleText ?? "Market Watch",
                              style: TextStyle(fontSize: 20, fontFamily: widget.leadingTitleColor != null ? Appfonts.family1ExtraBold : Appfonts.family1SemiBold, color: widget.leadingTitleColor != null ? widget.leadingTitleColor : AppColors().DarkText)))
                      : const SizedBox(),
                  Center(
                      child: Text(
                    widget.headerTitle ?? "",
                    style: TextStyles().navTitleText,
                  )),
                ],
              ),
        actions: [
          Row(
            children: [
              widget.isTVDisplay != null
                  ? StatefulBuilder(builder: (context, StateSetter) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: IconButton(
                            visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                            padding: EdgeInsets.zero,
                            // Photo Stack Icon
                            onPressed: () async {
                              if (widget.onTVButtonPress != null) {
                                widget.onTVButtonPress!();
                              }
                            },
                            icon: Icon(
                              Icons.tv,
                              color: AppColors().DarkText,
                            )),
                      );
                    })
                  : SizedBox(
                      width: 0.sp,
                    ),
              widget.isAddDisplay != null
                  ? StatefulBuilder(builder: (context, StateSetter) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: IconButton(
                            visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                            padding: EdgeInsets.zero,
                            // Photo Stack Icon
                            onPressed: () async {
                              if (widget.onAddButtonPress != null) {
                                widget.onAddButtonPress!();
                              }
                            },
                            icon: Icon(
                              Icons.add,
                              color: AppColors().DarkText,
                            )),
                      );
                    })
                  : SizedBox(
                      width: 0.sp,
                    ),
              SizedBox(
                width: 10,
              ),
              widget.isTrailingDisplay != null
                  ? widget.trailingIcon != null
                      ? Container(
                          // margin: EdgeInsets.only(right: 10),
                          child: IconButton(
                            visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                            padding: EdgeInsets.zero,
                            // Photo Stack Icon
                            onPressed: () async {
                              if (widget.onTrailingButtonPress != null) {
                                widget.onTrailingButtonPress!();
                              } else {
                                Get.toNamed(RouterName.notificationScreen);
                              }
                            },
                            icon: widget.trailingIcon!,
                          ),
                        )
                      : const SizedBox(
                          width: 0,
                        )
                  : const SizedBox(
                      width: 0,
                    ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ]);
  }
}
