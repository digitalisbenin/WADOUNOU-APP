import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/onBoarding_screen/widgets/on_boarding_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static String routeName = "/onboarding";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  Future<void> closeApp() {
    return SystemNavigator.pop();
  }

  void firstRun() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', false);
  }

  @override
  void initState() {
    super.initState();
    firstRun();
  }

  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        return closeApp() as bool;
    },
      child: const Scaffold(
        backgroundColor: kOnBoardingBackgroundColor,
        body: OnBoardingScreenBody(),
      ),
    );
  }
}