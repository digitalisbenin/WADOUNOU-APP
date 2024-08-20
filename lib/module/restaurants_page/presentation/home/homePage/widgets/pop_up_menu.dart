import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_bookings/userBookingsPage.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_orders/usersOdersPage.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/landing/presentation/landing_screen.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

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
          return const CircularProgressIndicator(color: kPrimaryColor,);
        } else if (snapshot.hasError) {
          return Text(
              'Erreur : La connexion au serveur à échouée ! Vérifier votre connexion internet',
              textAlign: TextAlign.center,
            );
        } else {
          final userToken = snapshot.data;
          if (userToken!.isNotEmpty) {
            return Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                height: 50,
                width: 50,
                child: PopupMenuButton<String>(
                  color: Colors.white,
                  iconColor: kWhite,
                  iconSize: 27,
                  onSelected: (String choice) {
                    if (choice == 'Mes commandes') {
                      Navigator.pushNamed(context, UsersOrdersPage.routeName);
                    }
                    if (choice == 'Mes réservations') {
                      Navigator.pushNamed(context, UsersBookingsPage.routeName);
                    }
                    if (choice == 'Quitter l\'application') {
                      GetStorage().remove('role_id');
                      GetStorage().remove('token');
                      DatabaseProvider().logOut(context);
                      SystemNavigator.pop();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      'Mes commandes',
                      'Mes réservations',
                      'Quitter l\'application'
                    ].map((String choice) {
                      return PopupMenuItem(value: choice, child: Text(choice));
                    }).toList();
                  },
                  padding: const EdgeInsets.all(0),
                ));
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
