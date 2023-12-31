import 'package:digitalis_restaurant_app/core/enums/menu_enums.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_orders/widgets/usersOrdersBody.dart';
import 'package:digitalis_restaurant_app/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

class UsersOrdersPage extends StatelessWidget {
  const UsersOrdersPage({super.key});

  static String routeName = '/users_orders_page';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              "Mes Commandes",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18.0,
              ),
            )),
        body: const UsersOrdersBody(),
      ),
    );
  }
}
