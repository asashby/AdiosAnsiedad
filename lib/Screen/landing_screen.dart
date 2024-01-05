
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum/Const/route_const.dart';
import 'package:quantum/Controller/day_controller.dart';
import 'package:quantum/Utils/custom_text_style.dart';
import 'package:quantum/Widget/screen_layout_widget.dart';
import 'package:quantum/Widget/theme_box.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Model/day_info_model.dart';
import '../Widget/play_content_widget.dart';
import '../Widget/primary_button_widget.dart';
import '../main.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  final dayController = DayController();


  checkInternetConnection()async{
    List<MapEntry<String,Content>> contentMapEntry = [];
    dayController.contentData.forEach((key, value) {
      contentMapEntry.add(MapEntry(key, value));
    });
    bool isLoad = false;
    for (var element in contentMapEntry) {
      if(element.value.path!.contains("https")){
        /*bool status = await cacheManager.getCacheFileStatus(element.value.path??"",key: element.value.id??"");
        if(!status){
         isLoad = true;
         break;
        }*/
      }
    }
    if(isLoad){
      final connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult == ConnectivityResult.none){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please turn on internet connection",),duration: Duration(seconds: 2),));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayoutWidget(
      child: Column(
        children: [
          ThemeBox(
            firstLine: AppLocalizations.of(context)!.welcomeToQuantumPro,
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.sayGoodByeAnxiety,style: CustomTextStyle.darkGrey18_700),
                  const SizedBox(height: 8,),
                  Text(AppLocalizations.of(context)!.description,
                      style: CustomTextStyle.darkGrey15_400.copyWith(height: 1.7),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 12,),
                  Text(AppLocalizations.of(context)!.fundamentalAspectsTitle,style: CustomTextStyle.darkGrey18_700),
                  const SizedBox(height: 8,),
                  Text("- ${AppLocalizations.of(context)!.fundamentalAspectsTitle1}",style: CustomTextStyle.darkGrey15_400.copyWith(height: 1.7),textAlign: TextAlign.justify),
                  const SizedBox(height: 8,),
                  Text("- ${AppLocalizations.of(context)!.fundamentalAspectsTitle2}",style: CustomTextStyle.darkGrey15_400.copyWith(height: 1.7),textAlign: TextAlign.justify),
                  const SizedBox(height: 8,),
                  Text("- ${AppLocalizations.of(context)!.fundamentalAspectsTitle3}",style: CustomTextStyle.darkGrey15_400.copyWith(height: 1.7),textAlign: TextAlign.justify),
                  const SizedBox(height: 12,),
                  Text(AppLocalizations.of(context)!.whatAreYouLearn,style: CustomTextStyle.darkGrey18_700),
                  const SizedBox(height: 8,),
                  Text(AppLocalizations.of(context)!.whatAreYouLearnAns,style: CustomTextStyle.darkGrey15_400.copyWith(height: 1.7),textAlign: TextAlign.justify),
                  const SizedBox(height: 12,),
                  Get.find<DayController>().daysInfoList.isNotEmpty ? ListView.separated(
                    separatorBuilder: (_,i){
                      return const SizedBox(height: 10,);
                    },
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context,index){
                      return ThemeBox(
                        isMain: false,
                        firstLine: "${AppLocalizations.of(context)!.day} ${index+1}",
                        secondLine: "${Get.find<DayController>().daysInfoList[index].day?.title}",
                        child: Column(
                          children: [
                            Text("${Get.find<DayController>().daysInfoList[index].day?.description}",style: CustomTextStyle.darkGrey14_400.copyWith(height: 1.7),textAlign: TextAlign.justify),
                            const SizedBox(height: 20,),
                            ListView.separated(
                              separatorBuilder: (_,i){
                                return const SizedBox(height: 5,);
                              },
                              itemBuilder: (context,index){
                                return PlayContentWidget(
                                  content: Get.find<DayController>().daysInfoList[0].contents?[index],
                                  dayIndex: 0,
                                  contentIndex: index,
                                );
                              },
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (Get.find<DayController>().daysInfoList[index].contents??[]).length,
                            ),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      );
                    }
                  ) : const SizedBox(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12,),
          PrimaryButtonWidget(
            title: AppLocalizations.of(context)!.continues,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            onTap: ()async{
              Navigator.pushReplacementNamed(context, AppRoute.homeRoute);
            },
          )
        ],
      ),
    );
  }
}
