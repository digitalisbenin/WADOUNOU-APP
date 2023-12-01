import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/pop_up_menu.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/popular_restaurant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/popular_meals.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/search_field.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/search_meal_field_for_users.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/search_restaurant_field_for_users.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(16),
            ),
            // const HomeScreenHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String>(
                    future: DatabaseProvider().getToken(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error : ${snapshot.error}');
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
                          return PopupMenuButton<int>(
                              icon: const Icon(Icons.search),
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: SizedBox(
                                        width: 250,
                                        child: SearchRestaurantFieldForUsers(
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

            const Padding(
              padding: EdgeInsets.only(top: 20, left: 15),
              child: Text(
                "Mets Populaires",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            PopularMealItem(
              searchMealQuery: searchMealQuery,
              press: () {},
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 15),
              child: Text(
                "Autres Mets",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            PopularMealItem(
              searchMealQuery: searchMealQuery,
              press: () {},
            ),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
          ],
        ),
      ),
    );
  }
}
