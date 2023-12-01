import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:http/http.dart' as http;

class RestaurantList {
  final getRestaurantUrl = AppUrl.httpBaseUrl;

  Future<List<Restaurant>> restaurants = getRestaurants();

  static Future<List<Restaurant>> getRestaurants() async {
    const restaurantUrl = 'https://apiv6.sevenservicesplus.com/api/menus';

    final response = await http.get(Uri.parse(restaurantUrl));

    const restaurantNoMenuUrl =
        'https://apiv6.sevenservicesplus.com/api/restaurants';

    final responseRestaurantNoMenu =
        await http.get(Uri.parse(restaurantNoMenuUrl));
    /* final body = jsonDecode(response.body) */

    List<Restaurant> restaurants = (jsonDecode(response.body)['data'] as List)
        .map((data) => Restaurant.fromJson(data))
        .toList();

    List<Restaurant> restaurantsNoMenus =
        (jsonDecode(responseRestaurantNoMenu.body)['data'] as List)
            .map((data) => Restaurant.fromJsonNoMenu(data))
            .toList();

    restaurantsNoMenus.forEach((restaurant2) {
      bool restaurantDejaPresent =
          restaurants.any((restaurant1) => restaurant1.id == restaurant2.id);
      if (!restaurantDejaPresent) {
        restaurants.add(restaurant2);
      }
    });

    Map<String, Restaurant> restaurantsByName = {};

    for (Restaurant restaurant in restaurants) {
      if (restaurantsByName.containsKey(restaurant.name!)) {
        restaurantsByName[restaurant.name!]!
            .menu!
            .repasList!
            .addAll(restaurant.menu!.repasList!);
      } else {
        restaurantsByName[restaurant.name!] = restaurant;
      }
    }

    List<Restaurant> restaurantsWithoutRedundancy =
        restaurantsByName.values.toList();

    return restaurantsWithoutRedundancy;

    /*  body["data"].map<Restaurant>((e) => Restaurant.fromJson(e)).toList(); */
  }

  static Future<Restaurant> getRestaurantById(String restaurantId) async {
    var client = http.Client();
    var getRestaurantByIdUrl =
        Uri.https(AppUrl.baseUrl, '/api/restaurants/$restaurantId');

    try {
      final response = await client.get(getRestaurantByIdUrl);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return restaurantFromJson(response.body);
      } else {
        // Gérer les erreurs si la requête échoue
        print(
            "Erreur lors de la récupération des détails du restaurant $restaurantId");
        return Restaurant(); // Retourner un objet vide ou gérer l'erreur selon votre besoin
      }
    } catch (e) {
      // Gérer les erreurs inattendues
      print("Erreur inattendue: $e");
      return Future.error(e.toString());
    }
  }
}
