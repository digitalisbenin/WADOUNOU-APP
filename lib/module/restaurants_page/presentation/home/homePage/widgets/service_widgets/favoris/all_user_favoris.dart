import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:flutter/material.dart';

class AllUserFavories extends StatefulWidget {
  const AllUserFavories({super.key});

  @override
  State<AllUserFavories> createState() => _AllUserFavoriesState();
}

class _AllUserFavoriesState extends State<AllUserFavories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kOnBoardingBackgroundColor,
        centerTitle: true,
        title: const Text('Mes Favoris', style: TextStyle(color: kWhite),),
      ),
      body: const Center(
        child: Text("Mes Favoris"),
      ),
    );
  }
}
