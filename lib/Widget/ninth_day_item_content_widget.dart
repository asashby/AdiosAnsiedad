import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quantum/Model/day_info_model.dart';
import 'package:quantum/Screen/audio_player_screen.dart';
import 'package:quantum/Screen/video_player_screen.dart';
import 'dart:developer';

import '../Const/const_string.dart';
import '../Utils/custom_text_style.dart';

class NinthDayItemContentWidget extends StatefulWidget {
  final int dayIndex;
  final int contentIndex;
  final NinthDayContentItem? contentItem;
  final bool isIdealProgram;
  final Function()? onTap;

  const NinthDayItemContentWidget({
    super.key,
    this.contentItem,
    this.onTap,
    this.dayIndex = 0,
    this.contentIndex = 0,
    this.isIdealProgram = false
  });

  @override
  State<NinthDayItemContentWidget> createState() => _NinthDayItemContentWidgetState();
}

class _NinthDayItemContentWidgetState extends State<NinthDayItemContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${widget.contentItem!.description}",
                style: CustomTextStyle.gold18_600.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5,),
              Text(
                widget.contentItem!.content!.title,style: CustomTextStyle.primary14_600,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10,),
        InkWell(
          onTap: (){
            if(widget.contentItem!.content!.contentType == 1){
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => AudioPlayerScreen(
                  content: widget.contentItem!.content!,
                  contentIndex: widget.contentIndex,
                  dayIndex: widget.dayIndex,
                  isIdealProgram: widget.isIdealProgram,
                )),
              );
            }else{
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => VideoPlayerScreen(
                  content: widget.contentItem!.content!,
                  contentIndex: widget.contentIndex,
                  dayIndex: widget.dayIndex,
                  isIdealProgram: widget.isIdealProgram,
                )),
              ).then((value) {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                ]);
              });
            }
          },
          child: SvgPicture.asset(astIcPlaySvg,width: 50,height: 50,),
        )
      ],
    );
  }
}
