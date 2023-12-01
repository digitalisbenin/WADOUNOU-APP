import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/account/delivery_person_edit_profile_page.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/affiliate_restaurant/affiliate_restaurant_page.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/delivery_status/delivery_status_page.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:flutter/material.dart';

final _options = [
  {'title': 'Modifier mon profil', 'route' : DeliveryPersonEditProfilePage.routeName},
  {'title': 'Détails sur mes livraisons', 'route': DeliveryStatusPage.routeName},
  {'title': 'Mes Restaurant(s) affilié(s)', 'route': AffiliateRestaurantPage.routeName},
  {'title': 'Déconnexion', 'action': 'logout'}
];

class AccountViewDeliveryPersonBody extends StatefulWidget {
  const AccountViewDeliveryPersonBody({super.key});

  @override
  State<AccountViewDeliveryPersonBody> createState() => _AccountViewDeliveryPersonBodyState();
}

class _AccountViewDeliveryPersonBodyState extends State<AccountViewDeliveryPersonBody> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
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
                  key: const ValueKey("delivery_person_account"),
                  itemCount: _options.length,
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
                    return ListTile(
                      key: ValueKey("delivery_person_item_${i}_account"),
                      title: Text(
                        _options[i]['title'].toString(),
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
                        final routeName = _options[i]['route'];
                        final action = _options[i]['actions'];
                        if (routeName != null) {
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

                                      Navigator.of(context).pop();
                                      Navigator.pushNamed(
                                          context, HomeScreen.routeName);
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
                  },
                ),
              ),
            )
          ],
        ),
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
                  'Delivery Person Fullname',
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