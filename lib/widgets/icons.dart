import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final Color? color;
  final Color? iconColor;
  final IconData iconData;
  final Function()? onPressed;
  final IconType type;
  final double iconSize;

  const IconWidget(
      {Key? key,
      required this.iconData,
      this.color = Colors.white,
      this.iconColor = kcDarkGreyColor,
      this.onPressed,
      this.type = IconType.iconButton,
      this.iconSize = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return IgnorePointer(child: _buildIcon());
    }

    return _buildIcon();
  }

  Widget _buildIcon() {
    switch (type) {
      case IconType.onlyIcon:
        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: onPressed ?? () {},
          child: Icon(
            iconData,
            size: iconSize,
            color: iconColor,
          ),
        );
      case IconType.iconButton:
        return IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              iconData,
              color: iconColor,
              size: iconSize,
            ),
            onPressed: onPressed ?? () {});
      case IconType.circular:
        return MaterialButton(
          onPressed: onPressed ?? () {},
          color: color,
          textColor: iconColor,
          minWidth: 0,
          height: 0,
          padding: EdgeInsets.all(16),
          shape: CircleBorder(),
          child: Icon(
            iconData,
            size: iconSize,
          ),
        );
    }
  }
}

enum IconType { onlyIcon, iconButton, circular }
