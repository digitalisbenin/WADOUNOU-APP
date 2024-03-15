import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
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
  builder: (BuildContext context, AsyncSnapshot<List<Restaurant>> snapshot) {
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
          .where((restaurant) =>
              restaurant.name!.toLowerCase().contains(widget.searchQuery.toLowerCase()))
          .toList();

      return CarouselSlider(
        options: CarouselOptions(
          height: SizeConfig.screenHeight * 0.25,
          enableInfiniteScroll: filteredRestaurants.length > 1,
          initialPage: 0,
          viewportFraction: 0.95,
          enlargeCenterPage: true,
          autoPlay: filteredRestaurants.length > 1,
          autoPlayInterval: const Duration(seconds: 8),
        ),
        items: filteredRestaurants
            .map<Widget>((restaurant) => SingleRestaurantCard(
                  restaurants: restaurant,
                  press: () {
                    print("Id du restaurant : ${restaurant.id}");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return RestaurantBody(restaurant: restaurant);
                    }));
                  },
                ))
            .toList(),
      );
    }
  },
);

    
    /* FutureBuilder<List<Restaurant>>(
      future: RestaurantList.getRestaurants(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Restaurant> filteredRestaurants =
            (snapshot.data as List<Restaurant>?)?.where((restaurant) {
                  String restaurantName = restaurant.name!.toLowerCase();
                  return restaurantName
                      .contains(widget.searchQuery.toLowerCase());
                }).toList() ??
                [];

        return (snapshot.connectionState != ConnectionState.done)
            ? const Center(
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
              )
            : (filteredRestaurants.isEmpty)
                ? Padding(
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
                          "Aucunes données n'est présent sur les restaurants",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                : CarouselSlider(
                    options: CarouselOptions(
                      height: SizeConfig.screenHeight *
                          0.25, // Hauteur de votre carousel
                      enableInfiniteScroll: filteredRestaurants.length >
                          1, // Faites défiler en boucle
                      initialPage: 0, // Page initiale
                      viewportFraction: 0.95,
                      enlargeCenterPage: true, // Agrandir la page au centre
                      autoPlay:
                          filteredRestaurants.length > 1, // Lecture automatique
                      autoPlayInterval: const Duration(
                          seconds: 8), // Intervalle de lecture automatique
                    ),
                    items: filteredRestaurants
                        .map<Widget>((restaurant) => SingleRestaurantCard(
                              restaurants: restaurant,
                              press: () {
                                print("Id du restaurant : ${restaurant.id}");
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return RestaurantBody(restaurant: restaurant);
                                }));
                              },
                            ))
                        .toList());
      },
    ); */
  }
}
