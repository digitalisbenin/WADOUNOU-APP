import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/screens/profile/widgets/profile_screen_body.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mon Compte",
          style: TextStyle(color: kWhite),
        ),
        backgroundColor: kOnBoardingBackgroundColor,
        iconTheme: const IconThemeData(color: kWhite),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: const ProfileScreenBody(),
    );
  }
}
