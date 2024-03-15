
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/onBoarding_screen/on_boarding_screen.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/splash_screen/widgets/splash_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 bool isFirst = false;

  @override
  void initState() {
    super.initState();
    checkFirstRun();
  }

  Future<void> checkFirstRun() async {
    
    final prefs = await SharedPreferences.getInstance();
    var isFr = prefs.getBool('isFirstRun');
    if (isFr == false) {
      setState(() {
        isFirst = false;
      });
    } else {
      setState(() {
        isFirst = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SplashScreenBody(nextScreen: isFirst ? const OnBoardingScreen() : const HomeScreen(),),
    );
  }
}