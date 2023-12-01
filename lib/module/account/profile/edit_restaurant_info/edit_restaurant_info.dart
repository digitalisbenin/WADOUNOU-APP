import 'package:digitalis_restaurant_app/module/account/profile/edit_restaurant_info/widgets/edit_restaurant_body.dart';
import 'package:flutter/material.dart';

class EditRestaurantPage extends StatelessWidget {
  const EditRestaurantPage({super.key});

  static String routeName = '/edit_restaurant_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: const Text(
              "Modifier les information du restaurant",
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
            body: EditRestaurantInfoBody(),
    );
  }
}