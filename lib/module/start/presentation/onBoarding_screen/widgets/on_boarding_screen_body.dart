import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/landing/presentation/landing_screen.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/onBoarding_screen/widgets/on_boarding_screen_content.dart';
import 'package:digitalis_restaurant_app/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreenBody extends StatefulWidget {
  const OnBoardingScreenBody({super.key});

  @override
  State<OnBoardingScreenBody> createState() => _OnBoardingScreenBodyState();
}

class _OnBoardingScreenBodyState extends State<OnBoardingScreenBody> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Bienvenue sur WADOUNOU !",
      /* "image": "assets/images/splash_2.png", */
      "lottie": "assets/lotties/restaurant_edited.json",
    },
    {
      "text": "Commandez et faites vos réservations depuis chez vous et ceci dans des restaurants de marque !",
      /* "image": "assets/images/splash_3.png", */
      "lottie": "assets/lotties/order_received.json",
    },
    {
      "text": "Nos livreurs vous apporte vos commande de façon express",
      /* "image": "assets/images/splash_2.png", */
      "lottie": "assets/lotties/deliver_person_edited.json",
    }
  ];

  /* Future<void> checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final showOnBoarding = prefs.getBool('showOnBoarding') ?? true;

    // Attendre pendant quelques secondes avant de rediriger
    await Future.delayed(Duration(seconds: 5));

    if (showOnBoarding) {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    } else {
      Navigator.of(context).pushReplacementNamed('/home'); // Remplacez par la route de votre page d'accueil
    }
  } */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: ((context, index) => SplashScreenContent(
                    text: splashData[index]["text"]!,
                    /* image: splashData[index]["image"]!, */
                    lottie: splashData[index]["lottie"]!,)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3,),
                    DefaultButton(
                      text: "C'est partie!",
                      press: () async {
                        final onBoardingPrefs = await SharedPreferences.getInstance();
                        await onBoardingPrefs.setBool('showOnboarding', false);
                       Navigator.pushNamed(context, LandingScreen.routeName);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
   AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 18 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? Colors.white : const Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
