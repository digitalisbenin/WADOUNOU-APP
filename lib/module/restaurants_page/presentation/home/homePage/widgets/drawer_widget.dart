import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/customListTileWidget.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_bookings/userBookingsPage.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_orders/usersOdersPage.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kBackground,
      child: FutureBuilder<String>(
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
              return ListView(
                children: [
                  const DrawerHeader(
                    padding: EdgeInsets.zero,
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                      ),
                      accountName: Text(
                        "Nom de l'utilisateur",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      accountEmail: Text(
                        "test@gmail.com",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/avatar.jpg"),
                      ),
                    ),
                  ),
                  CustomListTileWidget(
                    text: 'Accueil',
                    iconData: CupertinoIcons.home,
                    press: () {},
                  ),
                  CustomListTileWidget(
                    text: 'Mon Profil',
                    iconData: CupertinoIcons.person,
                    press: () {},
                  ),
                  CustomListTileWidget(
                    text: 'Mes Commandes',
                    iconData: CupertinoIcons.cart_fill,
                    press: () {},
                  ),
                  CustomListTileWidget(
                    text: 'Mes Favoris',
                    iconData: CupertinoIcons.heart_fill,
                    press: () {},
                  ),
                  CustomListTileWidget(
                    text: 'Paramètres',
                    iconData: CupertinoIcons.settings,
                    press: () {},
                  ),
                  CustomListTileWidget(
                    text: 'Se déconnecter',
                    iconData: Icons.logout_outlined,
                    press: () {},
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Image.asset(
                    "assets/images/WADOUNOU 01.jpg",
                    height: SizeConfig.screenHeight * 0.3,
                    width: SizeConfig.screenWidth * 0.3,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  CustomListTileWidget(
                    text: 'Suivre mes Commandes',
                    iconData: CupertinoIcons.arrow_right_arrow_left_square_fill,
                    press: () {
                      Navigator.pushNamed(context, UsersOrdersPage.routeName);
                    },
                  ),
                  CustomListTileWidget(
                    text: 'Suivre mes Réservations',
                    iconData: CupertinoIcons.calendar,
                    press: () {
                      Navigator.pushNamed(context, UsersBookingsPage.routeName);
                    },
                  ),
                  CustomListTileWidget(
                    text: 'Sortir de l\'application',
                    iconData: Icons.exit_to_app,
                    press: () {},
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  const Text(
                    "ou si vous detenez un compte restaurant ou souhaitez en créer un :",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kPrimaryColor,
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Se Connecter",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kWhite,
                            border: Border.all(color: Colors.grey)),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "S'inscrire",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
