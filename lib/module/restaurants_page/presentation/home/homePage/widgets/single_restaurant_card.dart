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
  _SingleRestaurantCardState createState() => _SingleRestaurantCardState();
}

class _SingleRestaurantCardState extends State<SingleRestaurantCard> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.01),
      child: GestureDetector(
        onTap: widget.press,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 5.0, right: 5.0),
                      child: Container(
                        height: SizeConfig.screenHeight * 0.25,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.restaurants.imageUrl.toString()),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "${widget.restaurants.name.toString()} / ${widget.restaurants.specialite.toString()}",
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.005,
                              ),
                              Center(
                                child: Text(
                                    '${widget.restaurants.adresse.toString()} / ${widget.restaurants.heure_douverture} - ${widget.restaurants.heure_fermeture}'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
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
