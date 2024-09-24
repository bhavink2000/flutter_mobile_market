import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:market/modelClass/tabWiseSymbolListModelClass.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant/color.dart';
import '../../../../constant/font_family.dart';
import '../../../../customWidgets/appNavigationBarwithBack.dart';
import '../../../../modelClass/getScriptFromSocket.dart';
import '../../../BaseViewController/baseController.dart';
import '../../tabScreen/MainTabController.dart';
import '../homeController.dart';

class EditWatchListScreen extends BaseView<HomeController> {
  const EditWatchListScreen({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appNavigationBar(
          isBackDisplay: true,
          onBackButtonPress: () {
            Get.back();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          headerTitle: "Edit WatchList",
          backGroundColor: AppColors().headerBgColor,
          onDrawerButtonPress: () {
            var mainTab = Get.find<MainTabController>();
            if (mainTab.scaffoldKey.currentState!.isDrawerOpen) {
              mainTab.scaffoldKey.currentState!.closeDrawer();
              //close drawer, if drawer is open
            } else {
              mainTab.scaffoldKey.currentState!.openDrawer();
              //open drawer, if drawer is closed
            }
          }),
      backgroundColor: AppColors().headerBgColor,
      body: Column(
        children: [
          Expanded(
            flex: 12,
            child: Container(
              margin: EdgeInsets.only(top: 3.h),
              width: 100.w,
              decoration: BoxDecoration(color: AppColors().bgColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(10))),
              child: Container(
                width: 100.w,
                height: 100.h,
                child: Container(
                  child: controller.isApiCallRunning.value
                      ? Center(
                          child: Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: AppColors().blueColor,
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : ReorderableListView.builder(
                          itemCount: controller.arrSymbol.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ColoredBox(
                              key: Key('$index'),
                              color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    color: Colors.transparent,
                                    child: bigScriptlistContent(context, index),
                                  ),
                                ],
                              ),
                            );
                          },
                          onReorder: (int oldIndex, int newIndex) {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final SymbolData item = controller.arrSymbol.removeAt(oldIndex);
                            controller.arrSymbol.insert(newIndex, item);
                            final ScriptData item1 = controller.arrScript.removeAt(oldIndex);
                            controller.arrScript.insert(newIndex, item1);
                          },
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bigScriptlistContent(BuildContext context, int index) {
    return Container(
      width: 95.w,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Card(
        elevation: 3,
        color: AppColors().grayBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text('${controller.arrSymbol[index].symbol}', style: TextStyle(fontSize: 12, fontFamily: Appfonts.family2, color: AppColors().DarkText, overflow: TextOverflow.ellipsis)),
            ),
            Spacer(),
            ReorderableDragStartListener(
              index: index,
              child: Container(
                width: 40.w,
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () async {
                    if (controller.isAddDeleteApiLoading == false) {
                      // controller.currentSelectedIndex = index;
                      // controller.isAddDeleteApiLoading = true;
                      var removeId = controller.arrSymbol[index].userTabSymbolId!;
                      controller.arrSymbol.remove(controller.arrSymbol[index]);
                      controller.update();
                      await controller.deleteSymbolFromTab(removeId);
                    }
                  },
                  icon: controller.isAddDeleteApiLoading && controller.currentSelectedIndex == index
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: AppColors().blueColor,
                          ))
                      : Icon(Icons.delete_forever_rounded, color: AppColors().blueColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
