import 'package:digitalis_restaurant_app/module/account/add_delivery_person/add_delivery_person_page.dart';
import 'package:digitalis_restaurant_app/module/account/add_meal/add_meal_page.dart';
import 'package:digitalis_restaurant_app/module/account/delivery_list_view/delivery_person_listview_page.dart';
import 'package:digitalis_restaurant_app/module/account/orders/orders_screen.dart';
import 'package:digitalis_restaurant_app/module/account/profile/profil.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/reservations_screen.dart';
import 'package:digitalis_restaurant_app/module/account/subscription/subscription_page.dart';
import 'package:digitalis_restaurant_app/module/create_restaurant/create_restaurant_page.dart';
import 'package:digitalis_restaurant_app/provider/auth_provider.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _menu = [
  {'title': 'Gérer mon abonnement', 'route': SubscriptionPage.routeName},
  {'title': 'Créer un nouveau restaurant', 'route': CreateRestaurant.routeName},
  {'title': 'Ajouter un Repas', 'route': AddMealPage.routeName},
  {'title': 'Ajouter un Livreur', 'route': AddDeliveryPersonPage.routeName},
  {'title': 'Voir mes livreurs', 'route': DeliveryPersonListviewPage.routeName},
  {'title': 'Réservation(s)', 'route': ReservationsScreens.routeName},
  {'title': 'Commande(s)', 'route': OrdersScreens.routeName},
  {'title': 'Modifier le profil', 'route': ProfilePage.routeName},
  {'title': 'Déconnexion', 'action': 'logout'},
];

class AccountViewBody extends StatefulWidget {
  const AccountViewBody({super.key});

  @override
  State<AccountViewBody> createState() => _AccountViewBodyState();
}

class _AccountViewBodyState extends State<AccountViewBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: header(context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Flexible(
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                key: const ValueKey("account"),
                itemCount: _menu.length,
                separatorBuilder: (_, i) {
                  if (i == -1) {
                    return const SizedBox();
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(),
                  );
                },
                itemBuilder: (_, i) {
                  return Consumer<AuthenticationProvider>(
                    builder: (context, snapshot, child) {
                      return ListTile(
                        key: ValueKey("item_${i}_account"),
                        title: Text(
                          _menu[i]['title'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 16,
                        ),
                        onTap: () {
                          final routeName = _menu[i]['route'];
                          final action = _menu[i]['action'];
                          if (routeName != null) {
                            snapshot.profile();
                            Navigator.of(context).pushNamed(routeName);
                          } else if (action == 'logout') {
                            // Effectuer les étapes de déconnexion
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                          'Confirmez vous la déconnexion'),
                                      content: const Text(
                                          'Êtes-vous sûr de vouloir vous déconnecter?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Effectuer la déconnexion en vidant d'abord les données ici
                                            DatabaseProvider().logOut(context);

                                            /* Navigator.of(context).pop();
                                            Navigator.pushNamed(
                                                context, LandingScreen.routeName); */
                                          },
                                          child: const Text("Oui"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Fermer la boîte de dialogue
                                          },
                                          child: const Text('Annuler'),
                                        ),
                                      ],
                                    ));
                          }
                        },
                      );
                    }
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Row(
        children: [
          Image.asset(
            "assets/images/avatar.jpg",
            height: 100,
            width: 100,
          ),
          horizontalSpaceTiny,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.black),
                  overflow: TextOverflow.fade,
                ),
                verticalSpaceSmall,
                const Text(
                  "User email",
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
