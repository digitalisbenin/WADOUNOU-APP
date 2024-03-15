import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/repas.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/cart/cart_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/pop_up_menu.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/popular_restaurant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/popular_meals.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/search_field.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/search_meal_field_for_users.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/search_restaurant_field_for_users.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  String searchRestaurantQuery = '';
  String searchMealQuery = '';

  List<Restaurant> favoriteRestaurants = [];

  late TextEditingController _searchRestaurantController;
  late TextEditingController _searchMealController;

  @override
  void initState() {
    super.initState();
    _searchRestaurantController = TextEditingController();
    _searchMealController = TextEditingController();
    _onRefresh();
  }

  void updateRestaurantSearch(String query_restaurant) {
    setState(() {
      searchRestaurantQuery = query_restaurant;
    });
  }

  void updateMealSearch(String query_meal) {
    setState(() {
      searchMealQuery = query_meal;
    });
  }

  bool isRefresh = false;

  Future<void> _onRefresh() async {
    try {
      setState(() {
        isRefresh = true;
      });

      List<Restaurant> restaurants = await RestaurantList.getRestaurants();
      List<Repas> repas = await RepasList.getRepas();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La page a été mis à jour'),
        ),
      );
      //return [restaurants, repas];
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Erreur lors de l'actualisation de la page. Vérifier votre connexion internet..."),
        ),
      );
      print(("Erreur: ${e}"));
    } finally {
      setState(() {
        isRefresh = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: kBackground, statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          color: kPrimaryColor,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(16),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder<String>(
                        future: DatabaseProvider().getToken(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(
                              color: kPrimaryColor,
                            );
                          } else if (snapshot.hasError) {
                            return const Text(
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
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
                              return PopupMenuButton<int>(
                                  icon: const Icon(Icons.search),
                                  color: kWhite,
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: SizedBox(
                                            width: 250,
                                            child:
                                                SearchRestaurantFieldForUsers(
                                              onSearch: updateRestaurantSearch,
                                              searchController:
                                                  _searchRestaurantController,
                                            ),
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          height: 10.0,
                                          child: SizedBox(),
                                        ),
                                        PopupMenuItem(
                                          child: SizedBox(
                                              width: 250,
                                              child: SearchMealFieldForUsers(
                                                onSearchMeal: updateMealSearch,
                                                searchMealController:
                                                    _searchMealController,
                                              )),
                                        ),
                                      ]);
                            }
                          }
                        },
                      ),
                      const PopUpMenu(),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 15),
                  child: Text(
                    "Restaurants populaires",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                PopularRestaurantWidget(
                  searchQuery: searchRestaurantQuery,
                  press: () {},
                ),

                /* const Padding(
                  padding: EdgeInsets.only(top: 20, left: 15),
                  child: Text(
                    "Mets Populaires",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                PopularMealItem(
                  searchMealQuery: searchMealQuery,
                  press: () {}, searchQuery: searchRestaurantQuery,
                ), */
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 15),
                  child: Text(
                    "Mets Populaires",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                PopularMealItem(
                  searchMealQuery: searchMealQuery,
                  press: () {},
                  searchQuery: searchRestaurantQuery,
                ),
              ],
            ),
          ),
        ),
      ),
      /* floatingActionButton: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ]),
        child: Consumer<CartProvider>(builder: (context, cartProvider, child) {
          int cartItemCount = cartProvider.cartItems.length;

          return badge.Badge(
            showBadge: cartItemCount > 0,
            badgeContent: Text(
              cartItemCount.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            badgeAnimation: const badge.BadgeAnimation.slide(
              animationDuration: Duration(milliseconds: 300),
            ),
            badgeStyle: const badge.BadgeStyle(badgeColor: kPrimaryColor),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: kPrimaryColor,
              ),
            ),
          );
        }),
      ), */
    );
  }
}
