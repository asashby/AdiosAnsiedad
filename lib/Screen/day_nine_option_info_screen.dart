import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum/Controller/day_controller.dart';
import 'package:quantum/Widget/ninth_day_item_content_widget.dart';
import 'package:quantum/Widget/play_content_widget.dart';
import 'package:quantum/Widget/screen_layout_widget.dart';
import 'package:quantum/Widget/theme_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Model/day_info_model.dart';
import '../Utils/custom_text_style.dart';
import '../main.dart';
import '../Widget/primary_button_widget.dart';

class DayNineOptionInfoScreen extends StatefulWidget {
  final NinthDayContent? content;
  final String? optionTitle;

  const DayNineOptionInfoScreen({
    super.key,
    this.content,
    this.optionTitle,
  });

  @override
  State<DayNineOptionInfoScreen> createState() => _DayNineOptionInfoScreenState();
}

class _DayNineOptionInfoScreenState extends State<DayNineOptionInfoScreen> {

  final dayController = Get.put(DayController());

  File? loadFile;
  String? loadKey;

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
  }


  @override
  Widget build(BuildContext context) {
    // DayInfo dayInfo = dayController.getDayInfoByDayId(widget.day?.number??1);
    // List<Day> days = dayController.getPreviousDayByDayId(widget.day?.number??1);
    return ScreenLayoutWidget(
      title: widget.optionTitle,
      child: Flex(
        direction: Axis.vertical,
        children: [
          ListView.separated(
            separatorBuilder: (_,i){
              return const SizedBox(height: 5,);
            },
            itemBuilder: (context,index){
              return Column(
                children: [
                  const SizedBox(height: 15,),
                  InkWell(
                    onTap: (){

                    },
                    child: NinthDayItemContentWidget(
                      contentItem: widget.content!.items![index],
                      dayIndex: 8,
                      contentIndex: index,
                    ),
                  ),
                ],
              );
            },
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.content!.items!.length,
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
