import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/account/add_meal/widgets/add_meal_body.dart';
import 'package:flutter/material.dart';

class AddMealPage extends StatelessWidget {
  const AddMealPage({super.key});

  static String routeName = '/add_meal_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
            title: const Text(
              "Mon Nouveau Plat",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18.0,
              ),
            )),
            body: AddMealBody(),
    );
  }
}