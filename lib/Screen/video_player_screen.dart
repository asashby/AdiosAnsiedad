import 'dart:io' show File, Platform;


import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quantum/Controller/day_controller.dart';
import 'package:quantum/Model/day_info_model.dart';
import 'package:quantum/Utils/size_utils.dart';
import 'package:video_player/video_player.dart';

import '../Const/primary_theme.dart';
import '../main.dart';

class VideoPlayerScreen extends StatefulWidget {
  final int dayIndex;
  final int contentIndex;
  final Content? content;
  final bool isIdealProgram;

  const VideoPlayerScreen({ super.key,
    this.content,
    this.dayIndex = 0,
    this.contentIndex = 0,
    this.isIdealProgram = false
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  VideoPlayerController? videoPlayerController;
  FlickManager? flickManager;
  Duration playDuration = const Duration(seconds: 0);
  bool isLoading = false;
  final dayController = Get.put(DayController());

  loadVideo()async{
    if((widget.content?.path??"").contains("https")){
      setState(() {
        isLoading = true;
      });
      //File? videoPath = await cacheManager.getSingleFile(widget.content?.path??"",key: widget.content?.id??"");
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.content?.path??""));
      setState(() {
        isLoading = false;
      });
    }else{
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.content?.path??""));
    }
    flickManager = FlickManager(
      videoPlayerController: videoPlayerController!,
      autoPlay: false,
    );
    flickManager?.flickVideoManager?.addListener(() {
      playDuration = (flickManager?.flickVideoManager?.videoPlayerValue?.position??const Duration(seconds: 0));
      if(flickManager!.flickVideoManager!.isVideoEnded == true){
        Navigator.maybePop(context);
        dispose();
      }
    });

    // await Future.delayed(const Duration(milliseconds: 1000),(){
    //   flickManager?.flickControlManager?.seekForward(Duration(seconds: widget.content!.watchDuration??0));
    // });
    flickManager?.flickControlManager?.play();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVideo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(widget.isIdealProgram){
      dayController.setWatchDurationOfIdealProgram(playDuration.inSeconds, widget.dayIndex, widget.contentIndex);
    }else{
      dayController.setWatchDurationOfDay(playDuration.inSeconds, widget.dayIndex, widget.contentIndex);
    }
    flickManager?.dispose();
    videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light
        ),
      ),
      body: SafeArea(
        child: Visibility(
          visible: !isLoading,
          replacement: const Center(
            child: CircularProgressIndicator(
              color: PrimaryTheme.primaryColor,
              strokeWidth: 2,
            ),
          ),
          child: SizedBox(
            height: context.screenHeight,
            width: context.screenWidth,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 16/9,
                    child: videoPlayerController != null && flickManager != null ? FlickVideoPlayer(
                      flickManager: flickManager!,
                      preferredDeviceOrientation: [
                        Platform.isIOS ? DeviceOrientation.landscapeRight : DeviceOrientation.landscapeLeft
                      ],
                    ) : const SizedBox(),
                  ),
                ),
                const BackButton(color: Colors.white,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
