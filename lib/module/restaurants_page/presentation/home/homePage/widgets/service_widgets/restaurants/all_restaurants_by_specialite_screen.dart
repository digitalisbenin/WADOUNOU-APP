import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/restaurants/widgets/restaurant_by_specilites.dart';
import 'package:flutter/material.dart';

class AllRestaurantsBySpecialiteScreen extends StatefulWidget {
  const AllRestaurantsBySpecialiteScreen({super.key});

  @override
  State<AllRestaurantsBySpecialiteScreen> createState() => _AllRestaurantsBySpecialiteScreenState();
}

class _AllRestaurantsBySpecialiteScreenState extends State<AllRestaurantsBySpecialiteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kOnBoardingBackgroundColor,
        title: const Text('Nos Restaurants', style: TextStyle(color: kWhite),),
        centerTitle: true,
      ),
      body: const RestaurantBySpecialiteBody(),
    );
  }
}
