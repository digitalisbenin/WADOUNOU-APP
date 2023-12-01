import 'dart:async';

import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/account/account_view_page.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/accoun_view_delivery_person.dart';
import 'package:digitalis_restaurant_app/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterDeliveryPersonSuccess extends StatefulWidget {
  const RegisterDeliveryPersonSuccess({super.key});

  static String routeName = "/finish_registered_delivery_person";

  @override
  State<RegisterDeliveryPersonSuccess> createState() =>
      _RegisterDeliveryPersonSuccessState();
}

class _RegisterDeliveryPersonSuccessState
    extends State<RegisterDeliveryPersonSuccess> {
  bool showButton = false;
  bool showText = false;

  @override
  void initState() {
    super.initState();
    // Attendre 3 secondes avant d'afficher le bouton
    Timer(const Duration(seconds: 5), () {
      setState(() {
        showButton = true;
      });
    });

    // Attendre 1 seconds avant d'afficher le text
    Timer(const Duration(seconds: 3), () {
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
                                "Inscription et Enregistrement Réussis !",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: SizeConfig.screenWidth * 0.045,
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
                      child: DefaultButton(text: "Allez sur ma page", press: () {
                        Navigator.pushNamed(context, AccountViewDeliveryPerson.routeName);
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
