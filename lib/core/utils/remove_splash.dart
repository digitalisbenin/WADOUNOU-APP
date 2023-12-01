import 'package:flutter/material.dart';

class RemoveSplash extends StatelessWidget {
  final Widget child;

  const RemoveSplash({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: Container(
        child: child,
      ),
    );
  }
}
