import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/restaurant_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/restaurant_body.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/single_restaurant_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewestItemWidget extends StatefulWidget {
  const NewestItemWidget({
    super.key,
    required this.restaurants,
  });

  final RestaurantList restaurants;

  @override
  State<NewestItemWidget> createState() => _NewestItemWidgetState();
}

class _NewestItemWidgetState extends State<NewestItemWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: RestaurantList.getRestaurants(),
      builder:  (context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState!=ConnectionState.done){
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
        if(snapshot.hasError){
          return const Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Une erreur s'est produite lors du chargement des restaurants"),
            ],
          ));
        }
        if(snapshot.hasData){
        return  SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              children: [
                ...List.generate(
                    snapshot.data.length,
                        (index) => Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: SingleRestaurantCard(
                          restaurants: snapshot.data[index],
                          press: () {
                            Navigator.pushNamed(
                                context, RestaurantBody.routeName,
                                arguments: RestaurantDetailArgument(
                                    restaurant:
                                    snapshot.data[index]));
                          }),
                    )),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );}
        return const Text("...");
      },
    );
  }
}
