import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/repas.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/item_details_page.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/widgets/new_arrivals_widgets/new_arrivals_screen.dart';
import 'package:digitalis_restaurant_app/widgets/meal_card.dart';
import 'package:flutter/material.dart';

class RestaurantsNewArrivalPages extends StatelessWidget {
  const RestaurantsNewArrivalPages({super.key});

  static String routeName  = '/new_arrival_page';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RestaurantsNewArrivalScreen(),
    );

   
  }
}
