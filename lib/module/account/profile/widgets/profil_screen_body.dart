import 'package:digitalis_restaurant_app/module/account/profile/edit_restaurant_info/edit_restaurant_info.dart';
import 'package:digitalis_restaurant_app/module/account/profile/edit_user_profil/edit_profile_page.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:flutter/material.dart';

final _menu = [
    {'title': 'Modifier mon profil', 'route': EditProfilePage.routeName},
    {'title': 'Modifier les informations du restaurant', 'route': EditRestaurantPage.routeName},
];

class ProfilScreenBody extends StatefulWidget {
  const ProfilScreenBody({super.key});

  @override
  State<ProfilScreenBody> createState() => _ProfilScreenBodyState();
}

class _ProfilScreenBodyState extends State<ProfilScreenBody> {
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
                key: ValueKey("editing_profil"),
                itemCount: _menu.length,
                separatorBuilder: (_, i) {
                  if (i == -1) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(),
                  );
                },
                itemBuilder: (_, i) {
                  return ListTile(
                    key: ValueKey("item_${i}_profile"),
                    title: Text(
                      _menu[i]['title'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 16,
                    ),
                    onTap: () {
                      final routeName = _menu[i]['route'];
                      if (routeName != null) {
                        Navigator.of(context).pushNamed(routeName);
                      } 
                    },
                  );
                },
              ),
            ),
          ),
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