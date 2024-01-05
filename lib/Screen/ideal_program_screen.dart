import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:quantum/Const/primary_theme.dart';
import 'package:quantum/Controller/day_controller.dart';
import 'package:quantum/Model/day_info_model.dart';
import 'package:quantum/Screen/ideal_program_info_screen.dart';
import 'package:quantum/Utils/custom_text_style.dart';

import '../Widget/screen_layout_widget.dart';
import '../main.dart';

class IdealProgramScreen extends StatefulWidget {
  const IdealProgramScreen({super.key});

  @override
  State<IdealProgramScreen> createState() => _IdealProgramScreenState();
}

class _IdealProgramScreenState extends State<IdealProgramScreen> {

  final dayController = Get.put(DayController());

  File? loadFile;
  String? loadKey;

  Future loadRemainingAudio()async{
    Content? content = dayController.contentData["A7"];
    if(content != null){
      /*bool status = await cacheManager.getCacheFileStatus(content.path ?? "", key: content.id ?? "");
      if (!status) {
        loadFile = null;
        loadKey = content.id ?? "";
        loadFile = await cacheManager.getSingleFile(content.path??"",key: content.id??"");
        loadKey = null;
      }*/
    }
  }

  Future removeLoadContent()async{
    if(loadFile == null && (loadKey??"").isNotEmpty){
      await cacheManager.removeFile(loadKey!);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRemainingAudio();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    removeLoadContent();
  }

  @override
  Widget build(BuildContext context) {
    List<IdealProgram> idealProgram = dayController.idealProgramList;
    return ScreenLayoutWidget(
      title: "${AppLocalizations.of(context)?.continueYourTransformation}",
      child: ListView.separated(
        separatorBuilder: (context,index){
          return const SizedBox(height: 20,);
        },
        itemCount: idealProgram.length,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context,index){
          return InkWell(
            borderRadius: PrimaryTheme.borderRadius15,
            onTap: (){
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => IdealProgramInfoScreen(
                  idealProgram: idealProgram[index],
                  idealIndex: index,
                )),
              );
            },
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: PrimaryTheme.borderRadius15,
                boxShadow: PrimaryTheme.primaryBoxShadow,
                color: Colors.white
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(child: Text("${idealProgram[index].title}",style: CustomTextStyle.primary15_500,)),
                    const SizedBox(width: 10,),
                    const Icon(CupertinoIcons.forward)
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
