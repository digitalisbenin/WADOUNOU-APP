import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/helpers/cart/cart_db_helper.dart';
import 'package:digitalis_restaurant_app/module/account/orders/make_order_screen.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/make_reservations/make_reservation_screen.dart';
import 'package:digitalis_restaurant_app/module/cart/cart_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/home_screen_body.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CartDBHelper? cartDBHelper = CartDBHelper();

  int tabIndex = 0;

  void updateIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[400],
    ));
    final cart = Provider.of<CartProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: tabIndex,
            children: const [
              HomeScreenBody(),
              MakeReservationScreen(),
              MakeOrderScreen(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 0.5,
              ),
            ),
          ),
          child: SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.floating,
            snakeShape: SnakeShape.circle,
            unselectedLabelStyle: const TextStyle(fontSize: 11),
            snakeViewColor: kPrimaryColor,
            unselectedItemColor: kSecondaryColor,
            showSelectedLabels: true,
            currentIndex: tabIndex,
            onTap: updateIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home, size: 15.0,),
                label: "Acceuil"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article, size: 15.0,),
                label: "Réservations",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.archivebox, size: 15.0,),
                label: "Commandes",
              ),
            ],
          ),
        ),
      )
    );
  }
}
