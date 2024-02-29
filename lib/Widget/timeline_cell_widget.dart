import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:quantum/Const/route_const.dart';
import 'package:quantum/Controller/day_controller.dart';
import 'package:quantum/Screen/day_info_screen.dart';
import 'package:quantum/Screen/ideal_program_screen.dart';
import 'package:quantum/Service/shared_pref_services.dart';
import 'package:quantum/Utils/custom_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Const/primary_theme.dart';
import '../Model/day_info_model.dart';
import 'node_widget.dart';

class TimeLineCellWidget extends StatefulWidget {
  final bool isFirst;
  final bool isLast;
  final Day? day;
  final int dayIndex;
  final ValueChanged<bool>? onRefresh;

  const TimeLineCellWidget({
    super.key,
    this.isFirst = false,
    this.isLast = false,
    this.dayIndex = 0,
    this.day,
    this.onRefresh
  });

  @override
  State<TimeLineCellWidget> createState() => _TimeLineCellWidgetState();
}

class _TimeLineCellWidgetState extends State<TimeLineCellWidget> {
  Size dotted1 = const Size(0, 0);
  Size dotted2 = const Size(0, 0);

  final dayController = Get.put(DayController());

  @override
  Widget build(BuildContext context) {
    String dayKeyWord = (AppLocalizations.of(context)?.day??"Day").toUpperCase();
    List<String> dayChar = [];
    for(int i = 0;i<dayKeyWord.length;i++){
      dayChar.add(dayKeyWord[i]);
    }
    return  Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: !widget.isFirst,
                          replacement: const SizedBox(),
                          child: WidgetSize(
                            onChange: (size){
                              setState(() {
                                dotted1 = size;
                              });
                            },
                            child: Dash(
                              isTop: true,
                              dashBorderRadius: 15,
                              direction: Axis.vertical,
                              length: dotted1.height,
                              dashThickness: 2,
                              dashGap: 3,
                              dashColor: isFirstDashComplete ? PrimaryTheme.primaryColor : PrimaryTheme.darkGreyColor,
                            ),
                          ),
                        ),
                      ),
                      NodeWidget(
                        percent: widget.day?.percent??0.0,
                      ),
                      Expanded(
                        child: Visibility(
                          visible: !widget.isLast,
                          replacement: const SizedBox(),
                          child: WidgetSize(
                            onChange: (size){
                              setState(() {
                                dotted1 = size;
                              });
                            },
                            child: Dash(
                              isTop: false,
                              direction: Axis.vertical,
                              length: dotted1.height,
                              dashBorderRadius: 15,
                              dashThickness: 2,
                              dashGap: 3,
                              dashColor: isSecondDashComplete ? PrimaryTheme.primaryColor : PrimaryTheme.darkGreyColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: (){
                    
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => DayInfoScreen(
                          day: widget.day,
                          dayIndex: widget.dayIndex,
                        )),
                      ).then((value)async{
                        if(widget.onRefresh != null){
                          widget.onRefresh!(true);
                        }
                      });
              
                  },
                  child: Container(
                    height: 115,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: PrimaryTheme.primaryBoxShadow
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 115,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)
                            ),
                            color: PrimaryTheme.primaryColor,
                          ),
                          child: dayChar.isNotEmpty ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 18,
                                  child: Text(dayChar[0],style: CustomTextStyle.white15_600.copyWith(color: const Color(
                                      0xffF2ED94)))),
                              SizedBox(
                                height: 18,
                                  child: Text(dayChar[1],style: CustomTextStyle.white15_600.copyWith(color: const Color(0xffF2ED94)))),
                              SizedBox(
                                height: 22,
                                  child: Text(dayChar[2],style: CustomTextStyle.white15_600.copyWith(color: const Color(0xffF2ED94)))),
                              const SizedBox(height: 5,),
                              Text("${widget.day?.number}",style: CustomTextStyle.white15_600.copyWith(color: const Color(0xffF2ED94))),
                            ],
                          ) : const SizedBox(),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(widget.day?.title??"",style: CustomTextStyle.primary13_500,),
                                const SizedBox(height: 5,),
                                Expanded(child: Text(
                                    widget.day?.description??"",
                                    style: CustomTextStyle.darkGrey10_400.copyWith(height: 1.7),
                                    maxLines: 3,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: !widget.isLast,
          replacement: const SizedBox(),
          child: Column(
            children: [
              SizedBox(height: 3,),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Dash(
                      direction: Axis.vertical,
                      length: 30,
                      dashGap: 3.5,
                      dashThickness: 2,
                      dashColor: isSecondDashComplete ? PrimaryTheme.primaryColor : PrimaryTheme.darkGreyColor,
                    ),
                  ),
                  const Expanded(flex: 8,child: SizedBox())
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  bool get isFirstDashComplete{
    bool status = false;
    if(widget.isFirst){
    }else if(dayController.daysList[widget.dayIndex].percent == 100 || dayController.daysList[widget.dayIndex-1].percent == 100){
      status = true;
    }
    return status;
  }

  bool get isSecondDashComplete{
    bool status = false;
    if(widget.isLast){
    }else if(dayController.daysList[widget.dayIndex].percent == 100 || dayController.daysList[widget.dayIndex+1].percent == 100){
      status = true;
    }
    return status;
  }
}

class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function(Size) onChange;

  const WidgetSize({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize??const Size(0,0));
  }
}

class Dash extends StatelessWidget {
  const Dash(
      {Key? key,
        this.direction = Axis.horizontal,
        this.dashColor = Colors.black,
        this.length = 10,
        this.dashGap = 3,
        this.dashLength = 6,
        this.dashThickness = 1,
        this.isTop = false,
        this.dashBorderRadius = 0})
      : super(key: key);

  final Axis direction;
  final Color dashColor;
  final double length;
  final double dashGap;
  final double dashLength;
  final double dashThickness;
  final double dashBorderRadius;
  final bool isTop;

  @override
  Widget build(BuildContext context) {
    var dashes = <Widget>[];
    double n = (length + dashGap) / (dashGap + dashLength);
    int newN = n.round();
    double newDashGap = (length - dashLength * newN) / (newN - 1);
    for (var i = newN; i > 0; i--) {
      dashes.add(step(i, newDashGap,isTop,newN));
    }
    if (direction == Axis.horizontal) {
      return SizedBox(
          width: length,
          child: Row(
            children: dashes,
          ));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: dashes);
    }
  }

  Widget step(int index, double newDashGap,bool isTop,int length) {
    bool isHorizontal = direction == Axis.horizontal;
    return Padding(
        padding: EdgeInsets.fromLTRB(
            0,
            0,
            isHorizontal && index != 1 ? newDashGap : 0,
            isHorizontal || index == 1 ? 0 : newDashGap),
        child: Container(
          width: isHorizontal ? dashLength : dashThickness,
          height: isHorizontal ? dashThickness : dashLength,
          decoration: BoxDecoration(
              color: dashColor,
              borderRadius: dashBorderRadius != 0 ? getBorderRadius(isTop,index,length) : null
            ),
          ),
    );
  }

  BorderRadiusGeometry? getBorderRadius(bool isTop,int index,int length){
    if(!isTop && index == length){
      return BorderRadius.only(topLeft: Radius.circular(dashBorderRadius),topRight: Radius.circular(dashBorderRadius));
    }else if(isTop && index == 1){
      return BorderRadius.only(bottomLeft: Radius.circular(dashBorderRadius),bottomRight: Radius.circular(dashBorderRadius));
    }else{
      return null;
    }
  }
}
