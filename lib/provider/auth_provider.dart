import 'dart:convert';
import 'dart:io';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/module/account/account_view_page.dart';
import 'package:digitalis_restaurant_app/module/create_restaurant/create_restaurant_page.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:digitalis_restaurant_app/provider/database/user_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Base Url
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  String? _userId;

  String? _token;

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  Future<void> profile() async {
    _token = await DatabaseProvider().getToken();
    //final userId = await DatabaseProvider().getUserId();
    var client = http.Client();
    var profileUrl = Uri.https(requestBaseUrl, '/api/profile');
    try {
      final response = await client.get(profileUrl, headers: {'Authorization': 'Bearer $_token'});
      print("etape 1");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("response data : $responseData");
        print("response body : ${response.body}");
        if (responseData != null) {
          _userId = responseData['id'];
          print('id : $_userId');


        }
      }
    } catch (e) {
      print(e);
    }
  }

  void registerUser({
    required String name,
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var registerUrl = Uri.https(requestBaseUrl, '/api/auth/register');

    // String url = "$requestBaseUrl/register/";

    var client = http.Client();

    final body = {
      "name": name,
      "email": email,
      "password": password,
    };
    print(body);

    try {
      var response = await client.post(registerUrl,
          body: body);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        _isLoading = false;
        _resMessage = "Account created!";
        notifyListeners();
        PageNavigator(ctx: context)
            .nextPageOnly(page: const CreateRestaurant());
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();

      print(":::: $e");
    }
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {

   _token = await DatabaseProvider().getToken();

    await profile();

    print('user token :::: $_token');

    print('id utilisateur ::: $_userId');
    _isLoading = true;
    notifyListeners();

    var loginUrl = Uri.https(requestBaseUrl, '/api/auth/login');

    var client = http.Client();

    final body = {"email": email, "password": password};
    print('réponse du body ::: $body');
    print('id utilisateur ::: $_userId');

    try {
      var request = await client.post(
          loginUrl,
          body: body /* headers: {'Authorization': 'Bearer $token'}*/);
      print(request.body);

      if (request.statusCode == 200 /*  || request.statusCode == 201 */) {
        final res = jsonDecode(request.body);

        print(res);
        _isLoading = false;
        _resMessage = "Login successfull!";
        notifyListeners();



        ///Save users data and then navigate to homepage
         _token = res['access_token'];
        print(_token);
        _userId = res['id'];
        print('id user : $_userId');
        DatabaseProvider().saveToken(_token!);

        PageNavigator(ctx: context)
            .nextPageOnly(page: const AccountViewPage());
      } else {
        final res = json.decode(request.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
