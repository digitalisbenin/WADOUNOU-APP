import 'dart:convert';

import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/restaurants/widgets/restaurant_by_specialite_widget.dart';
import 'package:digitalis_restaurant_app/core/model/specialites/specialite_model.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/restaurant_body.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/single_restaurant_card.dart';
import 'package:digitalis_restaurant_app/provider/specialite_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../core/model/specialites/specialites_list.dart';

class RestaurantBySpecialiteBody extends StatefulWidget {
  const RestaurantBySpecialiteBody({super.key});

  @override
  State<RestaurantBySpecialiteBody> createState() =>
      _RestaurantBySpecialiteBodyState();
}

class _RestaurantBySpecialiteBodyState
    extends State<RestaurantBySpecialiteBody> {

  late Future<List<Speciality>> _specialities;

  @override
  void initState() {
    super.initState();
    _specialities = fetchSpecialities();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Spécialités',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.002,
              ),
              FutureBuilder<List<Speciality>>(
                  future: _specialities,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text("Veuillez patienter un moment..."),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Erreur lors du chargement des specialités",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: SizeConfig.screenHeight * 0.18,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kWhite,
                            border: Border.all(color: Colors.black),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                            child: Text(
                              "Aucunes données n'est présent sur les spécialités",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    } else {

                      final specialities = snapshot.data!;

                      return DefaultTabController(
                          length: specialities.length,
                          child: SizedBox(
                            height: SizeConfig.screenHeight * 1,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: TabBar(
                                    tabAlignment: TabAlignment.center,
                                    dividerColor: Colors.transparent,
                                    labelPadding: const EdgeInsets.all(0),
                                    indicatorPadding: const EdgeInsets.all(0),
                                    isScrollable: true,
                                    labelColor: kWhite,
                                    unselectedLabelColor: kTextColor,
                                    labelStyle: const TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w700),
                                    unselectedLabelStyle: const TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w600),
                                    indicator: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      color: kPrimaryColor,
                                    ),
                                    tabs: specialities.map((specialites) {
                                      return Tab(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Text(specialites.name.toString()),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.02,
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: specialities.map((s) {
                                      return RestaurantsScreen(
                                        specialityId: s.id,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          )

                      );
                    }
                  })
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialityTab extends StatelessWidget {
  final Speciality speciality;

  const SpecialityTab({required this.speciality});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantsScreen(
                specialityId: speciality.id,
              ),
            ),
          );
        },
        child: Text('Voir les restaurants de ${speciality.name}'),
      ),
    );
  }
}
