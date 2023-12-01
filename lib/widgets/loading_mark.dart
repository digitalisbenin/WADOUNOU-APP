import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:flutter/material.dart';

class LoadingMark extends StatelessWidget {
  const LoadingMark({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CircularProgressIndicator(
            color: kPrimaryColor,
            
          ),
        ],
      ),
    );
  }
}