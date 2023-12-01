import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_bookings/userBookingsPage.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_orders/usersOdersPage.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/landing/presentation/landing_screen.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({
    super.key,
  });

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DatabaseProvider().getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error : ${snapshot.error}');
        } else {
          final userToken = snapshot.data;
          if (userToken!.isNotEmpty) {
            return Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                height: 50,
                width: 50,
                child: PopupMenuButton<String>(
                  iconSize: 27,
                  onSelected: (String choice) {
                    if (choice == 'Ajouter/Gérer un restaurant') {
                      Navigator.pushNamed(context, LandingScreen.routeName);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      'Ajouter/Gérer un restaurant',
                    ].map((String choice) {
                      return PopupMenuItem(value: choice, child: Text(choice));
                    }).toList();
                  },
                  padding: const EdgeInsets.all(0),
                ));
          } else {
            return Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                height: 50,
                width: 50,
                child: PopupMenuButton<String>(
                  iconSize: 27,
                  onSelected: (String choice) {
                    if (choice == 'Mes commandes') {
                      Navigator.pushNamed(context, UsersOrdersPage.routeName);
                    }
                    if (choice == 'Mes réservations') {
                      Navigator.pushNamed(context, UsersBookingsPage.routeName);
                    }
                    if (choice == 'Sortir de l\'application') {
                      SystemNavigator.pop();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      'Mes commandes',
                      'Mes réservations',
                      'Sortir de l\'application'
                    ].map((String choice) {
                      return PopupMenuItem(value: choice, child: Text(choice));
                    }).toList();
                  },
                  padding: const EdgeInsets.all(0),
                ));
          }
        }
      },
    );
  }
}
