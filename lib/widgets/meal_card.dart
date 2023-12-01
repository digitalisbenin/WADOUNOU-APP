import 'dart:ffi';

import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/cart_model.dart';
import 'package:digitalis_restaurant_app/core/model/repas.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/helpers/cart/cart_db_helper.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProductCard extends StatefulWidget {
  const SingleProductCard({
    super.key,
    required this.repas,
    required this.press,
  });

  final Repas repas;
  final GestureTapCallback press;

  @override
  State<SingleProductCard> createState() => _SingleProductCardState();
}

class _SingleProductCardState extends State<SingleProductCard> {
  CartDBHelper? cartDBHelper = CartDBHelper();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
   // final cart = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: GestureDetector(
        onTap: widget.press,
        child: Container(
          width: SizeConfig.screenWidth * 0.44,//170,
          height: SizeConfig.screenHeight * 0.28,//225,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      widget.repas.image_url.toString(),
                      height: SizeConfig.screenHeight * 0.15,
                    ),
                  ),
                ),
                Text(
                  widget.repas.name.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.repas.description.toString(),
                  style: const TextStyle(fontSize: 10),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.repas.prix.toString()} FCFA",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.favorite_border_outlined,
                      size: 22,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
