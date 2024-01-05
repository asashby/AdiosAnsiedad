import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quantum/Const/const_string.dart';
import 'package:quantum/Model/day_info_model.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quantum/Model/preference_data_model.dart';
import 'package:quantum/Service/shared_pref_services.dart';
import 'package:quantum/main.dart';

import '../Service/firestore_services.dart';

class DayController extends GetxController{

  final daysList = <Day>[].obs;
  final daysInfoList = <DayInfo>[].obs;
  final idealProgramList = <IdealProgram>[].obs;

  Map<String,Content> contentData  = {};
  // Map<String,Content> contentData  = {
  //   "A1" : Content(
  //     id: "A1",
  //     title: "ENTENDIENDO LA ANSIEDAD Y EL MIEDO",
  //     contentType: 1,
  //     path: astContentA1,
  //     number: 1,
  //     duration: 667
  //   ),
  //   "A2" : Content(
  //       id: "A2",
  //       title: "CAUSAS DE LA ANSIEDAD",
  //       contentType: 1,
  //       path: astContentA2,
  //       number: 2,
  //     duration: 755
  //   ),
  //   "V1" : Content(
  //       id: "V1",
  //       title: "COMIDAS QUE CAUSAN ANSIEDA",
  //       contentType: 2,
  //       path: astContentV1,
  //       number: 1,
  //       duration: 652
  //   ),
  //   "A3" : Content(
  //       id: "A3",
  //       title: "REPRO PARA DORMIR",
  //       contentType: 1,
  //       path: astContentA3,
  //       number: 3,
  //     duration: 3947
  //   ),
  //   "A4" : Content(
  //       id: "A4",
  //       title: "GESTIONANDO TUS PENSAMIENTOS",
  //       contentType: 1,
  //       path: astContentA4,
  //       number: 4,
  //     duration: 905
  //   ),
  //   "V2" : Content(
  //       id: "V2",
  //       title: "CONTROL DE PENSAMIENTOS",
  //       contentType: 2,
  //       path: astContentV2,
  //       number: 2,
  //       duration: 1263
  //   ),
  //   "A5" : Content(
  //       id: "A5",
  //       title: "GESTIONANDO TUS EMOCIONES",
  //       contentType: 1,
  //       path: astContentA5,
  //       number: 5,
  //      duration: 660
  //   ),
  //   "V3" : Content(
  //       id: "V3",
  //       title: "DRENAJE DE EMOCIONES Y ESTRES",
  //       contentType: 2,
  //       path: astContentV3,
  //       number: 3,
  //     duration: 503
  //   ),
  //   "V4" : Content(
  //       id: "V4",
  //       title: "EJERCICIO DE RESPIRACION",
  //       contentType: 2,
  //       path: astContentV4,
  //       number: 4,
  //     duration: 916
  //   ),
  //   "A6" : Content(
  //       id: "A6",
  //       title: "CAMBIO DE ACTITUD GUIADO",
  //       contentType: 1,
  //       path: astContentA6,
  //       number: 6,
  //       duration: 347
  //   ),
  //   "A7" : Content(
  //       id: "A7",
  //       title: "RENOVACION",
  //       contentType: 1,
  //       path: astContentA7,
  //       number: 7,
  //       duration: 1599
  //   ),
  // };

  Map<String,Completer> contentCompleter = {};

