import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class RestaurantInfoDetails extends StatelessWidget {
  RestaurantInfoDetails({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                restaurant.name.toString(),
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "${restaurant.image_url}",
                    width: 80,
                  ))
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.01,),
          Row(
            children: [
              Text("${restaurant.heure_douverture} - ${restaurant.heure_fermeture}", style: const TextStyle(fontSize: 16),),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(restaurant.adresse.toString(), style: const TextStyle(fontSize: 16),),
              Text(restaurant.phone.toString(), style: const TextStyle(fontSize: 16),),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.05,
          ),
          const Text("Notre Menu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
        ],
      ),
    );
  }
}
