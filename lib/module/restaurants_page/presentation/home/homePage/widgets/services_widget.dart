import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Role/fetch_all_users_role.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/all_meals/all_meals_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/bookings/all_bookings.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/deliver/all_deliver.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/favoris/all_user_favoris.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/meals/all_meals_by_categorie.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/orders/all_orders.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/promotion/all_promotions.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/restaurants/all_restaurants_by_specialite_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

class ServicesWidget extends StatefulWidget {

  const ServicesWidget({super.key,});



  @override
  State<ServicesWidget> createState() => _ServicesWidgetState();
}

class _ServicesWidgetState extends State<ServicesWidget> {

  Future<String?>? livreurRoleId;
  String? globalRoleId;

  @override
  void initState() {
    super.initState();
    globalRoleId = GetStorage().read('role_id');
    livreurRoleId = fetchLivreurRoleId(); // Récupérer le rôle "Livreur" au démarrage

  }

   fetchUserRoleId() async {
    final response = await http.get(Uri.parse('https://apiwadounnou.wadounnou.com/api/roles'));

    if (response.statusCode == 200) {
      final List<dynamic> roles = jsonDecode(response.body)['data'];

      for (var role in roles) {
        if (role['name'] == 'User') {
          return role['id'];
        }
      }

      throw Exception('ID du rôle "User" non trouvé dans la réponse de l\'API');
    } else {
      throw Exception('Échec du chargement des rôles depuis l\'API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: livreurRoleId,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Text("Erreur: Données non chargées");
          }

          final roleIdFromApi = snapshot.data; // Le rôle ID de "Livreur"
          print('Role ID from API: $roleIdFromApi'); // Débogage
          print('Role ID from Storage: $globalRoleId'); // Débogage

          return SizedBox(
            height: SizeConfig.screenHeight * 0.33,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 7
              ), children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPromotionsScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kWhite,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/svg/offer-icon.svg', height: 35, color: kPrimaryColor,),
                          /*IconButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPromotionsScreen()));
                          }, icon: const Icon(
                            Iconsax.percentage_square5,
                            size: 35,
                            color: kPrimaryColor,
                          )),*/
                          SizedBox(height: SizeConfig.screenHeight * 0.022,),
                          const Text('En Promotion', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ),),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllRestaurantsBySpecialiteScreen()));
                  },
                  child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ), child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/svg/town-city-icon.svg', height: 35, color: kPrimaryColor,),
                        /*IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AllRestaurantsBySpecialiteScreen()));
                        }, icon: const Icon(
                          Icons.flatware_sharp,
                          size: 35,
                          color: kPrimaryColor,
                        )),*/
                        SizedBox(height: SizeConfig.screenHeight * 0.022,),
                        const Text('Nos Restaurants', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllMealsByCategorieScreen()));
                  },
                  child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ), child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/svg/food-and-drink-icon.svg', height: 35, color: kPrimaryColor,),
                        SizedBox(height: SizeConfig.screenHeight * 0.022,),
                        const Text('Buffets', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),),
                ),
               if (globalRoleId == roleIdFromApi)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllDeliverScreens()));
                  },
                  child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ), child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/svg/bike-motorcycle-icon.svg', height: 35, color: kPrimaryColor,),
                        /*IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AllDeliverScreens()));
                        }, icon: const Icon(
                          Icons.delivery_dining,
                          size: 35,
                          color: kPrimaryColor,
                        )),*/
                        SizedBox(height: SizeConfig.screenHeight * 0.022,),
                        const Text('Mes Livraisons', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),),
                ),
                if (globalRoleId != roleIdFromApi)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllUserFavories()));
                  },
                  child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ), child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/svg/hobbies-like-icon.svg', height: 35, color: kPrimaryColor,),
                        /*IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AllUserFavories()));
                        }, icon: const Icon(
                          Icons.favorite_outline,
                          size: 35,
                          color: kPrimaryColor,
                        )),*/
                        SizedBox(height: SizeConfig.screenHeight * 0.022,),
                        const Text('Mes Favoris', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllOrdersScreen()));
                  },
                  child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ), child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/svg/order-history-icon.svg', height: 35, color: kPrimaryColor,),
                        /*IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AllOrdersScreen()));
                        }, icon: const Icon(
                          Iconsax.activity5,
                          size: 35,
                          color: kPrimaryColor,
                        )),*/
                        SizedBox(height: SizeConfig.screenHeight * 0.022,),
                        const Text('Mes commandes', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllBookingsScreen()));
                  },
                  child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ), child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/svg/booking-reservation-icon.svg', height: 35, color: kPrimaryColor,),
                        /*IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AllBookingsScreen()));
                        }, icon: const Icon(
                          Iconsax.align_horizontally5,
                          size: 35,
                          color: kPrimaryColor,
                        )),*/
                        SizedBox(height: SizeConfig.screenHeight * 0.022,),
                        const Text('Mes Réservations', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),),
                ),
              ]),
            ),
          );
        }
    );
  }
}
