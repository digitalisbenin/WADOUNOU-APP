import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/onBoarding_screen/on_boarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.35,
          ),
          Image.asset(
            'assets/images/WADOUNOU 01.png',
            width: SizeConfig.screenHeight * 0.25,
          ),
          const Spacer(
            flex: 4,
          ),
          Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'powered by ',
                    style: TextStyle(fontSize: 14, color: kTextColor),
                  ),

                  const SizedBox(width: 5,),
                  Image.asset('assets/images/lodo_digitalis.png', width: SizeConfig.screenHeight * 0.14,)
                ],
              ))
        ],
      ),
      backgroundColor: kWhite,
      splashIconSize: SizeConfig.screenHeight * 0.95,
      duration: 5000,
      splashTransition: SplashTransition.scaleTransition,
      animationDuration: const Duration(seconds: 1),
      nextScreen: const OnBoardingScreen(),
      
      
      /* FutureBuilder<String>(future:  DatabaseProvider().getToken(), builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error : ${snapshot.error}');
        } else {
          final userToken = snapshot.data;
          if (userToken!.isNotEmpty) {
            return const HomeScreen();
          } else {
            return const OnBoardingScreen();
          }
        }
      }) */
    );
  }
}
