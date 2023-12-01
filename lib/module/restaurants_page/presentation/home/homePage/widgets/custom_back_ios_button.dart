import 'package:flutter/material.dart';

class CustomBackIosButton extends StatelessWidget {
  const CustomBackIosButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 0)
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios, size: 22,)),
        ),
      ),
    );
  }
}