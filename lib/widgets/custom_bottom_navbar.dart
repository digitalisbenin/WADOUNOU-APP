import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/enums/menu_enums.dart';
import 'package:digitalis_restaurant_app/module/account/account_view_page.dart';
import 'package:digitalis_restaurant_app/module/account/orders/orders_screen.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/reservations_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_bookings/userBookingsPage.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_orders/usersOdersPage.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
    required this.selectedMenu,
  });

  final MenuState selectedMenu;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  MenuState? _selectedMenu;

  @override
  void initState() {
    super.initState();
    _selectedMenu = widget.selectedMenu;
  }


  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return FutureBuilder<String>(
      future: DatabaseProvider().getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(color: kPrimaryColor,);
        } else if (snapshot.hasError) {
          return const Text(
              'Erreur : La connexion au serveur à échouée ! Vérifier votre connexion internet',
              textAlign: TextAlign.center,
            );
        } else {
          final userToken = snapshot.data;
          if (userToken!.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, -15),
                        blurRadius: 20,
                        color: const Color(0xFFDADADA).withOpacity(0.15)),
                  ]),
              child: SafeArea(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedMenu = MenuState.home;
                      });
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/home.svg",
                      color: _selectedMenu == MenuState.home
                          ? kPrimaryColor
                          : inActiveIconColor,
                      height: 20.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedMenu = MenuState.reservations;
                      });
                      Navigator.pushNamed(context, ReservationsScreens.routeName);
                    },
                    icon: SvgPicture.asset("assets/icons/reservations.svg",
                        color: _selectedMenu == MenuState.reservations
                            ? kPrimaryColor
                            : inActiveIconColor,
                        height:
                        20.0),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedMenu = MenuState.orders;
                      });
                      Navigator.pushNamed(context, OrdersScreens.routeName);
                    },
                    icon: SvgPicture.asset("assets/icons/orders.svg",
                        color: _selectedMenu == MenuState.orders
                            ? kPrimaryColor
                            : inActiveIconColor, height: 20.0),
                  ),
                  IconButton(
                    onPressed:
                        () {
                      setState(() {
                        _selectedMenu = MenuState.profile;
                      });
                      Navigator.pushNamed(context, AccountViewPage.routeName);
                    },
                    icon: SvgPicture.asset("assets/icons/ic_person.svg",
                        color: _selectedMenu == MenuState.profile
                            ? kPrimaryColor
                            : inActiveIconColor, height: 20.0),
                  ),
                ]),
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, -15),
                        blurRadius: 20,
                        color: const Color(0xFFDADADA).withOpacity(0.15)),
                  ]),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedMenu = MenuState.home;
                        });
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/home.svg",
                        color: _selectedMenu == MenuState.home
                            ? kPrimaryColor
                            : inActiveIconColor,
                        height: 20.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedMenu = MenuState.reservations;
                        });
                        Navigator.pushNamed(context, UsersBookingsPage.routeName);
                      },
                      icon: SvgPicture.asset("assets/icons/reservations.svg",
                          color: _selectedMenu == MenuState.reservations
                              ? kPrimaryColor
                              : inActiveIconColor,
                          height:
                          20.0),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedMenu = MenuState.orders;
                        });
                        Navigator.pushNamed(context, UsersOrdersPage.routeName);
                      },
                      icon: SvgPicture.asset("assets/icons/orders.svg",
                          color: _selectedMenu == MenuState.orders
                              ? kPrimaryColor
                              : inActiveIconColor, height: 20.0),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
