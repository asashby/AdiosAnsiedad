import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quantum/Utils/custom_text_style.dart';
import 'package:quantum/Utils/size_utils.dart';
import 'package:quantum/Widget/empty_app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Const/primary_theme.dart';

class ScreenLayoutWidget extends StatelessWidget {
  final Widget? child;
  final String? title;
  final EdgeInsetsGeometry? padding;

  const ScreenLayoutWidget({
    super.key,
    this.child,
    this.title,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryTheme.bgColor,
      appBar: title != null ? AppBar(
        centerTitle: true,
        surfaceTintColor: PrimaryTheme.bgColor,
        backgroundColor: PrimaryTheme.bgColor,
        foregroundColor: PrimaryTheme.primaryColor,
        title: Text(title??""),
        toolbarHeight: 50,
        shadowColor: PrimaryTheme.bgColor,
        elevation: 0,
        titleTextStyle: CustomTextStyle.primary17_700,
        actions: <Widget>[
          TextButton( 
            child: const Text(
              "CONSULTAS",
              style: TextStyle(color: PrimaryTheme.primaryColor),
            ),
            onPressed: () {
              launchUrl(emailLaunchUri);
            },
          )
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: PrimaryTheme.bgColor,
            statusBarColor: PrimaryTheme.bgColor,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark
        ),
      ) : const EmptyAppBarWidget(),
      body: SizedBox(
        height: context.screenHeight,
        width: context.screenWidth,
        child: Padding(
          padding: padding??PrimaryTheme.padding15,
          child: Padding(
            padding: EdgeInsets.only(bottom: context.bottomPadding,top: 0 ),
            child: child??const SizedBox(),
          ),
        ),
      ),
    );
  }
}


String? encodeQueryParameters(Map<String, String> params) {
return params.entries
  .map((MapEntry<String, String> e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
  .join('&');
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'siabinter@gmail.com',
  query: encodeQueryParameters(<String, String>{
    'subject': 'Consulta sobre Adios Ansiedad app',
  }),
);