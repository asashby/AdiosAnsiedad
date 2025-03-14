import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum/Controller/day_controller.dart';
import 'package:quantum/Screen/day_nine_info_screen.dart';
import 'package:quantum/Widget/play_content_widget.dart';
import 'package:quantum/Widget/screen_layout_widget.dart';
import 'package:quantum/Widget/theme_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Model/day_info_model.dart';
import '../Utils/custom_text_style.dart';
import '../main.dart';
import '../Widget/primary_button_widget.dart';

class DayInfoScreen extends StatefulWidget {
  final Day? day;
  final int dayIndex;

  const DayInfoScreen({
    super.key,
    this.day,
    this.dayIndex = 0
  });

  @override
  State<DayInfoScreen> createState() => _DayInfoScreenState();
}

class _DayInfoScreenState extends State<DayInfoScreen> {

  final dayController = Get.put(DayController());

  File? loadFile;
  String? loadKey;

  Future loadNextContent()async{
    if(widget.dayIndex+1 < dayController.daysInfoList.length-1){
      int index = widget.dayIndex+1;
      for (var element in dayController.daysInfoList[index].contents ?? []) {
        if (element.path!.contains("https")) {
          /*bool status = await cacheManager.getCacheFileStatus(element.path ?? "", key: element.id ?? "");
          if (!status) {
            loadFile = null;
            loadKey = element.id ?? "";
            loadFile = await cacheManager.getSingleFile(element.path??"",key: element.id??"");
            loadKey = null;
          }*/
        }
      }
    }
  }

  Future removeLoadContent()async{
    if(loadFile == null && (loadKey??"").isNotEmpty){
      await cacheManager.removeFile(loadKey!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    removeLoadContent();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNextContent();
  }


  @override
  Widget build(BuildContext context) {
    // DayInfo dayInfo = dayController.getDayInfoByDayId(widget.day?.number??1);
    // List<Day> days = dayController.getPreviousDayByDayId(widget.day?.number??1);
    return ScreenLayoutWidget(
      title: "${AppLocalizations.of(context)?.sayGoodByeAnxiety}",
      child: Flex(
        direction: Axis.vertical,
        children: [
          ThemeBox(
            isMain: true,
            firstLine: "${AppLocalizations.of(context)?.day} ${widget.day?.number}",
            secondLine: "${widget.day?.title}",
            child: Column(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Text("${widget.day?.description}",style: CustomTextStyle.darkGrey14_400.copyWith(height: 1.7),textAlign: TextAlign.justify,),
                        const SizedBox(height: 20,),
                        ListView.separated(
                          separatorBuilder: (_,i){
                            return const SizedBox(height: 5,);
                          },
                          itemBuilder: (context,index){
                            return InkWell(
                              onTap: (){

                              },
                              child: PlayContentWidget(
                                content: dayController.getDayInfoByDayId(widget.day?.number??1).contents![index],
                                dayIndex: widget.dayIndex,
                                contentIndex: index,
                              ),
                            );
                          },
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (dayController.getDayInfoByDayId(widget.day?.number??1).contents??[]).length,
                        ),
                        const SizedBox(height: 20,)
                      ]
                    )
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child:  Visibility(
                        visible: widget.dayIndex < 8,
                        child: PrimaryButtonWidget(
                          title: AppLocalizations.of(context)!.continues,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          onTap: ()async{
                            if(widget.dayIndex == 7){
                              Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(builder: (context) => DayNineInfoScreen(
                                  day: dayController.daysList[widget.dayIndex + 1],
                                  dayIndex: widget.dayIndex + 1,
                                )),
                              );
                            }else{
                              Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(builder: (context) => DayInfoScreen(
                                  day: dayController.daysList[widget.dayIndex + 1],
                                  dayIndex: widget.dayIndex + 1,
                                )),
                              );
                            }
                          },
                        )
                      )
                    )
                  )
                ],
              ),
          ),
        ],
      ),
    );
  }
}
