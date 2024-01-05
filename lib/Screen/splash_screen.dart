import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum/Const/primary_theme.dart';
import 'package:quantum/Const/route_const.dart';
import 'package:quantum/Service/firestore_services.dart';
import 'package:quantum/Utils/size_utils.dart';
import 'package:quantum/Widget/empty_app_bar_widget.dart';

import '../Controller/day_controller.dart';
import '../Model/day_info_model.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final dayController = Get.put(DayController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


  loadData()async{
    // await FirestoreServices.setContentData();
    // await FirestoreServices.setDayData();
    // Future.delayed(const Duration(seconds: 2),(){
    //   Navigator.pushReplacementNamed(context, AppRoute.landingRoute);
    // });
    final connectivityResult = await (Connectivity().checkConnectivity());
    if([ConnectivityResult.none,ConnectivityResult.bluetooth,ConnectivityResult.vpn].contains(connectivityResult)){
      ScaffoldMessenger.of(appKey.currentState!.context).showSnackBar(const SnackBar(content: Text("Please turn on internet connection",),duration: Duration(seconds: 2),));
    }else{
      await dayController.setDayInfoList();
      // if(){
      //
      // }
      Future.delayed(const Duration(microseconds: 500),(){
        Navigator.pushReplacementNamed(context, AppRoute.landingRoute);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    // Get.find<DayController>().setDayInfoList();
    setState(() {});
    return Scaffold(
      appBar: const EmptyAppBarWidget(),
      body: SizedBox(
        height: context.screenHeight,
        width: context.screenWidth,
        child: Center(
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: PrimaryTheme.primaryColor,
              // boxShadow: PrimaryTheme.primaryBoxShadow
            ),
          ),
        ),
      ),
    );
  }
}
