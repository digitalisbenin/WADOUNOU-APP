import 'package:digitalis_restaurant_app/core/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_input_field.dart';

class AppDatePickerField extends StatelessWidget {
  final String title;
  final String hint;
  final String value;
  final String? errorText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  TextEditingController controller;
  final bool enabled;

  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;

  final Function(DateTime? selectedDate) onChanged;

  AppDatePickerField({
    Key? key,
    required this.title,
    this.hint = '',
    this.value = '',
    this.errorText = '',
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onChanged,
    required this.controller,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = DateTimeUtils.readableDate(initialDate);
    return BaseInputField(
        title: title,
        displayTitleArea: false,
        inputControl: TextFormField(
          validator: validator,
          autovalidateMode: autovalidateMode,
          focusNode: AlwaysDisabledFocusNode(),
          enabled: enabled,
          controller: controller,
          onTap: () async {
            var selectedDateTime = await _selectDate(Get.context!);
            onChanged(selectedDateTime);
            if (selectedDateTime != null) {
              controller.text = DateTimeUtils.readableDate(selectedDateTime);
            }
          },
          decoration: InputDecoration(
              errorText:
                  (errorText == "" || errorText == null) ? null : errorText,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              hintText: hint,
              suffixIcon: Icon(Icons.date_range, size: 24),
              isDense: true),
        ));
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate ?? currentDate,
        firstDate: firstDate ?? DateTime(2000),
        lastDate: lastDate ?? DateTime(2050));

    if (pickedDate == null) {
      if (initialDate != null) {
        return initialDate;
      } else {
        return null;
      }
    } else {
      return pickedDate;
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
