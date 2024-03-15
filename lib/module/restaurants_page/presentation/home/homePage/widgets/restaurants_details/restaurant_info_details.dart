import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RestaurantInfoDetails extends StatelessWidget {
  RestaurantInfoDetails({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kBackground,
      statusBarIconBrightness: Brightness.dark
    ));
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.6,
                child: Text(
                  restaurant.name.toString(),
                  style:
                      const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width:  SizeConfig.screenWidth * 0.2,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "${restaurant.image_url}",
                      width: 80,
                    )),
              )
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.01,
          ),
          Row(
            children: [
              Text(
                "${restaurant.heure_douverture} - ${restaurant.heure_fermeture}",
                style: const TextStyle(
                    fontSize: 16, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  restaurant.adresse.toString(),
                  style: const TextStyle(
                      fontSize: 16,),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                ),
              ),
              Text(
                restaurant.phone.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          const Text("Menu du jour",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
        ],
      ),
    );
  }
}
