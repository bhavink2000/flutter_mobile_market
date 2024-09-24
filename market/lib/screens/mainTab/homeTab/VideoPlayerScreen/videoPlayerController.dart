import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../BaseViewController/baseController.dart';

class videoPlayerControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => videoPlayerController());
  }
}

class videoPlayerController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  YoutubePlayerController? playerController;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    playerController = YoutubePlayerController(
      params: YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    playerController!.loadVideoById(videoId: "TD0A7fHAxKw");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
