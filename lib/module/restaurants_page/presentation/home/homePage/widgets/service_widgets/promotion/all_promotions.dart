import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:flutter/material.dart';

class AllPromotionsScreen extends StatefulWidget {
  const AllPromotionsScreen({super.key});

  @override
  State<AllPromotionsScreen> createState() => _AllPromotionsScreenState();
}

class _AllPromotionsScreenState extends State<AllPromotionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kOnBoardingBackgroundColor,
        title: const Text('En Promotion', style: TextStyle(color: kWhite),),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('En promotions'),
      ),
    );
  }
}
