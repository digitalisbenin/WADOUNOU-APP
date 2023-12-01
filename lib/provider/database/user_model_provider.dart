import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String? userId;

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }
}
