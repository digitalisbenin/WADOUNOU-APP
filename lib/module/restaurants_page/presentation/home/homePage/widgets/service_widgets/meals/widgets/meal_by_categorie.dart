import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/categorie/categories_list.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/meals/widgets/meal_by_categorie_widget.dart';
import 'package:flutter/material.dart';

class MealByCategorieBody extends StatefulWidget {
  const MealByCategorieBody({super.key,});


  @override
  State<MealByCategorieBody> createState() => _MealByCategorieBodyState();
}

class _MealByCategorieBodyState extends State<MealByCategorieBody> {
  late Future<List<Categorie>> _categories;



  @override
  void initState() {
    super.initState();
    _categories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0,  right: 8.0,),
          child: SizedBox(
            height: SizeConfig.screenHeight * 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                  child: const Text(
                    'Catégories',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                FutureBuilder<List<Categorie>>(
                    future: _categories,
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
                            "Erreur lors du chargement des catégories",
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
                                "Aucunes données n'est présent sur les catégories",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      } else {
                        final categories = snapshot.data!;

                        return DefaultTabController(
                            length: categories.length,
                            child: SizedBox(
                              height: SizeConfig.screenHeight * 1,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: TabBar(
                                      tabAlignment: TabAlignment.start,
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
                                      tabs: categories.map((categorie) {
                                        return Tab(
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(horizontal: 12.0),
                                            child: Text(categorie.name.toString()),
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
                                      children: categories.map((c) {
                                        return RepasScreen(
                                          categoryId: c.id,
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ));
                      }
                    })
              ],
            ),
          ),
        )
      ],
    );
  }
}
