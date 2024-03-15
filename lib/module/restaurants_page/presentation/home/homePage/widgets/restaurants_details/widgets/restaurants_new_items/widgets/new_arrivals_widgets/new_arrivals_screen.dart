import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/repas.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/item_details_page.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/widgets/new_arrivals_widgets/new_arrival_product_card.dart';
import 'package:digitalis_restaurant_app/widgets/meal_card.dart';
import 'package:flutter/material.dart';

class RestaurantsNewArrivalScreen extends StatelessWidget {
  const RestaurantsNewArrivalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Repas>>(
      future: RepasList.getRepas(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator(color: kPrimaryColor,);
        }
        if (snapshot.hasError) {
          return Text("Une erreur s'est produite lors du chargement des repas");
        }
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Row(
              children: [
                //Product Single Card
                ...List.generate(
                    snapshot.data.length,
                    (index) => SingleProductCard(
                        repas: snapshot.data[index],
                        press: () {
                          Navigator.pushNamed(
                            context,
                            ItemDetailsPage.routeName,
                            arguments: ProductDetailArguments(
                              repas: snapshot.data[index],
                              restaurant: snapshot.data[index],
                            ),
                          );
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailsPage()));
                        })),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        }
        return Text(" ");
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

    /*SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Row(
        children: [
          //Product Single Card
          ...List.generate(
              demoProduct.length,
                  (index) => NewArrivalSingleProductCard(
                  product: demoProduct[index],
                  press: () {
                    Navigator.pushNamed(context, ItemDetailsPage.routeName,
                        arguments: ProductDetailArguments(
                            product: demoProduct[index]));
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailsPage()));
                  })),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );*/
  }
}
