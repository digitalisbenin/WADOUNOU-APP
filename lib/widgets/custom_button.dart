import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:flutter/material.dart';

Widget customButton ({
    VoidCallback? tap,
    bool? status = false,
    String? text = 'Sauvegarder',
    BuildContext? context
  }) {
  return GestureDetector(
    onTap: status == true ? null : tap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal : 15.0),
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: status == false ? kPrimaryColor : Colors.grey,
            borderRadius: BorderRadius.circular(8)),
        width: MediaQuery.of(context!).size.width,
        child: Text(
          status == false ? text! : 'Veuillez Patientez...',
          style: const TextStyle(color: kWhite, fontSize: 18),
        ),
      ),
    ),
  );
}
