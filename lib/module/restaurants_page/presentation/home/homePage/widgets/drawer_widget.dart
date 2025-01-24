import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Role/fetch_all_users_role.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/module/livreurs_page/livreurs_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/customListTileWidget.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/bookings/all_bookings.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/favoris/all_user_favoris.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/orders/all_orders.dart';
import 'package:digitalis_restaurant_app/module/screens/login/login_page.dart';
import 'package:digitalis_restaurant_app/module/screens/signup/sign_up_page.dart';
import 'package:digitalis_restaurant_app/module/selected_role_page/selected_role_screen.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_bookings/userBookingsPage.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_orders/usersOdersPage.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/landing/presentation/landing_screen.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  final nomUser = GetStorage().read('userName') ?? '';

  final token = GetStorage().read('token');

  final mailUser = GetStorage().read('userMail') ?? '';

  String? globalRoleId;

  @override
  void initState() {
    super.initState();
    globalRoleId = GetStorage().read('role_id');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: kBackground,
        child: FutureBuilder<String>(
          future: fetchLivreurRoleId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: kPrimaryColor,));
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Erreur : Vérifer votre connexion internet',
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              final roleIdFromApi = snapshot.data;
              return ListView(
                children: [
                  if ((token != null && token.isNotEmpty) && globalRoleId != null)
                    DrawerHeader(
                      padding: EdgeInsets.zero,
                      child: UserAccountsDrawerHeader(
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                        ),
                        accountName: Text(
                          "$nomUser",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        accountEmail: Text(
                          '$mailUser',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  if ((token != null && token.isNotEmpty) && globalRoleId != null)
                    CustomListTileWidget(
                      text: 'Mes Favoris',
                      svgPicture: SvgPicture.asset('assets/svg/hobbies-like-icon.svg', height: 25, color: kPrimaryColor,),
                      press: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AllUserFavories()));
                      },
                    ),
                  if ((token != null && token.isNotEmpty) && globalRoleId != null)
                    CustomListTileWidget(
                      text: 'Mes Commandes',
                      svgPicture: SvgPicture.asset('assets/svg/order-history-icon.svg', height: 25, color: kPrimaryColor,),
                      press: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AllOrdersScreen()));
                      },
                    ),
                  if ((token != null && token.isNotEmpty) && globalRoleId != null)
                    CustomListTileWidget(
                      text: 'Mes Réservations',
                      svgPicture: SvgPicture.asset('assets/svg/booking-reservation-icon.svg', height: 20, color: kPrimaryColor,),
                      press: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AllBookingsScreen()));
                      },
                    ),

                  if (globalRoleId == roleIdFromApi)
                    CustomListTileWidget(
                      text: 'Valider mon profil',
                      svgPicture: SvgPicture.asset('assets/svg/profile-boy-icon.svg', height: 25, color: kPrimaryColor,),
                      press: () {
                        Navigator.pushNamed(context, LivreurScreen.routeName);
                        print('::::::::::::::::;;;;; $globalRoleId');
                      },
                    ),
                  if ((token != null && token.isNotEmpty) && globalRoleId != null)
                    CustomListTileWidget(
                      text: 'Se déconnecter',
                      svgPicture: SvgPicture.asset('assets/svg/door-check-out-icon.svg', height: 25, color: kPrimaryColor,),
                      press: () {
                        GetStorage().remove('role_id');
                        GetStorage().remove('token');
                        DatabaseProvider().logOut(context);
                        PageNavigator(ctx: context).nextPageOnly(page: const LandingScreen());
                      },
                    ),
                  if (token == null && globalRoleId == null)
                    Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: AppFilledButton(
                              text: "Se connecter",
                              onPressed: () {
                                PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
                                /*Navigator.pushNamed(
                                    context, LoginPage.routeName);*/
                              },
                              color: kWhite,
                              txtColor: kPrimaryColor,
                            ),
                          ),
                        ),
                        const Text("ou", style: TextStyle(fontSize: 18)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: AppFilledButton(
                              text: "S'inscrire",
                              onPressed: () {
                                PageNavigator(ctx: context).nextPageOnly(page: const SelectedRoleScreen());
                              },
                              color: kPrimaryColor,
                              txtColor: kWhite,
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              );
            }
          },
        ),
    );
  }
}
