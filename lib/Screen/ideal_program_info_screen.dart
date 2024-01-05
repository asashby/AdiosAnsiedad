import 'package:flutter/material.dart';
import 'package:quantum/Model/day_info_model.dart';
import 'package:quantum/Widget/play_content_widget.dart';

import '../Widget/screen_layout_widget.dart';

class IdealProgramInfoScreen extends StatefulWidget {
  final IdealProgram? idealProgram;
  final int idealIndex;

  const IdealProgramInfoScreen({
    super.key,
    this.idealProgram,
    this.idealIndex = 0
  });

  @override
  State<IdealProgramInfoScreen> createState() => _IdealProgramInfoScreenState();
}

class _IdealProgramInfoScreenState extends State<IdealProgramInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenLayoutWidget(
      title: "${widget.idealProgram?.title}",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ListView.separated(
          separatorBuilder: (context,index){
            return const SizedBox(height: 20,);
          },
          itemCount: (widget.idealProgram?.content??[]).length,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index){
            return PlayContentWidget(
              content: widget.idealProgram?.content?[index],
              dayIndex: widget.idealIndex,
              contentIndex: index,
              isIdealProgram: true,
            );
          }
        ),
      ),
    );
  }
}
