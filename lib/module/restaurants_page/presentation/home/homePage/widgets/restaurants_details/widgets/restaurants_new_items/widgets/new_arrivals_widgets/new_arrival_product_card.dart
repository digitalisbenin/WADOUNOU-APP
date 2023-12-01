import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/repas.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class NewArrivalSingleProductCard extends StatefulWidget {
  const NewArrivalSingleProductCard({super.key,required this.press, required this.repas});

  final Repas repas;
  final GestureTapCallback press;

  @override
  State<NewArrivalSingleProductCard> createState() => _NewArrivalSingleProductCardState();
}

class _NewArrivalSingleProductCardState extends State<NewArrivalSingleProductCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
                    InkWell(
                      
                      // ... Le reste de votre code
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 7),
                            child: Icon(
                              Icons.shopping_cart_checkout,
                              color: kPrimaryColor,
                              size: 20,
                            ),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
