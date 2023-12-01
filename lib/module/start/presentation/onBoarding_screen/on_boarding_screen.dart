import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/onBoarding_screen/widgets/on_boarding_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  static String routeName = "/onboarding";

  Future<void> closeApp() {
    return SystemNavigator.pop();
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