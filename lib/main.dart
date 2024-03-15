import 'dart:io';

import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/routing/app_route.dart';
import 'package:digitalis_restaurant_app/core/services/storage_service.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/splash_screen/splash_screen.dart';
import 'package:digitalis_restaurant_app/provider/app_provider.dart';
import 'package:digitalis_restaurant_app/provider/auth_provider.dart';
import 'package:digitalis_restaurant_app/provider/booking_provider.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:digitalis_restaurant_app/provider/comment_provider.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:digitalis_restaurant_app/provider/database/user_model_provider.dart';
import 'package:digitalis_restaurant_app/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  final splashScreenPrefs = await SharedPreferences.getInstance();
  final showSplashScreen =
      splashScreenPrefs.getBool('showSplashScreen') ?? true;

  final onBoardingPrefs = await SharedPreferences.getInstance();
  final showOnboarding = onBoardingPrefs.getBool('showOnboarding') ?? true;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    ));

    

  runApp(MyApp(
      showSplashScreen: showSplashScreen, showOnboarding: showOnboarding));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.showSplashScreen,
      required this.showOnboarding});

  final bool showSplashScreen;
  final bool showOnboarding;

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => AppProvider()),
          ChangeNotifierProvider(create: (_) => CommentProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
          ChangeNotifierProvider(create: (_) => BookingProvider()),
          ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
          ChangeNotifierProvider(create: (_) => DatabaseProvider()),
          ChangeNotifierProvider(create: (_) => UserModel())
        ],
        child: GetMaterialApp(
          title: 'WADOUNOU',
          defaultTransition: Transition.rightToLeft,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          routes: routes,
        ));
  }
}
