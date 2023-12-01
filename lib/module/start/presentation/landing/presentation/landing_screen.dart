import 'package:digitalis_restaurant_app/module/start/presentation/landing/presentation/widgets/landing_screen.body.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  static String routeName = '/landing';

  @override
   Widget build(BuildContext context) {
    return const Scaffold(
      body: LandingScreenBody(),
    );
  }

  
}