import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/search_field.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/search_restaurant_field_for_users.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DatabaseProvider().getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: kPrimaryColor,
          );
        } else if (snapshot.hasError) {
          return Text(
            'Erreur : La connexion au serveur à échouée ! Vérifier votre connexion internet',
            textAlign: TextAlign.center,
          );
        } else {
          final userToken = snapshot.data;
          if (userToken!.isNotEmpty) {
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 12,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 0))
                        ]),
                    child: const Icon(CupertinoIcons.bars),
                  ),
                ),
                const SearchField(),
              ],
            );
          } else {
            return const Row(
              children: [
                //  SearchFieldForUsers(),
              ],
            );
          }
        }
      },
    );
  }
}
