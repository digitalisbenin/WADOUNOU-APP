import 'dart:convert';
import 'dart:io';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/routing/routes.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ModifyUserProfile extends ChangeNotifier {
  /// Le stockage de get
  final userData = GetStorage();

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

  void updateUserInfo({
    required String username,
    required String userEmail,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    _userId = GetStorage().read('userId');
    _token = GetStorage().read('token');

    var updateUrl = Uri.https(requestBaseUrl, 'api/users/$_userId');

    var client = http.Client();

    final body = {"name": username, "email": userEmail};
    print("Voici le body : $body");

    try {
      var response = await client.put(updateUrl,
          body: body, headers: {'Authorization': 'Bearer $_token'});
      print("Voici le statut code : ${response.statusCode}");
      print("Voici la réponse : ${response.body}");

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        _isLoading = false;
        _resMessage = "Informations modifiées avec succès!";

        PageNavigator(ctx: context).nextPageOnly(page: const HomeScreen());

        notifyListeners();
      } else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];
        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Rééssayez encore";
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
