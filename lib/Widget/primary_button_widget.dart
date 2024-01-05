import 'package:flutter/material.dart';
import 'package:quantum/Const/primary_theme.dart';
import 'package:quantum/Utils/custom_text_style.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String? title;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;

  const PrimaryButtonWidget({
    super.key,
    this.title,
    this.margin,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        margin: margin,
        decoration: BoxDecoration(
          boxShadow: PrimaryTheme.primaryBoxShadow,
          borderRadius: PrimaryTheme.borderRadius10,
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              PrimaryTheme.primaryColor,
              Color(0xFFE6D8FF),
            ]
          )
        ),
        alignment: Alignment.center,
        child: Text(title??"",style: CustomTextStyle.white18_700),
      ),
    );
  }
}
