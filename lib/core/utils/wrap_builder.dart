import 'package:flutter/material.dart';

class WrapBuilder extends StatelessWidget {
  final Axis direction;
  final int itemCount;
  final double spacing;
  final double runningSpacing;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final ScrollController? scrollController;

  const WrapBuilder(
      {Key? key,
      this.direction = Axis.vertical,
      required this.itemCount,
      required this.itemBuilder,
      this.spacing = 4.0,
      this.runningSpacing = 4.0,
      this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        controller: scrollController ?? ScrollController(),
        scrollDirection: direction,
        child: Wrap(
          direction: direction,
          spacing: spacing,
          runSpacing: runningSpacing,
          children: [...items(context)],
        ),
      ),
    );
  }

  List<Widget> items(BuildContext context) {
    var list = <Widget>[];
    for (int i = 0; i < itemCount; i++) {
      list.add(itemBuilder(context, i));
    }
    return list;
  }
}
