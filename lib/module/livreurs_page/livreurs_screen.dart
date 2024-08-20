import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/livreurs_page/livreur_adding_info_page.dart';
import 'package:flutter/material.dart';

class LivreurScreen extends StatefulWidget {
  const LivreurScreen({super.key});

  static String routeName = '/livreur_page';

  @override
  State<LivreurScreen> createState() => _LivreurScreenState();
}

class _LivreurScreenState extends State<LivreurScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: kWhite),
        title: const Text(
          'Validation',
          style: TextStyle(color: kWhite),
        ),
        centerTitle: true,
      ),
      body: const LivreurAddingInfoPage(),
    );
  }
}
