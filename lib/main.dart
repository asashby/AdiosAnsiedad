import 'package:cloudinary/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:quantum/Const/primary_theme.dart';
import 'package:quantum/Controller/day_controller.dart';
import 'package:quantum/Screen/audio_player_screen.dart';
import 'package:quantum/Screen/day_info_screen.dart';
import 'package:quantum/Screen/home_screen.dart';
import 'package:quantum/Screen/ideal_program_info_screen.dart';
import 'package:quantum/Screen/in_app_purchase_screen.dart';
import 'package:quantum/Screen/landing_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quantum/Screen/splash_screen.dart';
import 'package:quantum/Screen/video_player_screen.dart';
import 'Const/route_const.dart';
import 'Screen/ideal_program_screen.dart';
import 'firebase_options.dart';


final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

CacheManager cacheManager = CacheManager(Config("quantumProgram",
    stalePeriod: const Duration(days: 10000),
    fileService: HttpFileService(),
    repo: JsonCacheInfoRepository(databaseName: "quantumProgram")
));

GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  MyApp({super.key});

  final DayController dayController = Get.put(DayController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      title: 'Adios Ansiedad',
      locale: const Locale("es"),
      navigatorKey: appKey,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: AppRoute.initialRoute,
      navigatorObservers: [routeObserver],
      routes: {
        AppRoute.initialRoute : (context) => const SplashScreen(),
        AppRoute.landingRoute : (context) => const LandingScreen(),
        AppRoute.homeRoute : (context) => const HomeScreen(),
        AppRoute.dayInfo : (context) => const DayInfoScreen(),
        AppRoute.idealProgram : (context) => const IdealProgramScreen(),
        AppRoute.idealProgramInfo : (context) => const IdealProgramInfoScreen(),
        AppRoute.audioPlayer : (context) => const AudioPlayerScreen(),
        AppRoute.inAppPurchaseScreen : (context) => const InAppPurchaseScreen(),
        AppRoute.videoPlayer : (context) => const VideoPlayerScreen(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        scaffoldBackgroundColor: PrimaryTheme.bgColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

//Future<bool> getCacheFileStatus(
//       String url, {
//         String? key,
//         Map<String, String>? headers,
//       }) async {
//     key ??= url;
//     final cacheFile = await getFileFromCache(key);
//     if (cacheFile != null) {
//       return true;
//     }else{
//       return false;
//     }
//   }