  Future setDayInfoList()async{
    BuildContext context = appKey.currentState!.context;
    contentData = await FirestoreServices.getContentData();
    daysList.value = await FirestoreServices.getDayData();
    // daysInfoList.value = await FirestoreServices.getDayInfoData();
    // daysList.value = [
    //   Day(
    //     percent: 0,
    //     title: AppLocalizations.of(context)!.day1Title,
    //     description: AppLocalizations.of(context)!.description,
    //     number: 1
    //   ),
    //   Day(
    //       percent: -1,
    //       title: AppLocalizations.of(context)!.day2Title,
    //       description: AppLocalizations.of(context)!.day2Des,
    //       number: 2
    //   ),
    //   Day(
    //       percent: -1,
    //       title: AppLocalizations.of(context)!.day3Title,
    //       description: AppLocalizations.of(context)!.day3Des,
    //       number: 3
    //   ),
    //   Day(
    //       percent: -1,
    //       title: AppLocalizations.of(context)!.day4Title,
    //       description: AppLocalizations.of(context)!.day4Des,
    //       number: 4
    //   ),
    //   Day(
    //       percent: -1,
    //       title: AppLocalizations.of(context)!.day5Title,
    //       description: AppLocalizations.of(context)!.day5Des,
    //       number: 5
    //   ),
    //   Day(
    //       percent: -1,
    //       title: AppLocalizations.of(context)!.day6Title,
    //       description: AppLocalizations.of(context)!.day6Des,
    //       number: 6
    //   ),
    //   Day(
    //       percent: -1,
    //       title: AppLocalizations.of(context)!.day7Title,
    //       description: AppLocalizations.of(context)!.day7Des,
    //       number: 7
    //   ),
    //   Day(
    //       percent: -1,
    //       title: AppLocalizations.of(context)!.day8Title,
    //       description: AppLocalizations.of(context)!.day8Des,
    //       number: 8
    //   ),
    //   Day(
    //       percent: -1,
    //       title: AppLocalizations.of(context)!.day9Title,
    //       description: AppLocalizations.of(context)!.day9Des,
    //       number: 9,
    //       isIdealProgram: true
    //   ),
    // ];

    List<int> dayPercentage = await SharedPrefFun.getDayPercentageData();
    for(int i = 0;i<dayPercentage.length;i++){
      daysList[i].percent = dayPercentage[i].toDouble();
    }

    daysInfoList.value = [
      DayInfo(
        day: daysList[0],
        id: daysList[0].number,
        contents: [
          contentData["A1"]!.copyWith(),
          contentData["A2"]!.copyWith(),
        ]
      ),
      DayInfo(
        day: daysList[1],
        id: daysList[1].number,
        contents: [
          contentData["V1"]!.copyWith(),
          contentData["A3"]!.copyWith(),
        ],
      ),
      DayInfo(
        day: daysList[2],
        id: daysList[2].number,
        contents: [
          contentData["A4"]!.copyWith(),
          contentData["A3"]!.copyWith(),
        ],
      ),
      DayInfo(
        day: daysList[3],
        id: daysList[3].number,
        contents: [
          contentData["V2"]!.copyWith(),
          contentData["A3"]!.copyWith(),
        ],
      ),
      DayInfo(
        day: daysList[4],
        id: daysList[4].number,
        contents: [
          contentData["A5"]!.copyWith(),
          contentData["A3"]!.copyWith(),
        ],
      ),
      DayInfo(
        day: daysList[5],
        id: daysList[5].number,
        contents: [
          contentData["V3"]!.copyWith(),
          contentData["A3"]!.copyWith(),
        ],
      ),
      DayInfo(
        day: daysList[6],
        id: daysList[6].number,
        contents: [
          contentData["V4"]!.copyWith(),
          contentData["A3"]!.copyWith(),
        ],
      ),
      DayInfo(
        day: daysList[7],
        id: daysList[7].number,
        contents: [
          contentData["A6"]!.copyWith(),
          contentData["A3"]!.copyWith(),
        ],
      ),
      DayInfo(
        day: daysList[8],
        id: daysList[8].number,
        contents: [],
      ),
    ];

    List<PreferenceData> prefDayInfoList = await SharedPrefFun.getPreferenceData(isDayInfo: true);
    for (int i = 0;i< prefDayInfoList.length;i++) {
      daysInfoList[i] = getDayInfoByPreferenceData(daysInfoList[i], prefDayInfoList[i]);
    }
    // idealProgramList.value = await FirestoreServices.getIdealProgramData();

    idealProgramList.value = [
      IdealProgram(
        id: 1,
        title: "${AppLocalizations.of(context)?.lowAnxietyLevel}",
        content: [
          contentData["A6"]!.copyWith(
            timeDes: "${AppLocalizations.of(context)?.inTheMorning}"
          ),
          contentData["V4"]!.copyWith(
              timeDes: "${AppLocalizations.of(context)?.inTheAfternoon}"
          ),
          contentData["A3"]!.copyWith(
              timeDes: "${AppLocalizations.of(context)?.atBedtime}"
          ),
        ]
      ),
      IdealProgram(
        id: 2,
        title: "${AppLocalizations.of(context)?.mediumAnxietyLevel}",
        content: [
          contentData["A6"]!.copyWith(
              timeDes: "${AppLocalizations.of(context)?.inTheMorning}"
          ),
          contentData["A4"]!.copyWith(
            timeDes: "${AppLocalizations.of(context)?.medMorning}"
          ),
          contentData["V4"]!.copyWith(
              timeDes: "${AppLocalizations.of(context)?.inTheAfternoon}"
          ),
          contentData["A3"]!.copyWith(
              timeDes: "${AppLocalizations.of(context)?.atBedtime}"
          ),
        ]
      ),
      IdealProgram(
        id: 3,
        title: "${AppLocalizations.of(context)?.highAnxietyLevel}",
        content: [
          contentData["A6"]!.copyWith(
              timeDes: "${AppLocalizations.of(context)?.morEightOrNine}"
          ),
          contentData["A4"]!.copyWith(
              timeDes: "${AppLocalizations.of(context)?.midMorTenOrEleven}"
          ),
          contentData["A7"]!.copyWith(
              timeDes: "${AppLocalizations.of(context)?.noon}"
          ),
          contentData["V4"]!.copyWith(
              timeDes: "${AppLocalizations.of(context)?.afterFourOrFive}"
          ),
          contentData["V2"]!.copyWith(
              timeDes: "${AppLocalizations.of(context)?.nightSixOrSeven}"
          ),
          contentData["A3"]!.copyWith(
              timeDes: "${AppLocalizations.of(context)?.atBedtime}"
          ),
        ]
      )
    ];

    List<PreferenceData> prefIdealProgramList = await SharedPrefFun.getPreferenceData(isDayInfo: false);
    for (int i = 0;i<prefIdealProgramList.length;i++) {
      idealProgramList[i] = getIdealProgramByPreferenceData(idealProgramList[i], prefIdealProgramList[i]);
    }
  }

