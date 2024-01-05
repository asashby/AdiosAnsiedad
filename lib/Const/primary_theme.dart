import 'package:flutter/material.dart';

class PrimaryTheme{

  static const Color primaryColor = Color(0xffB498E8);
  static const Color darkGreyColor = Color(0xff474747);
  static const Color bgColor = Color(0xffffffff);
  static const Color blueColor = Color(0xff2F5496);
  static const Color darkRedColor = Color(0xffC00000);
  static const Color accentRedColor = Color(0xffFF0000);
  static const Color goldColor = Color(0xffCD9208);
  static Color shadowColor = Colors.grey.shade300;

  static BorderRadius borderRadius15 = BorderRadius.circular(15);
  static BorderRadius borderRadius10 = BorderRadius.circular(10);

  static EdgeInsetsGeometry padding21 = const EdgeInsets.all(21);
  static EdgeInsetsGeometry padding15 = const EdgeInsets.all(15);
  static EdgeInsetsGeometry padding10 = const EdgeInsets.all(10);
  static EdgeInsetsGeometry paddingHorizontal8 = const EdgeInsets.symmetric(horizontal: 8);
  static EdgeInsetsGeometry paddingVertical15 = const EdgeInsets.symmetric(vertical: 15);

  static Widget verticalSpace10 = const SizedBox(height: 10,);

  static List<BoxShadow> primaryBoxShadow = [
    BoxShadow(
      color: Colors.grey.shade300,
      offset: const Offset(1,-1),
      blurRadius: 10,
    ),
    BoxShadow(
      color: Colors.grey.shade300,
      offset: const Offset(-1,1),
      blurRadius: 10,
    )
  ];

  static String poppinsFont = "Poppins";

  static double font20 = 20;
  static double font18 = 18;
  static double font17 = 17;
  static double font16 = 16;
  static double font15 = 15;
  static double font14 = 14;
  static double font13 = 13;
  static double font10 = 10;

}





