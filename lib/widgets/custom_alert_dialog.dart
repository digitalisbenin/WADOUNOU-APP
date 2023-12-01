
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.text1,
    required this.text2,
    required this.press1,
    required this.press2,
    required this.color1,
    required this.color2,
  });

  final String title, text1, text2;
  final GestureTapCallback press1, press2;
  final Color color1, color2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(title),
      /* Text("Avez-vous un livreur ?") */
      actions: [
        TextButton(
            onPressed: press1,
            child: Text(
              text1,
              style: TextStyle(fontWeight: FontWeight.w400, color: color1),
            )),
        TextButton(
            onPressed: press2,
            child: Text(
              text2,
              style: TextStyle(fontWeight: FontWeight.bold, color: color2),
            ))
      ],
    );
  }
}
