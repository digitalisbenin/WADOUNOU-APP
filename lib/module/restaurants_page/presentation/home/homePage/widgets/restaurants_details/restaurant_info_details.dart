import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class RestaurantInfoDetails extends StatelessWidget {
  RestaurantInfoDetails({super.key, required this.restaurant});

  String formatHeure(String heure) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(heure);
    String formattedTime = DateFormat("HH:mm").format(parsedTime);
    return formattedTime;
  }

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    /*  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: kOnBoardingBackgroundColor, statusBarIconBrightness: Brightness.dark)); */
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.38,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 230,
                decoration: BoxDecoration(
                    color: kStandartDeepGreenColor,
                    image: DecorationImage(
                        image: NetworkImage(restaurant.imageUrl),
                        fit: BoxFit.cover)),
              ),
              /*Positioned(
                  left: 20,
                  top: 190,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(100)),
                  )),
              Positioned(
                  left: 25,
                  top: 195,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('assets/images/WADOUNOU 01.jpg'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(100)),
                  )),*/
              Positioned(
                left: SizeConfig.screenWidth * 0.03,
                bottom: SizeConfig.screenHeight * 0.04,
                child: Text(
                  restaurant.name.toString(),
                  style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                ),
              ),
              Positioned(
                  bottom: SizeConfig.screenHeight * 0.02,
                  right: SizeConfig.screenWidth * 0.03,
                  child: Column(
                    children: [
                      Text(
                        "Ouvert de ${formatHeure(restaurant.heure_douverture)} à ${formatHeure(restaurant.heure_fermeture)}",
                        style: const TextStyle(
                            fontSize: 16, overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        "${"à".toUpperCase()} ${restaurant.adresse.toString()}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );

    /* Column(
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
      ), */
  }
}
