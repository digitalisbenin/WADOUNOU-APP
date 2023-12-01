import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/card/app_card.dart';
import 'package:flutter/material.dart';

class AppSearchTextField extends StatelessWidget {
  final String hintText;
  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final AutovalidateMode autovalidateMode;
  final Function()? onClearPressed;

  const AppSearchTextField({
    Key? key,
    this.hintText = 'Search...',
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.textInputAction = TextInputAction.go,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onClearPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppCard(
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autovalidateMode: autovalidateMode,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              hintText: hintText,
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: onClearPressed,
                icon: Icon(
                  Icons.close,
                  size: 24,
                  color: kcDarkGreyColor,
                ),
              ),
              border: InputBorder.none,
              isDense: true),
        ),
      ),
    );
  }
}
