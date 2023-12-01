import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class SingleRestaurantCard extends StatefulWidget {
  SingleRestaurantCard({
    Key? key,
    required this.press,
    required this.restaurants,
  }) : super(key: key);

  final Restaurant restaurants;
  final GestureTapCallback press;

  @override
  _SingleRestaurantCardState createState() =>
      _SingleRestaurantCardState();
}

class _SingleRestaurantCardState
    extends State<SingleRestaurantCard> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: widget.press,
        child:  Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: widget.press,
                child: Container(
                  alignment: Alignment.center,
                  child:Image.network(
                    widget.restaurants.image_url.toString(),
                    height: SizeConfig.screenHeight * 0.5,
                    width: SizeConfig.screenWidth * 0.4,
                  ),
                ),
              ),
               SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                (widget.restaurants.name.toString()),

                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text("Adresse : ", style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.016,
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),),
                        Text(
                          (widget.restaurants.adresse.toString()),
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: SizeConfig.screenHeight * 0.016,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Spécialité : ", style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.016,
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),),
                        Text(
                          (widget.restaurants.specilite.toString()),
                          // widget.restaurant.specilite.toString(),
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: SizeConfig.screenHeight * 0.016,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Heure d'ouverture : ", style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.016,
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),),
                        Text(
                          "${widget.restaurants.heure_douverture}",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: SizeConfig.screenHeight * 0.016,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Heure de fermerture : ", style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.016,
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),),
                        Text(
                          "${widget.restaurants.heure_fermeture}",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: SizeConfig.screenHeight * 0.016,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Contacts : ", style: TextStyle(
                          fontSize: SizeConfig.screenHeight * 0.016,
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),),
                        Text(
                         widget.restaurants.phone.toString(),
                          //widget.restaurant.phone.toString(),
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: SizeConfig.screenHeight * 0.016,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


