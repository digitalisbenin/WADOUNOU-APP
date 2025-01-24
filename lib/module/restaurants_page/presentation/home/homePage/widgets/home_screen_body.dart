import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/drawer_widget.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/pop_up_menu.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/popular_restaurant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/pubs/pubs_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/search_restaurant_field_for_users.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/services_widget.dart';
import 'package:digitalis_restaurant_app/module/screens/login/login_page.dart';
import 'package:digitalis_restaurant_app/module/selected_role_page/selected_role_screen.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {

  String searchRestaurantQuery = '';
  String searchMealQuery = '';

  List<RestaurantModel> favoriteRestaurants = [];

  late TextEditingController _searchRestaurantController;
  late TextEditingController _searchMealController;

  final nomUser = GetStorage().read('userName') ?? '';

  final token = GetStorage().read('token');

  final mailUser = GetStorage().read('userMail') ?? '';

  String? globalRoleId;

  @override
  void initState() {
    super.initState();
    _searchRestaurantController = TextEditingController();
    _searchMealController = TextEditingController();
    globalRoleId = GetStorage().read('role_id');
    _onRefresh();
  }

  void updateRestaurantSearch(String query_restaurant) {
    setState(() {
      searchRestaurantQuery = query_restaurant;
    });
  }

  bool isRefresh = false;

  Future<void> _onRefresh() async {
    try {
      setState(() {
        isRefresh = true;
      });

      List<Restaurant> restaurants = await RestaurantList.getRestaurants();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La page a été mis à jour'),
        ),
      );
      //return [restaurants, repas];
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Erreur lors de l'actualisation de la page. Vérifier votre connexion internet..."),
        ),
      );
      print(("Erreur: ${e}"));
    } finally {
      setState(() {
        isRefresh = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,

      body: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 15),
                child: Text(
                  "Nos Publicités",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              const PubImageSlider(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.01,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 15),
                child: Text(
                  "Nos services",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              ((token != null && token.isNotEmpty) && globalRoleId != null)
                  ?  ServicesWidget() : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: AppFilledButton(
                          text: "Se connecter",
                          onPressed: () {
                            PageNavigator(ctx: context)
                                .nextPageOnly(page: const LoginPage());
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
                            PageNavigator(ctx: context)
                                .nextPageOnly(page: const SelectedRoleScreen());
                          },
                          color: kPrimaryColor,
                          txtColor: kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Restaurants populaires",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                    Center(
                      child: SearchRestaurantFieldForUsers(
                        onSearch: updateRestaurantSearch,
                        searchController:
                        _searchRestaurantController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              PopularRestaurantWidget(
                searchQuery: searchRestaurantQuery,
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
