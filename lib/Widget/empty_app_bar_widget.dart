import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quantum/Const/primary_theme.dart';

class EmptyAppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  const EmptyAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
      shadowColor: PrimaryTheme.bgColor,
      elevation: 0,
      surfaceTintColor: PrimaryTheme.bgColor,
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: PrimaryTheme.bgColor,
        statusBarColor: PrimaryTheme.bgColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.zero;
}
