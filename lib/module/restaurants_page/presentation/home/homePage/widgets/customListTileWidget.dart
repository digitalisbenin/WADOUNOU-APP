import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key, required this.text, required this.iconData, required this.press,
  });

  final String text;
  final IconData iconData;
  final Color iconColor  = kPrimaryColor;
  final double iconSize = 22;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData, color: iconColor, size: iconSize,),
      title: Text(text, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
      onTap: press,
    );
  }
}