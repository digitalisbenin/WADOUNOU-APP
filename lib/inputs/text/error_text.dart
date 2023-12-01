import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String? errorText;
  final Color? textColor;

  const ErrorText(this.errorText, {Key? key, this.textColor = kcErrorColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        (errorText != null && errorText != '')
            ? const SizedBox(
                height: 8,
              )
            : Container(),
        (errorText != null && errorText != '')
            ? Text(
                '⚠ $errorText',
                style: TextStyle(color: textColor),
              )
            : Container(),
      ],
    );
  }
}