  DayInfo getDayInfoByPreferenceData(DayInfo dayInfo,PreferenceData preferenceData){
    List<Content> contents = [];
    preferenceData.content?.forEach((cnt) {
      contents.add(getContentByPreferenceContent(cnt));
    });
    return DayInfo(
      id: dayInfo.id,
      contents: contents,
      day: dayInfo.day
    );
  }

  IdealProgram getIdealProgramByPreferenceData(IdealProgram idealProgram,PreferenceData preferenceData){
    List<Content> contents = [];
    for(int i = 0;i<(preferenceData.content??[]).length;i++){
      contents.add(idealProgram.content![i].copyWith(
        watchDuration: preferenceData.content![i].watchDuration,
        duration: preferenceData.content![i].duration,
        number: preferenceData.content![i].number,
      ));
    }
    return IdealProgram(
        id: idealProgram.id,
        content: contents,
      title: idealProgram.title
    );
  }

  Content getContentByPreferenceContent(Content cnt){
    Content content = getContentById(cnt.id);
    return Content(
        id: content.id,
        duration: cnt.duration,
        timeDes: content.timeDes,
        title: content.title,
        number: cnt.number,
        path: content.path,
        contentType: content.contentType,
        watchDuration: cnt.watchDuration
    );
  }

  setWatchDurationOfDay(int duration,int dayIndex,int contentIndex)async{
    daysInfoList[dayIndex].contents?[contentIndex].watchDuration = duration;
    calculateDayWatchPercentage(dayIndex);
    await setDayInfoPrefData();
    await setDayPercentagePrefData();
    // daysList.refresh();
  }

  void calculateDayWatchPercentage(int dayIndex){
    if(daysList[dayIndex].percent != 100){

      double percentage = 0.0;
      (daysInfoList[dayIndex].contents??[]).forEach((element) {
        percentage = percentage + double.parse(((element.watchDuration*50)/element.duration).toDouble().toStringAsFixed(0));
      });
      if(percentage >= 99.5){
        daysList[dayIndex].percent = 100.0;
        if(dayIndex < daysList.length-1){
          daysList[dayIndex+1].percent = 0.0;
        }
      }else{
        daysList[dayIndex].percent = percentage;
      }
    }
  }

  setWatchDurationOfIdealProgram(int duration,int idealIndex,int contentIndex)async{
    idealProgramList[idealIndex].content?[contentIndex].watchDuration = duration;
    calculateIdealProgramWatchPercentage();
    await setIdealProgramPreData();
    await setDayPercentagePrefData();
    // daysList.refresh();
  }

  void calculateIdealProgramWatchPercentage(){
    if(daysList.last.percent != 100){
      double percentage = 0.0;
      for (var element in idealProgramList) {
        int totalTime = 0;
        int watchTime = 0;
        for (var x in element.content!) {
          totalTime = totalTime + x.duration;
          watchTime = watchTime + x.watchDuration;
        }
        percentage = percentage + double.parse(((watchTime*33)/totalTime).toDouble().toStringAsFixed(0));
      }
      if(percentage >= 99){
        daysList.last.percent = 100.0;
      }else{
        daysList.last.percent = percentage;
      }
    }
  }

  DayInfo getDayInfoByDayId(int id){
    return daysInfoList.firstWhere((element) => element.id == id);
  }

  Content getContentById(String? id){
    return contentData[id??""]??Content();
  }

  Day getDayByDayId(int id){
    return daysList.firstWhere((element) => element.number == id);
  }

  List<Day> getPreviousDayByDayId(int id){
    if(id == 1)return [];
    return daysList.sublist(0,id-1);
  }

  Future setPreferenceData()async{
    await setIdealProgramPreData();
    await setDayInfoPrefData();
    await setDayPercentagePrefData();
  }

  Future setDayInfoPrefData()async{
    if(daysInfoList.isNotEmpty){
      List<PreferenceData> data = daysInfoList.map((e) => PreferenceData(
          content: e.contents,
          id: e.id
      )).toList();
      await SharedPrefFun.setPreferenceData(data,isDayInfo: true);
    }
  }

  Future setIdealProgramPreData()async{
    if(idealProgramList.isNotEmpty){
      List<PreferenceData> data = idealProgramList.map((e) => PreferenceData(
          content: e.content,
          id: e.id
      )).toList();
      await SharedPrefFun.setPreferenceData(data,isDayInfo: false);
    }
  }

  Future setDayPercentagePrefData()async{
    if(daysList.isNotEmpty){
      List<int> dayPercentage = [];
      for (var element in daysList) {
        dayPercentage.add((element.percent??-1).toInt());
      }
      await SharedPrefFun.setDayPercentageData(dayPercentage);
    }
  }
}