import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:http/http.dart' as http;

class RestaurantList {
  final getRestaurantUrl = AppUrl.httpBaseUrl;

  Future<List<Restaurant>> restaurants = getRestaurants();


  static Future<List<Restaurant>> getRestaurants() async {

    const restaurantUrl = 'https://apiv6.sevenservicesplus.com/api/restaurants';

    final response = await http.get(Uri.parse(restaurantUrl));

    final body = jsonDecode(response.body);

    return body['data'].map<Restaurant>((e) => Restaurant.fromJson(e)).toList();
  }

  Future<List<dynamic>>checkResto(String nameMenu) async{
  //Url vers l'API pour checker les menus
    const restaurantUrl = 'https://apiv6.sevenservicesplus.com/api/menus';

    final response = await http.get(Uri.parse(restaurantUrl));

      if(response.statusCode == 200){
      // Decodage du json récupéré 
      Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData.containsKey('data') && responseData['data'] is List) {
        List<dynamic> restaurantsData = responseData['data'];

        List<dynamic> restaurantNames = restaurantsData.map((restaurant) {
          if(restaurant.containsKey('restaurant') && restaurant['restaurant'] is Map)
          {
            var restoInfo = restaurant['restaurant'];
              if( restoInfo.containsKey('name') && restoInfo['name'] is String){
                return restoInfo['name'];
              }
          }
        
          return null;
      }).where((name) => name != null).toList();

        return restaurantNames;
      }
      }
      return [];
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
