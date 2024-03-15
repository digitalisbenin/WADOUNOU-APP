import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/repas.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/cart/cart_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/item_details_page.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/all_meals/widgets/single_all_meals_card.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/search_meal_field_for_users.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllMealsScreenBody extends StatefulWidget {
  const AllMealsScreenBody({
    Key? key,
    required this.searchQuery,
    required this.searchMealQuery,
    required this.press,
  });

  final String searchQuery;
  final String searchMealQuery;
  final VoidCallback press;

  @override
  State<AllMealsScreenBody> createState() => _AllMealsScreenBodyState();
}

class _AllMealsScreenBodyState extends State<AllMealsScreenBody> {
  String searchMealQuery = '';

  late TextEditingController _searchMealController;

  @override
  void initState() {
    super.initState();
    _searchMealController = TextEditingController();
  }

  void updateMealSearch(String query_meal) {
    setState(() {
      searchMealQuery = query_meal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repas"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            SearchMealFieldForUsers(
              onSearchMeal: updateMealSearch,
              searchMealController: _searchMealController,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            FutureBuilder<List<Repas>>(
              future: RepasList.getRepas(),
              builder: (context, AsyncSnapshot snapshot) {
                List<Repas> filteredMeals =
                    (snapshot.data as List<Repas>?)?.where((repas) {
                  String repasName = repas.name!.toLowerCase();
                  return repasName
                      .contains(widget.searchMealQuery.toLowerCase());
                }).toList() ??
                        [];

                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text("Veuillez Patienter un moment..."),
                      ],
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "Une erreur s'est produite lors du chargement des repas"),
                      ],
                    ),
                  );
                }

                if (filteredMeals.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: SizeConfig.screenHeight * 0.18,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kWhite,
                          border: Border.all(color: Colors.black),
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                        child: Text(
                          "Aucunes données n'est présent sur les plats...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.01,
                              vertical: SizeConfig.screenHeight * 0.004),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 0.7),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth * 0.02,
                                  vertical: SizeConfig.screenHeight * 0.02),
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent:
                                      SizeConfig.screenHeight * 0.34,
                                  crossAxisCount:
                                      2, // Nombre d'éléments par ligne
                                  mainAxisSpacing: SizeConfig.screenHeight *
                                      0.02, // Espace vertical entre les éléments
                                  crossAxisSpacing: SizeConfig.screenHeight *
                                      0.007, // Espace horizontal entre les éléments
                                ),
                                physics: const ScrollPhysics(),
                                itemCount: filteredMeals.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if (searchMealQuery.isEmpty ||
                                      filteredMeals[index].name!
                                          .toLowerCase()
                                          .contains(searchMealQuery
                                              .toLowerCase())) {
                                    return SingleAllMealCard(
                                      repas: filteredMeals[index],
                                      press: () {
                                        Navigator.pushNamed(
                                          context,
                                          ItemDetailsPage.routeName,
                                          arguments: ProductDetailArguments(
                                            repas: filteredMeals[index],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    // Si le nom du repas ne correspond pas à la recherche, retournez un conteneur vide.
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.08,
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
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
      ),
    );
  }
}
