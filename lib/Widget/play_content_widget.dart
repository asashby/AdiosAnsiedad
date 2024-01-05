import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quantum/Model/day_info_model.dart';
import 'package:quantum/Screen/audio_player_screen.dart';
import 'package:quantum/Screen/video_player_screen.dart';

import '../Const/const_string.dart';
import '../Utils/custom_text_style.dart';

class PlayContentWidget extends StatefulWidget {
  final int dayIndex;
  final int contentIndex;
  final Content? content;
  final bool isIdealProgram;
  final Function()? onTap;

  const PlayContentWidget({
    super.key,
    this.content,
    this.onTap,
    this.dayIndex = 0,
    this.contentIndex = 0,
    this.isIdealProgram = false
  });

  @override
  State<PlayContentWidget> createState() => _PlayContentWidgetState();
}

class _PlayContentWidgetState extends State<PlayContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: (widget.content?.timeDes??"").isNotEmpty ,
                child: Column(
                  children: [
                    Text("${widget.content?.timeDes}",style: CustomTextStyle.gold18_600.copyWith(fontWeight: FontWeight.w500),),
                    const SizedBox(height: 5,),
                  ],
                ),
              ),
              Text("${widget.content?.title}",style: CustomTextStyle.primary14_600,),
            ],
          ),
        ),
        const SizedBox(width: 10,),
        InkWell(
          onTap: (){
            if(widget.content == null)return;
            if(widget.content!.contentType == 1){
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => AudioPlayerScreen(
                  content: widget.content,
                  contentIndex: widget.contentIndex,
                  dayIndex: widget.dayIndex,
                  isIdealProgram: widget.isIdealProgram,
                )),
              );
            }else{
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => VideoPlayerScreen(
                  content: widget.content,
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
