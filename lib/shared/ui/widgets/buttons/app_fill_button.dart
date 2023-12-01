import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_color_constants.dart';

class AppFilledButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color color;
  final Color txtColor;
  final bool shouldShowIcon;
  final IconData icon;

  const AppFilledButton({
    this.onPressed,
    required this.text,
    this.color = kPrimaryColor,
    this.txtColor = kcWhiteColor,
    this.shouldShowIcon = false,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: btnForeground(),
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: color)))));
  }

  Widget btnForeground() {
    if (shouldShowIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          horizontalSpaceSmall,
          AppText.body(
            text,
            color: txtColor,
          ),
        ],
      );
    } else {
      return AppText.body(
        text,
        color: txtColor,
      );
    }
  }
}
