import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/repas.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/item_details_page.dart';
import 'package:digitalis_restaurant_app/widgets/meal_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class PopularMealItem extends StatefulWidget {
  const PopularMealItem({
    super.key,
    required this.searchMealQuery,
    required this.press,
  });

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
                CircularProgressIndicator(),
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
          ));
        }
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: (filteredMeals.isEmpty)
                ? const Center(
                    child: Text("Le repas recherché n'existe pas; Veuillez réessayer..."),
                  )
                : Row(
                    children: [
                      //Product Single Card
                      ...List.generate(
                          filteredMeals.length,
                          (index) => SingleProductCard(
                              repas: filteredMeals[index],
                              press: () {
                                Navigator.pushNamed(
                                    context, ItemDetailsPage.routeName,
                                    arguments: ProductDetailArguments(
                                        repas: filteredMeals[index]));
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailsPage()));
                              })),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
          );
        }
        return const Text(" ");
      },
      /*child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: [
            //Product Single Card
            ...List.generate(
                demoProduct.length,
                (index) => SingleProductCard(
                    product: demoProduct[index],
                    press: () {
                      Navigator.pushNamed(context, ItemDetailsPage.routeName,
                          arguments: ProductDetailArguments(
                              repas: ));
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailsPage()));
                    })),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),*/
    );
  }
}
