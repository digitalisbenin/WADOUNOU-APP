import 'package:flutter/material.dart';

class FocusUtils {
  static void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
