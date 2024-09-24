import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/constant/color.dart';
import 'package:market/constant/const_string.dart';
import 'package:market/constant/font_family.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/commonFunction.dart';
import '../../../../constant/commonWidgets.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appNavigationBar.dart';
import '../../../../main.dart';
import '../../../../modelClass/allSymbolListModelClass.dart';
import '../../../../modelClass/exchangeListModelClass.dart';
import '../../../../modelClass/getScriptFromSocket.dart';
import '../../../../modelClass/myUserListModelClass.dart';
import '../../../../modelClass/userWiseProfitLossSummaryModelClass.dart';
import '../../../../navigation/routename.dart';
import '../../../BaseViewController/baseController.dart';
import 'profitAndLossController.dart';

// ProfitAndLossScreen
class UserProfitAndLossScreen extends StatefulWidget {
  const UserProfitAndLossScreen({super.key});

  @override
  State<UserProfitAndLossScreen> createState() => _UserProfitAndLossScreenState();
}

class _UserProfitAndLossScreenState extends State<UserProfitAndLossScreen> {
  RxString fromDate = "Start Date".obs;
  RxString endDate = "End Date".obs;

  bool isApiCallRunning = false;
  bool isResetCall = false;
  Rx<UserData> selectedUser = UserData().obs;
  Rx<ExchangeData> selectedExchange = ExchangeData().obs;
  Rx<GlobalSymbolData> selectedScriptFromFilter = GlobalSymbolData().obs;

