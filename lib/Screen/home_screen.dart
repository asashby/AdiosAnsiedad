
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum/Controller/day_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Model/day_info_model.dart';
import '../Widget/screen_layout_widget.dart';
import '../Widget/timeline_cell_widget.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  final dayController = Get.put(DayController());


  @override
  Widget build(BuildContext context) {
    return ScreenLayoutWidget(
      title: AppLocalizations.of(context)?.progress,
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: dayController.daysList.length,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return TimeLineCellWidget(
                    isFirst: index == 0,
                    isLast: index == dayController.daysList.length-1,
                    day: dayController.daysList[index],
                    dayIndex: index,
                    onRefresh: (value){
                      if(value){
                        setState(() {});
                      }
                    },
                  );
                }
            ),),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}



