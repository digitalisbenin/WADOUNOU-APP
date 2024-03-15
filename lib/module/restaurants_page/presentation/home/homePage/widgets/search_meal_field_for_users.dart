import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchMealFieldForUsers extends StatelessWidget {
  SearchMealFieldForUsers({super.key, required this.onSearchMeal, required this.searchMealController,});

  final Function(String) onSearchMeal;
  final TextEditingController searchMealController;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
          width: SizeConfig.screenWidth * 0.79,
          height: 45,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 0)
                )
              ]
          ),
          child: TextFormField(
            controller: searchMealController,
            onChanged: (value) {
              onSearchMeal(value);
            },
            cursorColor: Colors.orange,
            decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "Rechercher un repas",
                prefixIcon: const Icon(CupertinoIcons.search),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(9))),
          )),
    );
  }
}