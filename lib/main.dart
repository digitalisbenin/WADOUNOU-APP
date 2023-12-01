import 'dart:io';

import 'package:digitalis_restaurant_app/core/routing/app_route.dart';
import 'package:digitalis_restaurant_app/core/services/storage_service.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/splash_screen/splash_screen.dart';
import 'package:digitalis_restaurant_app/provider/auth_provider.dart';
import 'package:digitalis_restaurant_app/provider/booking_provider.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:digitalis_restaurant_app/provider/database/user_model_provider.dart';
import 'package:digitalis_restaurant_app/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, SystemUiOverlay.top
  ]);
  final splashScreenPrefs = await SharedPreferences.getInstance();
  final showSplashScreen = splashScreenPrefs.getBool('showSplashScreen') ?? true;

  final onBoardingPrefs = await SharedPreferences.getInstance();
  final showOnboarding = onBoardingPrefs.getBool('showOnboarding') ?? true;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp(
      showSplashScreen: showSplashScreen, showOnboarding: showOnboarding));
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
      required this.showSplashScreen,
      required this.showOnboarding});

  final bool showSplashScreen;
  final bool showOnboarding;


  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => UserModel())
      ],  
      child: MaterialApp(
          title: 'WADOUNOU',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute:
          showSplashScreen ? SplashScreen.routeName : HomeScreen.routeName,
          routes: routes,
        ));
      }
  }