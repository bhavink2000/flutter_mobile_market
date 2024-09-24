import 'package:flutter/cupertino.dart';

import 'package:market/constant/color.dart';
import 'package:market/constant/font_family.dart';
import 'package:market/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget titleBox(String title, {double width = 0.0, Function? onClickImage, bool isImage = false, String? strImage = ""}) {
  return isImage == false
      ? Container(
          color: currentisDarkModeOn ? AppColors().grayColor : AppColors().blueColor.withOpacity(0.1),
          width: width,
          height: 3.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(title, style: TextStyle(fontSize: 14, fontFamily: Appfonts.family1SemiBold, color: AppColors().fontColor)),
              Spacer(),
              Container(
                height: 3.h,
                width: 2,
                color: AppColors().whiteColor,
              )
            ],
          ),
        )
      : GestureDetector(
          onTap: () {
            if (onClickImage != null) {
              onClickImage();
            }
          },
          child: Container(
            width: width,
            color: currentisDarkModeOn ? AppColors().grayColor : AppColors().blueColor.withOpacity(0.1),
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Image.asset(
              strImage ?? "",
              width: 20,
              height: 20,
            ),
          ),
        );
}

Widget valueBox(String title, double width, Color? bgColor, Color? textColor, int index,
    {isUnderlined = false, Function? onClickValue, Function? onClickImage, bool isImage = false, String? strImage = ""}) {
  return isImage == false
      ? Container(
          width: width,
          color: bgColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (isUnderlined) {
                    if (onClickValue != null) {
                      onClickValue();
                    }
                  }
                },
                child: Container(
                  width: width - 20,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: Appfonts.family1Regular,
                          color: textColor != null ? textColor : AppColors().DarkText,
                          decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none)),
                ),
              ),
              // SizedBox(
              //   width: 20,
              // ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: 3.h,
                width: 2,
                color: AppColors().whiteColor,
              )
            ],
          ),
        )
      : GestureDetector(
          onTap: () {
            if (onClickImage != null) {
              onClickImage();
            }
          },
          child: Container(
            width: width,
            color: bgColor,
            padding: EdgeInsets.symmetric(vertical: 9),
            child: Image.asset(
              strImage ?? "",
              width: 20,
              height: 20,
              color: AppColors().fontColor,
            ),
          ),
        );
}
