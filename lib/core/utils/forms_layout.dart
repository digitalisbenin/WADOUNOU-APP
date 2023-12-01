import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:flutter/material.dart';

class FormsLayout extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const FormsLayout({Key? key, this.maxWidth = 600, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sw = screenWidth(context);
    var mw = maxWidth;
    if (sw > mw) {
      return Center(child: SizedBox(width: mw, child: child));
    }

    return child;
  }
}
