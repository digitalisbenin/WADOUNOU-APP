import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class AppCheckBox extends StatelessWidget {
  final Function(bool? value) onChanged;
  final String? text;
  final bool value;

  const AppCheckBox(
      {Key? key,
      required this.onChanged,
      required this.text,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(true);
      },
      child: Row(
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            value: value,
            onChanged: (bool? value) {
              onChanged(value);
            },
          ),
          horizontalSpaceSmall,
          AppText.headingFour(text)
        ],
      ),
    );
  }
}
