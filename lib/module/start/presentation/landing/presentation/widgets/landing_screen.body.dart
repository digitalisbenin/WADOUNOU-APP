import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/landing/presentation/widgets/background.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingScreenBody extends StatelessWidget {
  LandingScreenBody({super.key});

  var ctime;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return WillPopScope(
      onWillPop: () async {
          DateTime now = DateTime.now();
          if (ctime == null || now.difference(ctime) > const Duration(seconds: 2)) {
            //add duration of press gap
            ctime = now;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    'Appuyer encore pour quitter'))); //scaffold message, you can show Toast message too.
            return Future.value(false);
          }

          return Future.value(true);
        },
      child: Stack(
        children: [
          const BackgroundImage(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.4,
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/WADOUNOU 01.png',
                              width: SizeConfig.screenHeight * 0.30,
                            ),
                            /* SizedBox(
                              height: SizeConfig.screenHeight * 0.25,
                            ), */
                            Text('WADOUNOU',
                                style: TextStyle(
                                    fontSize: SizeConfig.screenHeight * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Container(
                              color: Colors.white,
                              width: 150,
                              height: 5.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      "Trouvez les repas que vous aimez !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.03,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Découvrez les meilleurs repas de plus de 100 restaurants",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.016,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    verticalSpaceTiny,
                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          /*MaterialButton(
                              height: 55.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              color: kPrimaryColor,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: const Text(
                                "Inscrivez - vous",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          verticalSpaceSmall,
                          MaterialButton(
                              height: 55.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, LoginPage.routeName);
                              },
                              child: const Text(
                                "Connectez-vous",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              )),*/
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.2,
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            },
                            color: kWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.017, horizontal: SizeConfig.screenWidth * 0.017),
                              child: Text("Commandez ou Réservez", style: TextStyle(
                                fontSize: SizeConfig.screenHeight * 0.025,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ), textAlign: TextAlign.center,),
                            ),
                          )
                          /*DefaultButton(
                            text: 'Commandez ou Réservez en cliquant ici !',
                            press: () {
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            }
                          ),*/
                          /*TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, HomeScreen.routeName);
                              },
                              child: Text(
                                'Commandez ou Réservez en cliquant ici !'
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: kcWhiteColor,
                                    fontSize: 13.0,
                                    decoration: TextDecoration.underline),
                              ))*/
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
