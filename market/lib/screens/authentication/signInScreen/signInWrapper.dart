import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/font_family.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constant/assets.dart';
import '../../../constant/color.dart';
import '../../../customWidgets/appButton.dart';
import '../../../customWidgets/appTextField.dart';
import '../../../main.dart';
import '../../BaseViewController/baseController.dart';
import 'signInController.dart';

class SignInScreen extends BaseView<SignInController> {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors().bgColor,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                // Row(
                //   children: [
                //     Container(
                //       child: Image.asset(
                //         AppImages.appLogo,
                //         width: 50,
                //         height: 40,
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Text("Bazaar 2.0",
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontFamily: Appfonts.family1Medium,
                //           color: AppColors().blueColor,
                //         )),
                //   ],
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 100,
                  child: Center(
                    child: Image.asset(AppImages.appLoginLogo),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                // Text("Login",
                //     style: TextStyle(
                //       fontSize: 22,
                //       fontFamily: Appfonts.family1SemiBold,
                //       color: AppColors().DarkText,
                //     )),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  height: 1.h,
                ),
                // CustomTextField(
                //   type: 'ServerName',
                //   keyBoardType: TextInputType.text,
                //   isEnabled: true,
                //   isOptional: false,
                //   inValidMsg: AppString.emptyServer,
                //   isNoNeededCapital: true,
                //   placeHolderMsg: "Server name",
                //   labelMsg: "Server Name",
                //   emptyFieldMsg: AppString.emptyServer,
                //   controller: controller.serverController,
                //   focus: controller.serverFocus,
                //   isSecure: false,
                //   keyboardButtonType: TextInputAction.next,
                //   maxLength: 64,
                //   sufixIcon: SizedBox(
                //     width: 35,
                //     child: Row(
                //       children: [
                //         Container(
                //           width: 2,
                //           height: 25,
                //           color: AppColors().grayBorderColor,
                //           margin: EdgeInsets.only(right: 10),
                //         ),
                //         Image.asset(
                //           AppImages.earthIcon,
                //           width: 22,
                //           height: 22,
                //           color: AppColors().iconsColor,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // searchBox(),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField(
                  type: 'UserName',
                  keyBoardType: TextInputType.text,
                  isEnabled: true,
                  isOptional: false,
                  isNoNeededCapital: true,
                  inValidMsg: AppString.emptyUserName,
                  placeHolderMsg: "Enter your user name",
                  labelMsg: "User Name",
                  emptyFieldMsg: AppString.emptyUserName,
                  controller: controller.userNameController,
                  focus: controller.userNameFocus,
                  isSecure: false,
                  keyboardButtonType: TextInputAction.next,
                  maxLength: 64,
                  sufixIcon: SizedBox(
                    width: 35,
                    child: Row(
                      children: [
                        Container(
                          width: 2,
                          height: 25,
                          color: AppColors().grayBorderColor,
                          margin: EdgeInsets.only(right: 10),
                        ),
                        Image.asset(
                          AppImages.userIcon,
                          width: 22,
                          height: 22,
                          color: AppColors().iconsColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField(
                  type: 'Password',
                  keyBoardType: TextInputType.text,
                  isEnabled: true,
                  isOptional: false,
                  inValidMsg: AppString.emptyPassword,
                  placeHolderMsg: "Enter your password",
                  labelMsg: "Password",
                  emptyFieldMsg: AppString.emptyPassword,
                  controller: controller.passwordController,
                  focus: controller.passwordFocus,
                  isSecure: controller.isEyeOpen,
                  maxLength: 20,
                  keyboardButtonType: TextInputAction.done,
                  sufixIcon: GestureDetector(
                    onTap: () {
                      controller.isEyeOpen = !controller.isEyeOpen;
                      controller.update();
                    },
                    child: SizedBox(
                      width: 35,
                      child: Row(
                        children: [
                          Container(
                            width: 2,
                            height: 25,
                            color: AppColors().grayBorderColor,
                            margin: EdgeInsets.only(right: 10),
                          ),
                          Image.asset(
                            controller.isEyeOpen ? AppImages.eyeCloseIcon : AppImages.eyeOpenIcon,
                            width: 22,
                            height: 22,
                            color: AppColors().iconsColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Obx(() {
                  return CustomButton(
                    isEnabled: true,
                    shimmerColor: AppColors().whiteColor,
                    title: "Log In",
                    textSize: 16,
                    // fontFamily: Appfonts.family1Medium,
                    onPress: () {
                      // Get.offAllNamed(RouterName.mainTab);
                      controller.callForSignIn();
                    },
                    bgColor: AppColors().blueColor,
                    isFilled: true,
                    textColor: AppColors().whiteColor,
                    isTextCenter: true,
                    isLoading: controller.isLoadingSignIn.value,
                  );
                }),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text("Sign Up", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family2, color: AppColors().DarkText, overflow: TextOverflow.ellipsis)),
                      Spacer(),
                      Text("Forgot Password", style: TextStyle(fontSize: 14, fontFamily: Appfonts.family2, color: AppColors().DarkText, overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(child: Text("This application is used for training purpose only.", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: AppColors().DarkText, overflow: TextOverflow.ellipsis))),
                Spacer(),
                Spacer(),

                Center(child: Text("Version : ${packageInfo!.version}", style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: AppColors().DarkText.withOpacity(0.3), overflow: TextOverflow.ellipsis)))
              ],
            ),
          ),
        ));
  }

  Widget searchBox() {
    return Container(
      // width: 370,
      // height: 4.h,
      // margin: const EdgeInsets.symmetric(vertical: 6.5),
      // decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), borderRadius: BorderRadius.circular(3)),
      child: Autocomplete<String>(
        displayStringForOption: (String option) => option,
        fieldViewBuilder: (BuildContext context, TextEditingController searchEditingController, FocusNode searchFocus, VoidCallback onFieldSubmitted) {
          return CustomTextField(
            type: 'Search',
            keyBoardType: TextInputType.text,
            isEnabled: true,
            isOptional: false,
            isNoNeededCapital: true,
            // focusBorderColor: AppColors().blueColor,
            inValidMsg: AppString.emptyUserName,
            placeHolderMsg: "Server Name",
            labelMsg: "Server Name",
            emptyFieldMsg: AppString.emptyUserName,
            controller: searchEditingController,
            focus: searchFocus,
            isSecure: false,
            keyboardButtonType: TextInputAction.next,
            maxLength: 64,
            // isLogin: true,
            // onDoneClick: () {
            //   controller.callForSignIn(context);
            // },
            sufixIcon: SizedBox(
              width: 35,
              child: Row(
                children: [
                  Container(
                    width: 2,
                    height: 25,
                    color: AppColors().grayBorderColor,
                    margin: EdgeInsets.only(right: 10),
                  ),
                  Image.asset(
                    AppImages.earthIcon,
                    width: 22,
                    height: 22,
                    color: AppColors().iconsColor,
                  ),
                ],
              ),
            ),
          );
        },
        optionsViewBuilder: (context, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
            ),
            child: Container(
              height: 50,
              width: 370, // <-- Right here !
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                shrinkWrap: false,
                itemBuilder: (BuildContext context, int index) {
                  final String option = controller.arrServerName.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(controller.arrServerName.elementAt(index)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: Appfonts.family1Medium,
                          color: AppColors().DarkText,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        // optionsMaxHeight: 30.h,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          controller.serverController.text = textEditingValue.text;
          if (textEditingValue.text == '' || textEditingValue.text.length < 3) {
            return const Iterable<String>.empty();
          }

          return await controller.arrServerName.where((element) => element.contains(textEditingValue.text));
        },
        onSelected: (String selection) {
          debugPrint('You just selected $selection');
          controller.serverController.text = selection;
        },
      ),
    );
  }
}
