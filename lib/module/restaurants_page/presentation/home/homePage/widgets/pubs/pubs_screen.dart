import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class PubImageSlider extends StatefulWidget {
  const PubImageSlider({super.key});

  @override
  State<PubImageSlider> createState() => _PubImageSliderState();
}

class _PubImageSliderState extends State<PubImageSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.25,
          width: double.infinity,
          child: AnotherCarousel(
            images: [
              AssetImage("assets/images/délice.jpg"),
              AssetImage("assets/images/images (9).jpeg"),
              // AssetImage("assets/images/images (10).jpeg"),
            ],
            dotSize: 4,
            indicatorBgPadding: 5.0,
          ),
        )
      ],
    );
  }
}
