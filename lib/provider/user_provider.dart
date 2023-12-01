import 'package:digitalis_restaurant_app/core/model/Users/Roles.dart';
import 'package:digitalis_restaurant_app/core/model/Users/User.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late Users currentUser;

  setUserBasicInfos(Users user) {
    currentUser.name = user.name;
    currentUser.email = user.email;
    currentUser.password = user.password;
    notifyListeners();
  }

  setAllUserInfo(Users user) {
    currentUser.name = user.name;
    currentUser.email = user.email;
    currentUser.password = user.password;
    notifyListeners();
  }
}