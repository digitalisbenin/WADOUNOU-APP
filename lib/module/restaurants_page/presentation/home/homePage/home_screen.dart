import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/make_reservations/make_reservation_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/home_screen_body.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/all_meals/widgets/all_meals_screen_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void updateIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  DateTime backPressedTime = DateTime.now();

  String searchRestaurantQuery = '';

  String searchMealQuery = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: kBackground, statusBarIconBrightness: Brightness.dark));
    //  final cart = Provider.of<CartProvider>(context);
    return WillPopScope(
        onWillPop: () => _onBackButtonClickedDoubleClicked(context),
        child: Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: tabIndex,
              children: [
                const HomeScreenBody(),
                AllMealsScreenBody(
                  searchMealQuery: searchMealQuery,
                  press: () {},
                  searchQuery: searchRestaurantQuery,
                ),
                const MakeReservationScreen(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: kPrimaryColor,
                  width: 0.5,
                ),
              ),
            ),
            child: SnakeNavigationBar.color(
              backgroundColor: kWhite,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(color: kWhite),
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
                    icon: Icon(
                      CupertinoIcons.home,
                      size: 15.0,
                    ),
                    label: "Acceuil"),
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.archivebox,
                    size: 15.0,
                  ),
                  label: "Les Repas",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.article,
                    size: 15.0,
                  ),
                  label: "Réservations",
                ),
              ],
            ),
          ),
        ));
  }

  Future<bool> _onBackButtonClickedDoubleClicked(BuildContext context) async {
    final difference = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();

    if (difference >= const Duration(seconds: 2)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appuyer encore pour quitter')));
      return false;
    } else {
      SystemNavigator.pop(animated: true);
      return true;
    }
  }
}
