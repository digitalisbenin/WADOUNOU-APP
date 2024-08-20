import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/make_reservations/make_reservation_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/drawer_widget.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/home_screen_body.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/pop_up_menu.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/all_meals/widgets/all_meals_screen_body.dart';
import 'package:digitalis_restaurant_app/module/screens/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;
  String? roleId;

  @override
  void initState() {

    super.initState();
  }

  final PageController _pageController = PageController();

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
    /*SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: kOnBoardingBackgroundColor, statusBarIconBrightness: Brightness.light));*/
    //  final cart = Provider.of<CartProvider>(context);
    return WillPopScope(
        onWillPop: () => _onBackButtonClickedDoubleClicked(context),
        child: Scaffold(
          backgroundColor: kWhite,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: kWhite),
            title: Text(
              'Bienvenue sur WADOUNNOU'.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.5,
                  color: kWhite),
            ),
            centerTitle: true,
            backgroundColor: kOnBoardingBackgroundColor,
            /*actions: const [
              PopUpMenu(),
            ],*/
          ),
          body: PageView(
            controller: _pageController,
            children: [
              const HomeScreenBody(),
              AllMealsScreenBody(
                searchMealQuery: searchMealQuery,
                press: () {},
                searchQuery: searchRestaurantQuery,
              ),
              const MakeReservationScreen(),
              const ProfileScreen(),
            ],
            onPageChanged: (index) {
              setState(() {
                tabIndex = index;
              });
            },
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: kOnBoardingBackgroundColor,
                  width: 0.5,
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.orange.shade400,
                  hoverColor: Colors.orangeAccent.shade100,
                  gap: 8,
                  activeColor: kPrimaryColor,
                  iconSize: 20,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.orange.withOpacity(0.3),
                  color: kPrimaryColor,
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      leading: SvgPicture.asset('assets/svg/restaurant-icon.svg', height: 18, color: kPrimaryColor,),
                      text: 'Accueil',
                    ),
                    GButton(
                      icon: Icons.set_meal,
                      leading: SvgPicture.asset('assets/svg/dish-icon.svg', height: 18, color: kPrimaryColor,),
                      text: 'Les Mets',
                    ),
                    GButton(
                    icon: Icons.edit_note_sharp,
                      leading: SvgPicture.asset('assets/svg/meeting-table-icon.svg', height: 18, color: kPrimaryColor,),
                    text: 'Reservations',
                  ),
                    GButton(
                      icon: CupertinoIcons.profile_circled,
                      leading: SvgPicture.asset('assets/svg/profile-boy-icon.svg', height: 18, color: kPrimaryColor,),
                      text: 'Mon Compte',
                    ),
                  ],
                  selectedIndex: tabIndex,
                  onTabChange: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          ),
          drawer: const DrawerWidget(),
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
