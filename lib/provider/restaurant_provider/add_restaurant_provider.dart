import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/provider/auth_provider.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AddRestaurantProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  bool _status = false;

  String _response = '';
  String? _userId;

  bool get getStatus => _status;
  String get getResponse => _response;

  Future<void> profile() async {
    final token = await DatabaseProvider().getToken();
    //final userId = await DatabaseProvider().getUserId();
    var client = http.Client();
    var profileUrl = Uri.https(requestBaseUrl, '/api/profile');
    try {
      final response = await client.get(profileUrl, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData != null) {
          _userId = responseData['id'];
          print(_userId);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // Add restaurant methode

  void addRestaurant(
      {String? name,
      String? addresse,
      String? phone,
      String? description,
      String? imageUrl}) async {
    final token = await DatabaseProvider().getToken();

    await profile();

    print(token);
    _status = true;
    notifyListeners();

    var addRestaurantUrl =
        Uri.https(requestBaseUrl, '/api/restaurants');


    // String url = "$requestBaseUrl/register/";

    var client = http.Client();

    final body = {
      "name": name,
      "addrese": addresse,
      "phone": phone,
      "description": description,
      "image_url": imageUrl,
      "user_id": _userId,
    };
    print(body);
    print("id ::: $_userId");

    /*final profile = await client.get(profileUrl,
       *//* body: jsonEncode(body),*//* headers: {'Authorization': 'Bearer $token'});
    print('Profile Statut code  ${profile.statusCode}');*/

    final result = await client.post(addRestaurantUrl,
        body: jsonEncode(body), headers: {'Authorization': 'Bearer $token'});
    print(result.statusCode);

    if (result.statusCode == 200) {
      final res = result.body;
      print(res);
      _status = false;

      _response = jsonDecode(res)['message'];
      notifyListeners();
    } else {
      final res = result.body;
      print(res);
      notifyListeners();
    }

    /*if (profile.statusCode == 200) {
      final profileResponse = jsonDecode(profile.body);
      _userId = profileResponse['id'];
      print(profileResponse);
      print("id ::: $_userId");
      notifyListeners();
    } else {
      final profileResponse = jsonDecode(profile.body);
      print(profileResponse);
      notifyListeners();
    }*/
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
