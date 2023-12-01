import 'package:flutter/foundation.dart';
import 'dart:async';

class DebouncerUtil {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DebouncerUtil({this.milliseconds = 2000});

  run(VoidCallback? action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action!);
  }
}
