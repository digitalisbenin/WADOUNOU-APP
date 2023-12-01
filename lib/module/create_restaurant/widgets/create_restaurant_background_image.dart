import 'package:flutter/material.dart';

class CreateRestaurantBackgroundImage extends StatefulWidget {
  const CreateRestaurantBackgroundImage({super.key});

  @override
  State<CreateRestaurantBackgroundImage> createState() =>
      _CreateRestaurantBackgroundImageState();
}

class _CreateRestaurantBackgroundImageState
    extends State<CreateRestaurantBackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
              colors: [Colors.white54, Colors.white.withOpacity(0.6)],
              begin: Alignment.bottomCenter,
              end: Alignment.center)
          .createShader(bounds),
      blendMode: BlendMode.lighten,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/restaurant_interieur.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.white70, BlendMode.luminosity))),
      ),
    );
  }
}
