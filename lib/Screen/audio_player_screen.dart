import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quantum/Const/primary_theme.dart';
import 'package:quantum/Controller/day_controller.dart';
import 'package:quantum/Model/day_info_model.dart';
import 'package:quantum/Utils/date_utils.dart';
import 'package:quantum/Utils/size_utils.dart';
import 'package:quantum/Widget/screen_layout_widget.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quantum/main.dart';

import '../Const/const_string.dart';
import '../Utils/custom_text_style.dart';

class AudioPlayerScreen extends StatefulWidget {
  final int dayIndex;
  final int contentIndex;
  Content? content;
  final bool isIdealProgram;

  AudioPlayerScreen({
    super.key,
    this.content,
    this.dayIndex = 0,
    this.contentIndex = 0,
    this.isIdealProgram = false
  });

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {

  double audioSlider = 0.7;
  double volumeSlider = 0.0;
  bool isPlay = true;
  bool isLoading = false;
  Duration totalDuration = const Duration(seconds: 0);
  Duration playDuration = const Duration(seconds: 0);

  final dayController = Get.put(DayController());

  final player = AudioPlayer();
  List<StreamSubscription> streams = [];

  loadAudio()async{
    streams.add(player.onPlayerStateChanged.listen((event)async {
      switch (event) {
        case PlayerState.stopped:
          break;
        case PlayerState.completed:
          player.pause();
          Navigator.pop(context);
          break;
        case PlayerState.paused:
          setState(() {
            isPlay = false;
          });
          break;
        case PlayerState.playing:
          setState(() {
            isPlay = true;
          });
          break;
        default:
          break;
      }
    }));
    totalDuration = Duration(seconds: widget.content?.duration??0);
    streams.add(player.onPositionChanged.listen((event) {
      if(event.inSeconds == totalDuration.inSeconds){
        player.pause();
        Navigator.pop(context);
        /*if(widget.content!.number == 1) {
          widget.content = dayController.getDayInfoByDayId(widget.dayIndex).contents![1];
          playDuration = Duration(seconds: 0);
          player.seek(playDuration);
        }else {
          Navigator.pop(context);
        }
        if(widget.content!.number == 2) {
          Navigator.pop(context);
        }*/
      }
      setState(() {
        playDuration = event;
      });
    }));
    // playDuration = Duration(seconds: widget.content?.watchDuration??0);
    player.setVolume(audioSlider);
    await playAudio();
    totalDuration = await player.getDuration()??const Duration(seconds: 0);
    player.setReleaseMode(ReleaseMode.release);
    setState(() {});
    streams.add(player.onDurationChanged.listen((event) {
      setState(() {
        totalDuration = event;
      });
    }));
  }

  Future playAudio()async{
    if((widget.content?.path??"").contains("https")){
      /*bool status = await cacheManager.getCacheFileStatus(widget.content?.path??"",key: widget.content?.id??"");
      if(!status){
        setState(() {
          isLoading = true;
        });
      }*/
      File? audioPath = await cacheManager.getSingleFile(widget.content?.path??"",key: widget.content?.id??"");
      await player.play(DeviceFileSource(audioPath.path),mode: PlayerMode.mediaPlayer);
      if(isLoading){
        setState(() {
          isLoading = false;
        });
      }
    }else{
      await player.play(AssetSource(widget.content?.path??""),mode: PlayerMode.mediaPlayer);
    }
    // player.seek(Duration(seconds: widget.content?.watchDuration??0));
  }

  playPauseAudio(){
    if(player.state == PlayerState.playing){
      player.pause();
    }else{
      player.resume();
    }
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
    for (var it in streams) {
      it.cancel();
    }
    player.stop().then((value){
      player.dispose();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAudio();
  }

  SliderThemeData sliderThemeData = SliderThemeData(
    overlayShape: SliderComponentShape.noThumb,
    trackHeight: 5,
    overlayColor: Colors.black.withOpacity(0.25),
    trackShape: GradientRectSliderTrackShape(
        activeGradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              PrimaryTheme.primaryColor,
              PrimaryTheme.darkGreyColor,
            ]
        ),
        inactiveGradiant: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.25),
              const Color(0xffE6D8FF),
            ]
        ),
        darkenInactive: false
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutWidget(
      title: "${widget.content?.title}",
      child: Visibility(
        visible: !isLoading,
        replacement: const Center(
          child: CircularProgressIndicator(
            color: PrimaryTheme.primaryColor,
            strokeWidth: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
                child: Text("${AppLocalizations.of(context)!.day.toUpperCase()} ${dayController.daysInfoList[widget.dayIndex].id??0}",style: CustomTextStyle.gold16_600.copyWith(fontWeight: FontWeight.w500),)),
            const Spacer(flex: 2),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(astImgPlayerRoundPng),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: (){
                    playPauseAudio();
                  },
                  child: Image.asset(isPlay ? astIcWhitePausePng : astIcWhitePlayPng,height: 70,width: 70),
                ),
              ],
            ),
            const SizedBox(height: 80,),
            Column(
              children: [
                SliderTheme(
                  data: sliderThemeData,
                  child: Slider(
                    value: playDuration.inSeconds.toDouble(),
                    max: totalDuration.inSeconds.toDouble(),
                    activeColor: PrimaryTheme.primaryColor,
                    thumbColor: const Color(0xffE6D8FF),
                    onChangeStart: (value){
                      if(isPlay){
                        player.pause();
                      }
                    },
                    onChangeEnd: (value){
                      player.seek(Duration(seconds: value.toInt()));
                      if(!isPlay){
                        player.resume();
                      }
                    },
                    onChanged: (double value) {
                      setState(() {
                        playDuration = Duration(seconds: value.toInt());
                      });
                    },
                  ),
                ),
                const SizedBox(height: 3,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(playDuration.convertHHMM,style: CustomTextStyle.darkGrey10_400,),
                      Text(totalDuration.convertHHMM,style: CustomTextStyle.darkGrey10_400,),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: (){
                    if(totalDuration.inSeconds - playDuration.inSeconds >= 10){
                      playDuration = Duration(seconds: playDuration.inSeconds-10);
                      player.seek(playDuration);
                    }else{
                      playDuration = Duration(seconds: playDuration.inSeconds-(totalDuration.inSeconds - playDuration.inSeconds));
                      player.seek(playDuration);
                    }
                  },
                  child: SvgPicture.asset(astIcPrevious10Svg,height: 30),
                ),
                SizedBox(width: context.screenWidth*0.08,),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: (){
                    playPauseAudio();
                  },
                  child: Image.asset(isPlay ? astIcPrimaryPausePng : astIcPrimaryPlayPng,height: 70,width: 70),
                ),
                SizedBox(width: context.screenWidth*0.08,),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: (){
                    if(totalDuration.inSeconds - playDuration.inSeconds >= 10){
                      playDuration = Duration(seconds: playDuration.inSeconds+10);
                      player.seek(playDuration);
                    }else{
                      playDuration = Duration(seconds: playDuration.inSeconds+(totalDuration.inSeconds - playDuration.inSeconds));
                      player.seek(playDuration);
                    }
                  },
                  child: SvgPicture.asset(astIcNext10Svg,height: 30),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                Image.asset(astIcLowSoundPng),
                const SizedBox(width: 5,),
                Expanded(
                  child: SliderTheme(
                    data: sliderThemeData,
                    child: Slider(
                      value: audioSlider,
                      min: 0,
                      max: 1,
                      activeColor: PrimaryTheme.primaryColor,
                      thumbColor: const Color(0xffE6D8FF),
                      onChanged: (double value) {
                        player.setVolume(value);
                        setState(() {
                          audioSlider = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                Image.asset(astIcHighSoundPng),
              ],
            ),
            /*Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: widget.contentIndex == 0,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: PrimaryTheme.primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: Size(88, 36),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      ),
                    ),
                    child: Text("SIGUIENTE AUDIO"),
                    onPressed: (){
                      Content content = dayController.getDayInfoByDayId(widget.dayIndex + 1).contents![1];
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => AudioPlayerScreen(
                          content: content,
                          contentIndex: widget.contentIndex + 1,
                          dayIndex: widget.dayIndex,
                          isIdealProgram: widget.isIdealProgram,
                        )),
                      );
                    },
                  ),
                )
              ],
            ),*/
            const Spacer(),
          ],
        ),
      ),
    );
  }
}


class GradientRectSliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  const GradientRectSliderTrackShape({
    this.activeGradient = const LinearGradient(
      colors: [
        Colors.red,
        Colors.yellow,
      ],
    ),
    this.inactiveGradiant = const LinearGradient(
      colors: [
        Colors.red,
        Colors.yellow,
      ],
    ),
    this.darkenInactive = true,
  });

  final LinearGradient activeGradient;
  final LinearGradient inactiveGradiant;
  final bool darkenInactive;

  @override
  void paint(
      PaintingContext context,
      Offset offset,
      {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required Offset thumbCenter,
        Offset? secondaryOffset,
        bool? isEnabled,
        bool? isDiscrete,
        required TextDirection textDirection
      }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(sliderTheme.trackHeight != null && sliderTheme.trackHeight! > 0);

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled!,
      isDiscrete: isDiscrete!,
    );

    final activeGradientRect = Rect.fromLTRB(
      trackRect.left,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (2 / 2)
          : trackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (2 / 2)
          : trackRect.bottom,
    );

    final inactiveGradientRect = Rect.fromLTRB(
      trackRect.left,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (2 / 2)
          : trackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (2 / 2)
          : trackRect.bottom,
    );

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = darkenInactive
        ? ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor
    )
        : activeTrackColorTween;
    final Paint activePaint = Paint()
      // ..shader = activeGradient.createShader(activeGradientRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
    ..shader = inactiveGradiant.createShader(inactiveGradientRect)
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (2 / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (2 / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (2 / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (2 / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}

