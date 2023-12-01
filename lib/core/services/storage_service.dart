import 'package:digitalis_restaurant_app/core/constants/api_constant_link.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  SharedPreferences? _preferences;
  static final StorageService _instance = StorageService._internal();
  factory StorageService () => _instance;

  StorageService._internal();

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  setToken(String value) {
    _preferences!.setString(TOKEN_KEY, value);
  }

  String getToken() {
  if (_preferences != null) {
    return _preferences!.getString(TOKEN_KEY) ?? "";
  } else {
    return ""; // Ou une autre valeur par défaut
  }
}


  removeToken() {
    _preferences!.remove(TOKEN_KEY);
  }

  setUserId(int value) {
    _preferences!.setInt(USER_ID_KEY, value);
  }

  int getUserId() {
    return _preferences!.getInt(USER_ID_KEY) ?? 0;
  }

  setTokenExpiresAt(String value) {
    _preferences!.setString(TOKEN_EXPIRES_AT_KEY, value);
  }

  String getTokenExpiresAt() {
    return _preferences!.getString(TOKEN_EXPIRES_AT_KEY) ?? "";
  }

  setDeviceToken(String value) {
    _preferences!.setString(DEVICE_TOKEN, value);
  }

  setSubscriptionStatus(bool value) {
    _preferences!.setBool(SUBSCRIPTION_STATUS, value);
  }

  bool getSubscriptionStatus() {
    return _preferences!.getBool(SUBSCRIPTION_STATUS) ?? false;
  }
}