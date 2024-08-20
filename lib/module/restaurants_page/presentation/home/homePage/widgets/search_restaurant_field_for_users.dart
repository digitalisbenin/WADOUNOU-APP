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
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
            cursorColor: Colors.orange,
            decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusColor: Colors.orange,
                focusedBorder: InputBorder.none,
                hintText: "Rechercher un restaurant...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(CupertinoIcons.search, color: Colors.grey,),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(9))),
          )),
    );
  }
}