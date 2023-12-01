import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchMealField extends StatelessWidget {
  const SearchMealField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth * 0.66,
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 0))
            ]),
        child: TextField(
          onChanged: (value) {},
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Rechercher un repas",
              prefixIcon: const Icon(CupertinoIcons.search),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenWidth(9))),
        ));
  }
}