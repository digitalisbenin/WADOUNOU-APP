import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key, required this.text, required this.svgPicture, required this.press,
  });

  final String text;
  final Widget svgPicture;
  final Color iconColor  = kPrimaryColor;
  final double iconSize = 22;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: svgPicture,
      title: Text(text, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
      onTap: press,
    );
  }
}