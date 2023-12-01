import 'package:flutter/material.dart';

class ColumnExpanded extends StatelessWidget {
  final Widget child;

  const ColumnExpanded({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: child)],
    );
  }
}
