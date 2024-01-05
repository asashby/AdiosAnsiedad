import 'package:flutter/material.dart';
import 'package:quantum/Utils/custom_text_style.dart';
import 'package:quantum/Utils/size_utils.dart';

import '../Const/primary_theme.dart';

class ThemeBox extends StatelessWidget {
  final String? firstLine;
  final String? secondLine;
  final Widget? child;
  final bool isMain;

  const ThemeBox({
    super.key,
    this.firstLine,
    this.secondLine,
    this.isMain = true,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    if(isMain){
      return Expanded(
        child: _buildPurpleBgBox(context),
      );
    }else{
      return _buildPurpleBgBox(context);
    }
  }

  Widget _buildPurpleBgBox(BuildContext context){
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
          boxShadow: isMain ? PrimaryTheme.primaryBoxShadow : null,
          color: PrimaryTheme.primaryColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          PrimaryTheme.verticalSpace10,
          Padding(
            padding: PrimaryTheme.paddingHorizontal8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(firstLine??"",
                  style: CustomTextStyle.white18_700,
                  textAlign: TextAlign.center,
                ),
                Visibility(
                  visible: secondLine != null,
                  replacement: const SizedBox(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5,),
                      Text(secondLine??"",
                        style: CustomTextStyle.white15_600,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          if(isMain)
            Expanded(
              child: _buildChildView(context),
            )
          else
            _buildChildView(context),
        ],
      ),
    );
  }
  
  Widget _buildChildView(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(3),
      padding: PrimaryTheme.padding15,
      width: context.screenWidth,
      decoration: const BoxDecoration(
          color: PrimaryTheme.bgColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )
      ),
      child: child,
    );
  }
}
