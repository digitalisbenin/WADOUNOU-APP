import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/restaurant_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/single_restaurant_card.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/restaurant_body.dart';
import 'package:flutter/material.dart';

class PopularRestaurantWidget extends StatefulWidget {
  const PopularRestaurantWidget(
      {super.key, required this.searchQuery, required this.press});

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
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Restaurant> filteredRestaurants =
            (snapshot.data as List<Restaurant>?)?.where((restaurant) {
                  String restaurantName = restaurant.name!.toLowerCase();
                  return restaurantName
                      .contains(widget.searchQuery.toLowerCase());
                }).toList() ??
                [];

        return (!snapshot.hasData)
            ? const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text("Veuillez patienter un moment..."),
                  ],
                ),
              )
            : (filteredRestaurants.isEmpty)
                ? const Center(
                    child: Text(
                        "Le restauarant recherché n'existe pas; Veuillez réessayer..."),
                  )
                : CarouselSlider(
                    options: CarouselOptions(
                      height: SizeConfig.screenHeight *
                          0.25, // Hauteur de votre carousel
                      enableInfiniteScroll: true, // Faites défiler en boucle
                      initialPage: 0, // Page initiale
                      viewportFraction: 0.95,
                      enlargeCenterPage: true, // Agrandir la page au centre
                      autoPlay: true, // Lecture automatique
                      autoPlayInterval: const Duration(
                          seconds: 5), // Intervalle de lecture automatique
                    ),
                    items: /*snapshot.data*/
                        filteredRestaurants
                            .map<Widget>((restaurant) => SingleRestaurantCard(
                                  restaurants: restaurant,
                                  press: () {
                                    print(
                                        "Id du restaurant : ${restaurant.id}");
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return RestaurantBody(
                                          restaurant: restaurant);
                                    }));
                                    /* Navigator.pushNamed(
                                      context,
                                      RestaurantBody.routeName,
                                      arguments: RestaurantDetailArgument(
                                          restaurant: restaurant),
                                    ); */
                                  },
                                ))
                            .toList());
      },
    );
  }
}
