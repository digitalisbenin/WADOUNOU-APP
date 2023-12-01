import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Menu.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class DailySingleFoodCard extends StatefulWidget {
  const DailySingleFoodCard({
    Key? key,
    required this.repas,
    required this.press,
    required this.restaurantId,
  }) : super(key: key);

  final Repas repas;
  final GestureTapCallback press;
  final String restaurantId;

  @override
  State<DailySingleFoodCard> createState() => _DailySingleFoodCardState();
}

class _DailySingleFoodCardState extends State<DailySingleFoodCard> {
  @override
  Widget build(BuildContext context) {
    Repas repas = widget.repas;

    return SizedBox(
      width: SizeConfig.screenWidth * 0.44,
      height: SizeConfig.screenHeight * 0.28,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: GestureDetector(
          onTap: widget.press,
          child: Container(
            width: SizeConfig.screenWidth * 0.44,
            height: SizeConfig.screenHeight * 0.28,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
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
                        repas.image_url.toString(),
                        height: SizeConfig.screenHeight * 0.15,
                      ),
                    ),
                  ),
                  Text(
                    repas.name.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    repas.description.toString(),
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${repas.prix.toString()} FCFA",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.favorite_border_outlined,
                        size: 22,
                        color: kPrimaryColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
