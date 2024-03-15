import 'dart:convert';
import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:http/http.dart' as http;

class GetRestaurant {
  final requestBaseUrl = AppUrl.baseUrl;

  Future<List<Restaurant>> getRestaurants() async {
    var client = http.Client();
    var restaurantUrl = Uri.https(requestBaseUrl, '/api/restaurants');

    try {
      final response = await client.get(restaurantUrl);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData != null && responseData['data'] != null) {
          List<dynamic> restaurantsData = responseData['data'];
          List<Restaurant> restaurantsList = restaurantsData
              .map((restaurant) => Restaurant.fromJson(restaurant))
              .toList();
          return restaurantsList;
        } else {
          return [];
        }
      } else {
        print('Failed to load restaurants, status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching restaurants: $e');
      return [];
    } finally {
      client.close();
    }
  }
}


/* 
import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:http/http.dart' as http;

class GetRestaurant {
  final requestBaseUrl = AppUrl.baseUrl;

  String? _restaurantId;

  Future<void> restaurant() async {
    var client = http.Client();
    var oneRestaurantUrl = Uri.https(requestBaseUrl, '/api/restaurants');
    try {
      final response = await client.get(oneRestaurantUrl);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData != null) {
          _restaurantId = responseData['id'];
          print(_restaurantId);
        }
      }
    } catch (e) {
      print(e);
    }
  }


  Future<Restaurant> getRestaurant() async {
    //_token = await DatabaseProvider().getToken();

    var client = http.Client();

    var getRestaurantUrl = Uri.https(requestBaseUrl, '/api/restaurants');

    await restaurant();

    try {
      final request = await client.get(getRestaurantUrl);

      print(request.statusCode);

      if (request.statusCode == 200) {
        print(request.body);

        if (jsonDecode(request.body) == null) {
          return Restaurant();
        } else {
          final restaurantModel = restaurantFromJson(request.body);
          return restaurantModel;
        }

        } else {
          print(request.body);

          return Restaurant();
        }
      } catch (e) {
      print(e);
      return Future.error(e.toString());
    }
  }
}
 */