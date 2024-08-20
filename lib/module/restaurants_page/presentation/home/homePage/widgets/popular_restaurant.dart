import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/restaurant_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/single_restaurant_card.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/restaurant_body.dart';
import 'package:flutter/material.dart';

class PopularRestaurantWidget extends StatefulWidget {
  const PopularRestaurantWidget(
      {Key? key, required this.searchQuery, required this.press})
      : super(key: key);

  final String searchQuery;
  final VoidCallback press;

  @override
  State<PopularRestaurantWidget> createState() =>
      _PopularRestaurantWidgetState();
}

class _PopularRestaurantWidgetState extends State<PopularRestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: RestaurantList.getRestaurants(),
      builder: (context, snapshot) {
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
                Text("Veuillez patienter un moment..."),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Erreur lors du chargement des restaurants",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: SizeConfig.screenHeight * 0.18,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kWhite,
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: const Center(
                child: Text(
                  "Aucunes données n'est présent sur les restaurants",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        } else {
          List<Restaurant> filteredRestaurants = snapshot.data!
              .where((restaurant) => restaurant.name
                  .toLowerCase()
                  .contains(widget.searchQuery.toLowerCase()))
              .toList();

          return SizedBox(
            height: MediaQuery.of(context).size.height *
                0.7, // Ajustez la hauteur selon vos besoins
            child: ListView.builder(
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) => SingleRestaurantCard(
                press: () {
                  print('ID du Restaurant : ${filteredRestaurants[index].id}');
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return RestaurantBody(
                        restaurant: filteredRestaurants[index]);
                  }));
                },
                restaurants: filteredRestaurants[index],
              ),
            ),
          );
        }
      },
    );
  }
}
