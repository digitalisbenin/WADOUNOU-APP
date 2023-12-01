import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({
    required this.text,
    /* required this.image, */ required this.lottie,
  });

  final String text, /* image, */ lottie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SizedBox(
          height: SizeConfig.screenHeight * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(text,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.screenHeight * 0.024,
                  fontWeight: FontWeight.bold)),
        ),
        const Spacer(
          flex: 2,
        ),
        Lottie.asset(
          lottie,
          height: SizeConfig.screenHeight * 0.3,
          width: SizeConfig.screenWidth * 0.6,
        ),
      ],
    );
  }
}
