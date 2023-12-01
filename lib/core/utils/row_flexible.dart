import 'package:flutter/material.dart';

class RowFlexible extends StatelessWidget {
  final Widget child;
  const RowFlexible({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Flexible(child: child)],
    );
  }
}
