import 'package:digitalis_restaurant_app/core/utils/focus_utils.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color buttonColor;
  final Color textColor;
  final OutlinedBorder? shape;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonColor = kcPrimaryColor,
    this.textColor = kcWhiteColor,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          elevation: 2,
          padding: EdgeInsets.all(16),
          shape: shape,
        ),
        onPressed: onPressed != null
            ? () {
                FocusUtils.unfocus();
                onPressed!();
              }
            : null,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
            fontWeight: FontWeight.normal,
          ),
        ));
  }
}
