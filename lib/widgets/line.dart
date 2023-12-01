import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final EdgeInsets? margin;
  Color? color;
  double height = 0.5;

  Line({Key? key, this.margin, this.color}) : super(key: key);

  Line.veryLight({Key? key, this.margin}) {
    color = Colors.grey[200];
  }

  Line.light({Key? key, this.margin}) {
    color = Colors.grey[300];
  }

  Line.medium({Key? key, this.margin}) {
    height = 1;
    color = Colors.grey[350];
  }

  Line.dark({Key? key, this.margin}) {
    height = 1;
    color = Colors.grey[400];
  }

  Line.veryDark({Key? key, this.margin}) {
    height = 1;
    color = Colors.grey[600];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      color: color ?? Colors.grey[200],
    );
  }
}
