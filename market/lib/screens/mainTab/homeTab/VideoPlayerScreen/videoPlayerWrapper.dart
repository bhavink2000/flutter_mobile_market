import 'package:flutter/material.dart';

import 'package:market/screens/mainTab/homeTab/VideoPlayerScreen/videoPlayerController.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../BaseViewController/baseController.dart';

class VideoPlayerScreen extends BaseView<videoPlayerController> {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return YoutubePlayerScaffold(
      backgroundColor: Colors.black,
      controller: controller.playerController!,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return SafeArea(child: player);
      },
    );
    // return Scaffold(
    //     appBar: appNavigationBar(
    //       isBackDisplay: true,
    //       onBackButtonPress: () {
    //         controller.playerController!.stopVideo();
    //         controller.playerController!.close();
    //         controller.playerController = null;
    //         Get.back();
    //       },
    //       headerTitle: "",
    //       backGroundColor: AppColors().headerBgColor,
    //     ),
    //     backgroundColor: AppColors().headerBgColor,
    //     body: Container(
    //       width: 100.w,
    //       height: 90.h,
    //       child: YoutubePlayer(
    //         controller: controller.playerController!,
    //         aspectRatio: 16 / 9,
    //       ),
    //     ));
  }
}
