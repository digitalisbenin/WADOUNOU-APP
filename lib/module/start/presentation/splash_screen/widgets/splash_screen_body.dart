import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/onBoarding_screen/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key, required this.nextScreen});

  final Widget nextScreen;

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
              )),
        ],
      ),
      backgroundColor: kWhite,
      splashIconSize: SizeConfig.screenHeight * 0.95,
      duration: 5000,
      splashTransition: SplashTransition.scaleTransition,
      animationDuration: const Duration(seconds: 1),
      nextScreen:widget.nextScreen,

    
      
      /* FutureBuilder<String>(future:  DatabaseProvider().getToken(), builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(color: kPrimaryColor,);
        } else if (snapshot.hasError) {
          return Text(
              'Erreur : La connexion au serveur à échouée ! Vérifier votre connexion internet',
              textAlign: TextAlign.center,
            );
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

  checkPreferences() async {
    // Initialisation d'une instance de Shared Preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Creation d'une preference
    final bool isFirstRun = preferences.getBool('isFirstRun') ?? true;

    if(isFirstRun){
      // Navigation vers l'interface de OnBoardingScreen
      Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
      // Ici comme il n'y a aucune valeur dans la preference on initialise une preference à false
      preferences.setBool('isFirstRun', false);
    }else{
      // ici il existe déjà une valeur dans la preference on passe directement à l'interface de HomeScreen
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      preferences.setBool('isFirstRun', true);
    }
  }

}
