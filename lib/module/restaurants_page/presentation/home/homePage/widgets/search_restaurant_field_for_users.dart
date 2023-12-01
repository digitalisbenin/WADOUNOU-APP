import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchRestaurantFieldForUsers extends StatelessWidget {
  SearchRestaurantFieldForUsers({
    super.key, required this.onSearch, required this.searchController,
  });

  final Function(String) onSearch;
  final TextEditingController searchController;

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
            controller: searchController,
            onChanged: (value) {
              onSearch(value);
            },
            decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "Rechercher un restaurant",
                prefixIcon: const Icon(CupertinoIcons.search),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(9))),
          )),
    );
  }
}