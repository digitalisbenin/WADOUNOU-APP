import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/all_meals/widgets/all_meals_screen_body.dart';
import 'package:flutter/material.dart';

class AllMealsScreen extends StatefulWidget {
  const AllMealsScreen({super.key});

  static String routeName = '/all_meals';

  @override
  State<AllMealsScreen> createState() => _AllMealsScreenState();
}

class _AllMealsScreenState extends State<AllMealsScreen> {
  String searchRestaurantQuery = '';

  String searchMealQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AllMealsScreenBody(
        searchMealQuery: searchMealQuery,
                  press: () {},
                  searchQuery: searchRestaurantQuery,
      ),
    );
  }
}