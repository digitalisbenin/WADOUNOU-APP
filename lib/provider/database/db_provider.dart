
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/module/screens/login/login_page.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/landing/presentation/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  String _token = "";

  String _userId = "";

  String get token => _token;

  String get userId => _userId;

  void saveToken(String token) async {
    SharedPreferences value = await _preferences;
    value.setString('token', token);
  }

  void saveUserId(String id) async {
    SharedPreferences value = await _preferences;
    value.setString('id', id);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _preferences;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserId() async {
    SharedPreferences value = await _preferences;

    if (value.containsKey('id')) {
      String data = value.getString('id')!;
      _userId = data;
      notifyListeners();
      return data;
    } else {
      _userId = '';
      notifyListeners();
      return '';
    }
  }


  void logOut(BuildContext context) async {
    final value = await _preferences;

    value.clear();

    PageNavigator(ctx: context).nextPageOnly(page: const LandingScreen());
  }
}