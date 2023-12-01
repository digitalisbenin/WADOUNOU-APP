import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/repas.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/item_details_page.dart';
import 'package:digitalis_restaurant_app/widgets/meal_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularMealItem extends StatefulWidget {
  const PopularMealItem({
    Key? key,
    required this.searchMealQuery,
    required this.press,
    required this.searchQuery,
  }) : super(key: key);

  final String searchQuery;
  final String searchMealQuery;
  final VoidCallback press;

  @override
  State<PopularMealItem> createState() => _PopularMealItemState();
}

class _PopularMealItemState extends State<PopularMealItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Repas>>(
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
                CircularProgressIndicator(color: kPrimaryColor,),
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
                Text("Une erreur s'est produite lors du chargement des repas"),
              ],
            ),
          );
        }

        if (filteredMeals.isEmpty) {
          return const Center(
            child: Text(
              "Ce repas n'existe pas, veuillez réessayer...",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.01, vertical: SizeConfig.screenHeight * 0.004),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 0.7),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.02, vertical: SizeConfig.screenHeight * 0.02),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: SizeConfig.screenHeight * 0.26,
                          crossAxisCount: 2, // Nombre d'éléments par ligne
                          mainAxisSpacing:
                              SizeConfig.screenHeight * 0.02, // Espace vertical entre les éléments
                          crossAxisSpacing:
                              SizeConfig.screenHeight * 0.007, // Espace horizontal entre les éléments
                        ),
                        physics: const ScrollPhysics(),
                        itemCount: filteredMeals.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => SingleProductCard(
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
                        ),
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
    );
  }
}