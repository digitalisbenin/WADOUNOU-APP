// role_provider.dart

import 'package:digitalis_restaurant_app/core/model/Role/role_model.dart';
import 'package:digitalis_restaurant_app/core/model/Role/role_model.dart';
import 'package:digitalis_restaurant_app/core/model/Role/role_model.dart';
import 'package:flutter/material.dart';

class RoleProvider extends ChangeNotifier {
  RoleModel? _selectedRole;

  RoleModel? get selectedRole => _selectedRole;

  void setSelectedRole(RoleModel roleModel) {
    _selectedRole = roleModel;
    notifyListeners();
  }
}
