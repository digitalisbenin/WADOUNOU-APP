import 'package:digitalis_restaurant_app/core/constants/app_color_constants.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:flutter/material.dart';

void showMessage({String? message, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(
        message!,
        style: TextStyle(color: kWhite),
      ),
      backgroundColor: kcStatusConfirmed));
}