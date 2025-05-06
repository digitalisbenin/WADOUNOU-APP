import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/other_arrivals_widgets/daily_single_food_card.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/other_arrivals_widgets/widgets/dailyfood_details.dart';
import 'package:digitalis_restaurant_app/module/screens/login/login_page.dart';
import 'package:digitalis_restaurant_app/module/selected_role_page/selected_role_screen.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class DailyFood extends StatefulWidget {
  const DailyFood({Key? key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<DailyFood> createState() => _DailyFoodState();
}

class _DailyFoodState extends State<DailyFood> {
  List<Repas>? menuItems;

  final nomUser = GetStorage().read('userName') ?? '';

  final token = GetStorage().read('token');

  final mailUser = GetStorage().read('userMail') ?? '';

  String? globalRoleId;

  @override
  void initState() {
    super.initState();
    fetchMenuItems();
    globalRoleId = GetStorage().read('role_id');
  }

  // Fonction pour récupérer les repas du restaurant depuis l'API
  void fetchMenuItems() async {
    try {
      final response = await http.get(Uri.parse('https://api-wadounnou.api-mon-encadreur.com/api/repa?restaurant_id=${widget.restaurant.id}'));
      if (response.statusCode == 200) {
        // Si la requête réussit, on parse les données JSON
        final List<dynamic> decodedData = json.decode(response.body)['data'];
        // On transforme les données en liste de Repas
        List<Repas> meals = decodedData.map((data) => Repas.fromJson(data)).toList();
        setState(() {
          menuItems = meals;
        });
      } else {
        throw Exception('Failed to load menu items');
      }
    } catch (e) {
      print('Error fetching menu items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: menuItems == null || menuItems!.isEmpty
          ? const Padding(
        padding: EdgeInsets.only(left: 120.0),
        child: Text("Aucun Menus disponible"),
      )
          : Row(
        children: [
          //Product Single Card
          ...List.generate(
            menuItems!.length,
                (index) => DailySingleFoodCard(
              repas: menuItems![index],
              restaurantId: widget.restaurant.id ?? "",
              press: () {
                if (token == null && globalRoleId == null) {
                  showDialog(context: context, builder: (context){
                    return Dialog(
                      insetPadding:
                      const EdgeInsets.all(10),
                      child: Container(
                        width: double.infinity,
                        height: SizeConfig.screenHeight *0.33,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius:
                          BorderRadius.circular(
                              12),
                        ),
                        padding: const EdgeInsets
                            .fromLTRB(
                            20, 30, 20, 20),
                        child: SingleChildScrollView(
                          child: Stack(
                            children: [
                              Positioned(
                                  right: 5,
                                  child: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.cancel_outlined))),
                              Column(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.05,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: AppFilledButton(
                                        text: "Se connecter",
                                        onPressed: () {
                                          PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
                                          /*Navigator.pushNamed(
                                    context, LoginPage.routeName);*/
                                        },
                                        color: kWhite,
                                        txtColor: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  const Text("ou", style: TextStyle(fontSize: 18)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: AppFilledButton(
                                        text: "S'inscrire",
                                        onPressed: () {
                                          PageNavigator(ctx: context).nextPageOnly(page: const SelectedRoleScreen());
                                        },
                                        color: kPrimaryColor,
                                        txtColor: kWhite,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                } else {
                  Navigator.pushNamed(
                    context,
                    DailyFoodDetailPage.routeName,
                    arguments: ProductDetailArguments(
                      repas: menuItems![index],
                      restaurant: widget.restaurant,
                    ),
                  );
                }

              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