  List<UserData> arrUserDataDropDown = [];
  double totalPL = 0.0;
  double totalPLPer = 0.0;
  RxDouble totalPlWithBrk = 0.0.obs;
  List<UserWiseProfitLossData> arrPlList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserList();
    selectedUser.value = UserData(userId: Get.arguments);
    getProfitLossList("");
  }

  getUserList() async {
    // arrUserDataDropDown = constantValues!.userFilterType!;
    var response = await service.getMyUserListCall();
    if (response != null) {
      if (response.statusCode == 200) {
        arrUserDataDropDown = response.data ?? [];
        setState(() {});
      }
    }
  }

  getProfitLossList(String text, {bool isFromClear = false}) async {
    if (isFromClear) {
      isResetCall = true;
    } else {
      isApiCallRunning = true;
    }

    setState(() {});
    var response = await service.userWiseProfitLossListCall(1, text, selectedUser.value.userId ?? "");
    arrPlList = response!.data ?? [];
    totalPlWithBrk.value = 0.0;
    for (var element in arrPlList) {
      for (var i = 0; i < element.childUserDataPosition!.length; i++) {
        if (element.arrSymbol != null) {
          var symbolObj = element.arrSymbol!.firstWhere((obj) => element.childUserDataPosition![i].symbolId == obj.id);

          element.childUserDataPosition![i].profitLossValue = element.childUserDataPosition![i].totalQuantity! < 0
              ? (double.parse(symbolObj.ask.toString()) - element.childUserDataPosition![i].price!) * element.childUserDataPosition![i].totalQuantity!
              : (double.parse(symbolObj.bid.toString()) - double.parse(element.childUserDataPosition![i].price!.toStringAsFixed(2))) * element.childUserDataPosition![i].totalQuantity!;
        }
      }

      var pl = element.role == UserRollList.user ? element.profitLoss! : element.childUserProfitLossTotal!;

      element.totalProfitLossValue = 0.0;
      for (var value in element.childUserDataPosition!) {
        element.totalProfitLossValue += value.profitLossValue ?? 0.0;
      }
      var brkTotal = 0.0;
      if (element.role == UserRollList.master) {
        brkTotal = double.parse(element.childUserBrokerageTotal!.toString());
      } else {
        brkTotal = double.parse(element.brokerageTotal!.toString());
      }

      element.plWithBrk = element.totalProfitLossValue + pl - brkTotal;
      totalPlWithBrk.value = totalPlWithBrk.value + element.plWithBrk;
      var m2m = element.totalProfitLossValue;
      var sharingPer = element.role == UserRollList.user ? element.profitAndLossSharingDownLine! : element.profitAndLossSharing!;
      var total = pl + m2m;
      var finalValue = total * sharingPer / 100;

      finalValue = finalValue * -1;
      totalPLPer = totalPLPer + finalValue;

      element.plSharePer = finalValue;

      finalValue = finalValue + element.parentBrokerageTotal!;
      element.netPL = finalValue;

      finalValue = finalValue + element.parentBrokerageTotal!;
      totalPL = totalPL + finalValue;
    }
    isApiCallRunning = false;
    isResetCall = false;
    setState(() {});
    var arrTemp = [];
    arrPlList.forEach((userObj) {
      for (var element in userObj.childUserDataPosition!) {
        if (!arrTemp.contains(element.symbolName)) {
          if (!arrSymbolNames.contains(element.symbolName)) {
            arrTemp.insert(0, element.symbolName);
            arrSymbolNames.insert(0, element.symbolName!);
          }
        }
      }
    });

    if ((arrSymbolNames.isNotEmpty)) {
      var txt = {"symbols": arrSymbolNames};
      socket.connectScript(jsonEncode(txt));
    }
  }

  listenUserWiseProfitLossScriptFromSocket(GetScriptFromSocket socketData) {
    if (socketData.data != null) {
      arrPlList.forEach((userObj) {
        for (var i = 0; i < userObj.childUserDataPosition!.length; i++) {
          if (socketData.data!.symbol == userObj.childUserDataPosition![i].symbolName) {
            // userObj.childUserDataPosition![i].profitLossValue = userObj.childUserDataPosition![i].tradeType!.toUpperCase() == "BUY"
            //     ? (double.parse(socketData.data!.bid.toString()) - userObj.childUserDataPosition![i].price!) * userObj.childUserDataPosition![i].quantity!
            //     : (userObj.childUserDataPosition![i].price! - double.parse(socketData.data!.ask.toString())) * userObj.childUserDataPosition![i].quantity!;

            userObj.childUserDataPosition![i].profitLossValue = userObj.childUserDataPosition![i].totalQuantity! < 0
                ? (double.parse(socketData.data!.ask.toString()) - userObj.childUserDataPosition![i].price!) * userObj.childUserDataPosition![i].totalQuantity!
                : (double.parse(socketData.data!.bid.toString()) - double.parse(userObj.childUserDataPosition![i].price!.toStringAsFixed(2))) * userObj.childUserDataPosition![i].totalQuantity!;

            var pl = userObj.role == UserRollList.user ? userObj.profitLoss! : userObj.childUserProfitLossTotal!;
            userObj.totalProfitLossValue = 0.0;
            for (var element in userObj.childUserDataPosition!) {
              userObj.totalProfitLossValue += element.profitLossValue ?? 0.0;
            }
            var brkTotal = 0.0;
            if (userObj.role == UserRollList.master) {
              brkTotal = double.parse(userObj.childUserBrokerageTotal!.toString());
            } else {
              brkTotal = double.parse(userObj.brokerageTotal!.toString());
            }

            userObj.plWithBrk = userObj.totalProfitLossValue + pl - brkTotal;

            var m2m = userObj.totalProfitLossValue;
            var sharingPer = userObj.role == UserRollList.user ? userObj.profitAndLossSharingDownLine! : userObj.profitAndLossSharing!;
            var total = pl + m2m;
            var finalValue = total * sharingPer / 100;

            // finalValue = finalValue * -1;
            userObj.plSharePer = finalValue * -1;

            var sharingPLPer = userObj.role == UserRollList.user ? userObj.profitAndLossSharingDownLine! : userObj.profitAndLossSharing!;
            var totalPL = pl + m2m;
            var finalValuePL = (totalPL * sharingPLPer) / 100;
            finalValuePL = finalValuePL * -1;
            finalValuePL = finalValuePL + userObj.parentBrokerageTotal!;
            userObj.netPL = finalValuePL;
          }
        }
      });
      totalPL = 0.0;
      totalPLPer = 0.0;
      totalPlWithBrk.value = 0.0;
      for (var element in arrPlList) {
        totalPLPer = totalPLPer + element.plSharePer;
        totalPL = totalPL + element.netPL;
        totalPlWithBrk.value = totalPlWithBrk.value + element.plWithBrk;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
          },
          // isTrailingDisplay: true,
          trailingIcon: SizedBox(
            width: 45,
            child: Image.asset(
              AppImages.filterIcon,
              width: 25,
              height: 25,
              color: AppColors().blueColor,
            ),
          ),
          // onTrailingButtonPress: () {
          //   filterPopupDialog();
          // },
          headerTitle: "Profit & Loss",
          backGroundColor: AppColors().headerBgColor,
        ),
        body: mainContent(context));
  }

  filterPopupDialog({String? message, String? subMessage, Function? CancelClick, Function? DeleteClick}) {
    showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
            titlePadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: AppColors().bgColor,
            surfaceTintColor: AppColors().bgColor,
            insetPadding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 32.h,
            ),
            content: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              userListDropDown(),
              buttonsView(),
            ])));
  }

  Widget mainContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              width: 1100,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("Our : ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: Appfonts.family1SemiBold,
                              color: AppColors().DarkText,
                            )),
                        Text(totalPL.toStringAsFixed(2),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: Appfonts.family1SemiBold,
                              color: AppColors().DarkText,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("Net P/L : ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: Appfonts.family1SemiBold,
                              color: AppColors().DarkText,
                            )),
                        Text(totalPlWithBrk.toStringAsFixed(2),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: Appfonts.family1SemiBold,
                              color: AppColors().DarkText,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 3.h,
                    color: AppColors().whiteColor,
                    child: Row(
                      children: [
                        // Container(
                        //   width: 30,
                        // ),

                        listTitleContent(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        clipBehavior: Clip.hardEdge,
                        itemCount: arrPlList.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return profitAndLossContent(context, index);
                        }),
                  ),
                  Container(
                    height: 2.h,
                    color: AppColors().headerBgColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget profitAndLossContent(BuildContext context, int index) {
    // var scriptValue = arrUserOderList[index];
    if (isApiCallRunning) {
      return Container(
        margin: EdgeInsets.only(bottom: 3.h),
        child: Shimmer.fromColors(
            child: Container(
              height: 3.h,
              color: Colors.white,
            ),
            baseColor: AppColors().whiteColor,
            highlightColor: AppColors().grayBg),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {});
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (arrPlList[index].role! == UserRollList.user)
                valueBox(
                  "",
                  60,
                  index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                  AppColors().DarkText,
                  index,
                ),
              if (arrPlList[index].role! != UserRollList.user)
                valueBox(
                  "",
                  isImage: true,
                  60,
                  strImage: AppImages.viewIcon,
                  index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                  AppColors().DarkText,
                  index,
                  onClickImage: () {
                    Get.to(() => UserProfitAndLossScreen(), arguments: arrPlList[index].userId!, preventDuplicates: false);
                  },
                ),
              valueBox(
                arrPlList[index].userName ?? "",
                100,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                arrPlList[index].role == UserRollList.user ? arrPlList[index].brkSharingDownLine!.toString() : arrPlList[index].brkSharing!.toString(),
                100,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                arrPlList[index].role == UserRollList.user ? arrPlList[index].profitLoss!.toStringAsFixed(2) : arrPlList[index].childUserProfitLossTotal!.toStringAsFixed(2),
                160,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                arrPlList[index].role == UserRollList.master ? arrPlList[index].childUserBrokerageTotal!.toStringAsFixed(2) : arrPlList[index].brokerageTotal!.toStringAsFixed(2),
                120,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                arrPlList[index].totalProfitLossValue.toStringAsFixed(2),
                120,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              valueBox(
                arrPlList[index].plWithBrk.toStringAsFixed(2),
                120,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                AppColors().DarkText,
                index,
              ),
              // valueBox(
              //   arrPlList[index].plSharePer.toStringAsFixed(2),
              //   120,
              //   index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              //   arrPlList[index].plSharePer < 0 ? AppColors().redColor : AppColors().DarkText,
              //   index,
              // ),
              // valueBox(
              //   arrPlList[index].parentBrokerageTotal!.toStringAsFixed(2),
              //   100,
              //   index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
              //   AppColors().DarkText,
              //   index,
              // ),
              valueBox(
                arrPlList[index].netPL.toStringAsFixed(2),
                100,
                index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                arrPlList[index].netPL > 0
                    ? AppColors().greenColor
                    : arrPlList[index].netPL < 0.0
                        ? AppColors().redColor
                        : AppColors().DarkText,
                index,
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget listTitleContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleBox("VIEW", width: 60),

        titleBox("USERNAME", width: 100),
        titleBox("SHARING %", width: 100),
        titleBox("RELEASE P/L", width: 160),
        titleBox("BRK", width: 120),
        titleBox("M2M", width: 120),
        titleBox("NET P/L", width: 120),
        // titleBox("P/L SHARE %", width: 120),
        // titleBox("BRK", width: 100),
        titleBox("OUR", width: 100),
      ],
    );
  }

  Widget userListDropDown() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      height: 6.5.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().grayLightLine,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3)),
      // color: AppColors().whiteColor,
      padding: EdgeInsets.only(right: 10),
      child: Obx(() {
        return Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<UserData>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Image.asset(
                  AppImages.arrowDown,
                  height: 25,
                  width: 25,
                  color: AppColors().fontColor,
                ),
              ),
              hint: Text(
                'Select User',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: Appfonts.family1Medium,
                  color: AppColors().DarkText,
                ),
              ),
              items: arrUserDataDropDown
                  .map((UserData item) => DropdownMenuItem<UserData>(
                        value: item,
                        child: Text(
                          item.userName ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: Appfonts.family1Medium,
                            color: AppColors().DarkText,
                          ),
                        ),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return arrUserDataDropDown
                    .map((UserData item) => DropdownMenuItem<UserData>(
                          value: item,
                          child: Text(
                            item.userName ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: Appfonts.family1Medium,
                              color: AppColors().DarkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectedUser.value.userId != null ? selectedUser.value : null,
              onChanged: (UserData? value) {
                selectedUser.value = value!;
                setState(() {});
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                // height: 54,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 54,
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 300),
            ),
          ),
        );
      }),
    );
  }

  Widget buttonsView() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 35.w,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Reset",
              textSize: 16,
              onPress: () {
                selectedUser.value = UserData();
                ();
                Get.back();
                setState(() {});
                getProfitLossList("");
                // getAccountSummaryNewList("", isFromClear: true, isFromfilter: true);
              },
              bgColor: AppColors().grayLightLine,
              isFilled: true,
              textColor: AppColors().DarkText,
              isTextCenter: true,
              isLoading: isResetCall,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          SizedBox(
            width: 35.w,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Done",
              textSize: 16,
              // buttonWidth: 36.w,
              onPress: () {
                Get.back();
                getProfitLossList("");
                // getAccountSummaryNewList("", isFromfilter: true);
              },
              bgColor: AppColors().blueColor,
              isFilled: true,
              textColor: AppColors().whiteColor,
              isTextCenter: true,
              isLoading: isApiCallRunning,
            ),
          ),
          // SizedBox(width: 5.w,),
        ],
      ),
    );
  }
}
