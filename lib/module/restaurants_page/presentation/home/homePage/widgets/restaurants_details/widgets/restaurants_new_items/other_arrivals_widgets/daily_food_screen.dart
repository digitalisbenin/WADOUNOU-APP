import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/restaurant_detail_arguments.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/other_arrivals_widgets/daily_single_food_card.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/other_arrivals_widgets/widgets/daily_food_details_page.dart';

import 'package:flutter/material.dart';

class DailyFood extends StatefulWidget {
  const DailyFood({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<DailyFood> createState() => _DailyFoodState();
}

class _DailyFoodState extends State<DailyFood> {
  @override
  Widget build(BuildContext context) {
    RestaurantDetailArgument? arguments =
        ModalRoute.of(context)?.settings.arguments as RestaurantDetailArgument?;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: widget.restaurant.menu == null
          ? Padding(
            padding: const EdgeInsets.only(left: 120.0),
            child: Text("Aucun Menus disponible"),
          )
          : Row(
              children: [
                //Product Single Card
                ...List.generate(
                    widget.restaurant.menu!.repasList!.length,
                    (index) => DailySingleFoodCard(
                          repas: widget.restaurant.menu!.repasList![index],
                          /* prix: widget.restaurant.menu!.prix.toString(), */
                          press: () {
                            Navigator.pushNamed(
                              context,
                              DailyFoodDetailPage.routeName,
                              arguments: ProductDetailArguments(
                                repas:
                                    widget.restaurant.menu!.repasList![index],
                                    restaurant: widget.restaurant,
                              ),
                            );
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailsPage()));
                          },
                          restaurantId: widget.restaurant.id ?? "",
                        )),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
    );
  }
}
