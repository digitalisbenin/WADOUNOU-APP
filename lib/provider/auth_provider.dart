import 'dart:convert';
import 'dart:io';

import 'package:digitalis_restaurant_app/core/constants/url.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/module/account/account_view_page.dart';
import 'package:digitalis_restaurant_app/module/create_restaurant/create_restaurant_page.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/module/screens/login/login_page.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:digitalis_restaurant_app/provider/database/user_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier {
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

  void registerUser({
    required String name,
    required String email,
    required String password,
    required String role_id,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var registerUrl = Uri.https(requestBaseUrl, '/api/auth/register');

    // String url = "$requestBaseUrl/register/";

    var client = http.Client();

    final body = {
      "role_id": role_id,
      "name": name,
      "email": email,
      "password": password,
    };
    print(body);

    try {
      var response = await client.post(registerUrl, body: body);
      print(response.statusCode);
      print(response.body);
         final res = jsonDecode(response.body);
          print("res $res");
      if (res['success'] == false && 
             res['message'] == 'Validation errors') {
    // Debugging additionnel
    print("Validation error détectée.");
    print("Email error: ${res['data']?['email']}");

    // Erreur de validation (email déjà utilisé)
    _resMessage =  'L\'email est déjà en cours d\'utilisation';
    _isLoading = false;
    notifyListeners();
      
      
      } else if (response.statusCode == 200 || response.statusCode == 201) {
       
        _isLoading = false;

        _resMessage = "Compte créé avec succès!";
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());

        }
       else {
        final res = jsonDecode(response.body);

        _resMessage = res['message'];

        print("res $res");
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet disponible";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Rééssayez encore";
      print("reponse ::::::: $e");
      notifyListeners();

      print(":::: $e");
    }
  }

  Future<void> usersProfile(String? token) async {
    //final userId = await DatabaseProvider().getUserId();
    print("le token ::::: $token");
    var client = http.Client();
    var profileUrl = Uri.https(requestBaseUrl, '/api/profile');
    try {
      final response = await client
          .get(profileUrl, headers: {'Authorization': 'Bearer $token'});
      debugPrint("etape 1");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        debugPrint("response data : $responseData");
        debugPrint("response body : ${response.body}");
        if (responseData != null) {
          _userId = responseData['id'];
          userData.write('userName', responseData['name']);
          userData.write('userMail', responseData['email']);
          userData.write('userPhone', responseData['phone']);
          userData.write('userRoleId', responseData['role_id']);
          userData.write('userId', _userId);
          userData.write('token', token);
          debugPrint('id : $_userId');
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var loginUrl = Uri.https(requestBaseUrl, '/api/auth/login');

    var client = http.Client();

    final body = {"email": email, "password": password};
    debugPrint('réponse du body ::: $body');

    try {
      var request = await client.post(loginUrl, body: body);
      debugPrint(request.body.toString());

      if (request.statusCode == 200 || request.statusCode == 201) {
        final Map<String, dynamic> res = jsonDecode(request.body);

        _token = res['access_token'] as String?;
        userData.write('token', _token);
        debugPrint('token utilisateur ::: $_token');

        await usersProfile(_token!);

        debugPrint('user token :::: $_token');

        // Stocker le token et le role_id
        final roleId = GetStorage()
            .read("userRoleId"); // Suppose que votre API retourne le `role_id`

        _isLoading = false;
        _resMessage = "Connexion réussie";
        notifyListeners();

        print("object ::::::::::::: $roleId");

        void storeRoleId(String roleId) {
          GetStorage().write('role_id', roleId);
          print(
              'Stored role_id in GetStorage: $roleId'); // Pour vérifier l'écriture
        }

        if (_token != null) {
          DatabaseProvider().saveToken(_token!);
        }

        if (roleId != null) {
          storeRoleId(roleId); // Stocker le `role_id`
        }

        print('Utilisateur connecté. Role ID: $roleId'); // Pour déboguer

        // Naviguer vers la page d'accueil, en passant le `role_id`
        Navigator.pushNamed(context!, '/home', arguments: {'role_id': roleId});
      } else {
        final res = jsonDecode(request.body);
        _resMessage = res['message'];
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Connexion internet indisponible";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Erreur lors de la connexion. Veuillez réessayer";
      notifyListeners();
      print("Erreur: $e");
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
