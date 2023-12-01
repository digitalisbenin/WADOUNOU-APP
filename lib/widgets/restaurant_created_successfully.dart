import 'dart:async';

import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/account/account_view_page.dart';
import 'package:digitalis_restaurant_app/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RestaurantCreatedSuccessfully extends StatefulWidget {
  const RestaurantCreatedSuccessfully({super.key});

  static String routeName = "/finish_created_restaurant";

  @override
  State<RestaurantCreatedSuccessfully> createState() =>
      _RestaurantCreatedSuccessfullyState();
}

class _RestaurantCreatedSuccessfullyState
    extends State<RestaurantCreatedSuccessfully> {
  bool showButton = false;
  bool showText = false;

  @override
  void initState() {
    super.initState();
    // Attendre 3 secondes avant d'afficher le bouton
    Timer(const Duration(seconds: 3), () {
      setState(() {
        showButton = true;
      });
    });

    // Attendre 1 seconds avant d'afficher le text
    Timer(const Duration(seconds: 1), () {
      setState(() {
        showText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       return false;
      },
      child: Scaffold(
        backgroundColor: kBackground,
        body: Center(
            child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.2,
            ),
            SizedBox(
                height: SizeConfig.screenHeight * 0.48,
                width: SizeConfig.screenHeight * 0.48,
                child: Column(
                  children: [
                    Lottie.asset("assets/lotties/success_edited.json"),
                    const SizedBox(
                      height: 8.0,
                    ),
                    AnimatedOpacity(
                        opacity: showText ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 400),
                        child: showText
                            ? Text(
                                "Réussi !",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: SizeConfig.screenWidth * 0.066,
                                    fontWeight: FontWeight.w600),
                              )
                            : const SizedBox())
                  ],
                )),
            SizedBox(
              height: SizeConfig.screenHeight * 0.15,
            ),
            /*  if (showButton) */
            AnimatedOpacity(
              opacity: showButton ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: showButton
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8.0),
                      child: DefaultButton(text: "Suivant", press: () {
                        Navigator.pushNamed(context, AccountViewPage.routeName);
                      }),
                    )
                  : const SizedBox(),
            ),
          ],
        )),
      ),
    );
  }
}
