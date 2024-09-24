import 'package:flutter/cupertino.dart';

import 'color.dart';
import 'font_family.dart';

class TextStyles {
  var textFieldText = TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().fontColor);
  var textFieldFocusText = TextStyle(fontSize: 16, fontFamily: Appfonts.family1Medium, color: AppColors().fontColor);
  var drawerTitleText = TextStyle(
    fontSize: 14,
    color: AppColors().whiteColor,
    fontFamily: Appfonts.family1Medium,
  );
  var navTitleText = TextStyle(
    fontSize: 16,
    color: AppColors().blueColor,
    fontFamily: Appfonts.family1SemiBold,
  );
}
