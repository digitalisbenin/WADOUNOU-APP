
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

      if (response.statusCode == 200) {
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
