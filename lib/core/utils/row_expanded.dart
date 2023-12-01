import 'package:flutter/material.dart';

class RowExpanded extends StatelessWidget {
  final Widget child;

  const RowExpanded({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Expanded(child: child)],
    );
  }
}
