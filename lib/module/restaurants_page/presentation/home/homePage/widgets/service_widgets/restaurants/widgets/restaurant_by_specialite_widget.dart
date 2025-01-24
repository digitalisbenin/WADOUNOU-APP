import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Commandes.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Repas.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/repas_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/restaurant_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/cart/shop_app_cart.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/other_arrivals_widgets/daily_single_food_card.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/other_arrivals_widgets/widgets/dailyfood_details.dart';
import 'package:digitalis_restaurant_app/provider/booking_provider.dart';
import 'package:digitalis_restaurant_app/provider/cart_provider.dart';
import 'package:digitalis_restaurant_app/provider/restaurant_provider/get_restaurant_service.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Fonction pour obtenir les restaurants par spécialité
Future<List<Restaurant>> fetchRestaurantsBySpeciality(
    String specialityId) async {
  final response = await http.get(Uri.parse(
      'https://apiwadounnou.wadounnou.com/api/restaurantspecialite?specialite_id=$specialityId'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body)['data'];
    return data.map((e) => Restaurant.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load restaurants');
  }
}

// Écran des restaurants
class RestaurantsScreen extends StatefulWidget {
  final String specialityId;

  const RestaurantsScreen({required this.specialityId});

  @override
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  late Future<List<Restaurant>> _restaurants;

  @override
  void initState() {
    super.initState();
    _restaurants = fetchRestaurantsBySpeciality(widget.specialityId);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.specialityId == "") {
      return FutureBuilder<List<Restaurant>>(
        future: RestaurantList.getRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun restaurant pour le moment'));
          }

          if (snapshot.hasError) {
            return const Center(
                child: Text('Erreur lors du chargement des restaurants'));
          }

          final restaurants = snapshot.data!;
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return SingleRestaurantCard(
                press: () {
                  print('ID du Restaurant : ${restaurants[index].id}');
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return RestaurantBody(restaurant: restaurant);
                  }));
                },
                restaurants: restaurant,
              );
            },
          );
        },
      );
    } else {
      return FutureBuilder<List<Restaurant>>(
        future: _restaurants,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun restaurant pour le moment'));
          }

          if (snapshot.hasError) {
            return const Center(
                child: Text('Erreur lors du chargement des restaurants'));
          }

          final restaurants = snapshot.data!;
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return SingleRestaurantCard(
                press: () {
                  print('ID du Restaurant : ${restaurants[index].id}');
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return RestaurantBody(restaurant: restaurant);
                  }));
                },
                restaurants: restaurant,
              );
            },
          );
        },
      );
    }
  }
}

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
      padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.007),
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
                        height: 200,
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
                          padding: const EdgeInsets.all(8.0),
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

// Corps du restaurant
class RestaurantBody extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantBody(
      {required this.restaurant}); // Assurez-vous que ce paramètre est ici

  @override
  _RestaurantBodyState createState() => _RestaurantBodyState();
}

class _RestaurantBodyState extends State<RestaurantBody> {
  final _formKey = GlobalKey<FormState>();

  /*  String? restaurantId; */

  RestaurantDetailArgument? arguments;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  DateTime? _selectedDate;
  final TextEditingController _timeController = TextEditingController();
  TimeOfDay? _selectedTime;
  final TextEditingController _partySizeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.clear();
    _phoneController.clear();
    _dateTimeController.clear();
    _timeController.clear();
    _partySizeController.clear();
    _descriptionController.clear();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kWhite,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.53,
            maxChildSize: 0.9,
            minChildSize: 0.32,
            builder: (context, scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.95,
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  // clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      child: Container(
                        width: 60,
                        height: 7,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.022,
                        ),
                        const Center(
                          child: Text(
                            "Réservation",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 0),
                                      )
                                    ]),
                                child: TextFormField(
                                  controller: _nameController,
                                  cursorColor: kPrimaryColor,
                                  textCapitalization: TextCapitalization.words,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      hintText: "Nom & prénoms",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: kTextColor)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Veuillez saisir votre nom complet";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 0),
                                      )
                                    ]),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _phoneController,
                                  cursorColor: kPrimaryColor,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      hintText: "Numéro de téléphone",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: kTextColor)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Renseignez votre numéro de téléphone";
                                    }

                                    if (value.length == 8 ||
                                        value.length == 10 ||
                                        value.length == 12 ||
                                        value.length == 13 ||
                                        value.length == 15) {
                                      return null; // La taille du numéro de téléphone est valide
                                    } else {
                                      return "Le numéro de téléphone n'est pas valide";
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              InkWell(
                                onTap: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(DateTime.now().year + 1),
                                  );
                                  if (selectedDate != null) {
                                    final selectedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (selectedTime != null) {
                                      final combinedDateTime = DateTime(
                                        selectedDate.year,
                                        selectedDate.month,
                                        selectedDate.day,
                                        selectedTime.hour,
                                        selectedTime.minute,
                                      );
                                      setState(() {
                                        _selectedDate = selectedDate;
                                        _selectedTime = selectedTime;
                                        _dateTimeController.text =
                                            DateFormat('yyyy-MM-dd HH:mm')
                                                .format(combinedDateTime);
                                      });
                                    }
                                  }
                                },
                                child: AbsorbPointer(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 0),
                                          )
                                        ]),
                                    child: TextFormField(
                                      controller: _dateTimeController,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: const InputDecoration(
                                        hintText:
                                            'Date et Heure de la réservation',
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Veuillez sélectionner une date et une heure';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.02,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 0),
                                      )
                                    ]),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _partySizeController,
                                  cursorColor: kPrimaryColor,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      hintText: "Nombre de places à réserver",
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      hintStyle: TextStyle(color: kTextColor)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Le nombre de places à réserver est obligatoire";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.02,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 0),
                                      )
                                    ]),
                                child: TextFormField(
                                  controller: _descriptionController,
                                  cursorColor: kPrimaryColor,
                                  maxLines: 3,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      hintText:
                                          "Dites nous plus sur la réservation (facultatif)",
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      hintStyle: TextStyle(color: kTextColor)),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.04,
                              ),
                              Consumer<BookingProvider>(
                                  builder: (context, bookInRestaurant, child) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  if (bookInRestaurant.resMessage != '') {
                                    showMessage(
                                        message: bookInRestaurant.resMessage,
                                        context: context);
                                    bookInRestaurant.clear();
                                  }
                                });
                                return AppFilledButton(
                                  text: "Réserver dans ce restaurant",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      String? restaurantId =
                                          widget.restaurant.id;
                                      debugPrint(
                                          'ID du restaurant lors de la réservation : $restaurantId');

                                      bookInRestaurant.postBooking(
                                        name: _nameController.text.trim(),
                                        contact: _phoneController.text.trim(),
                                        dateAndTime:
                                            _dateTimeController.text.trim(),
                                        place: _partySizeController.text.trim(),
                                        description:
                                            _descriptionController.text.trim(),
                                        restaurant_id:
                                            widget.restaurant.id.toString(),
                                        context: context,
                                      );
                                      Navigator.of(context).pop();

                                      if (bookInRestaurant
                                          .resMessage.isNotEmpty) {
                                        // Afficher le SnackBar avec la couleur appropriée
                                        final snackBar = SnackBar(
                                          content:
                                              Text(bookInRestaurant.resMessage),
                                          backgroundColor:
                                              bookInRestaurant.isSuccess
                                                  ? Colors.green
                                                  : Colors.red,
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }

                                      // submitReservationForm(arguments);
                                    } else if (_nameController.text.isEmpty ||
                                        _phoneController.text.isEmpty ||
                                        _dateTimeController.text.isEmpty ||
                                        _partySizeController.text.isEmpty) {
                                      showMessage(
                                        message:
                                            'Tous les champs sont obligatoires',
                                        context: context,
                                      );
                                      dispose();
                                    }
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(widget.restaurant.name,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        // Afficher le nom du restaurant
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18.0,
            ),
          ),
        ),
      ),
      backgroundColor: kBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RestaurantInfoDetails(
              restaurant: widget.restaurant,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
            const Center(
              child: Text(
                "Mets du jour",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            DailyFood(
              restaurant: widget.restaurant,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0)),
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            color: kPrimaryColor,
            onPressed: () {
              String restaurantId = widget.restaurant.id ?? "";
              debugPrint("ID du restaurant sélectionné : $restaurantId");
              // modal bottom sheet
              _showBottomSheet(context);
            },
            child: const Text(
              "Réserver dans ce restaurant",
              style: TextStyle(color: kWhite),
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ]),
        child: Consumer<CartProvider>(builder: (context, cartProvider, child) {
          int cartItemCount = cartProvider.restaurantCartItems.length;

          return badge.Badge(
            showBadge: cartItemCount > 0,
            badgeContent: Text(
              cartItemCount.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            badgeStyle: const badge.BadgeStyle(badgeColor: kPrimaryColor),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShopAppCart(
                              restaurantId: widget.restaurant.id ?? '',
                              restaurantName: widget.restaurant.name ?? '',
                              restaurantMtnPay: widget.restaurant.mtnpay ?? '',
                              restaurantMoovPay:
                                  widget.restaurant.moovpay ?? '',
                              restaurantCeltiisPay:
                                  widget.restaurant.celtispay ?? '',
                            )));
              },
              child: const Icon(
                CupertinoIcons.cart,
                color: kPrimaryColor,
              ),
            ),
          );
        }),
      ),

      /*Column(
        children: [
          // Ajoutez le contenu que vous souhaitez montrer pour le détail du restaurant
          Text("Description: ${widget.restaurant.description}"),
          Image.network(widget.restaurant.imageUrl), // Afficher l'image du restaurant
          // Ajoutez plus de détails si nécessaire
        ],
      )*/
    );
  }
}

class RestaurantInfoDetails extends StatelessWidget {
  RestaurantInfoDetails({super.key, required this.restaurant});

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
              Positioned(
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
                  )),
              Positioned(
                left: 25,
                bottom: 6,
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
                  bottom: 8,
                  right: 20,
                  child: Column(
                    children: [
                      Text(
                        "${restaurant.heure_douverture} - ${restaurant.heure_fermeture}",
                        style: const TextStyle(
                            fontSize: 16, overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        restaurant.adresse.toString(),
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

// Daily Food
class DailyFood extends StatefulWidget {
  const DailyFood({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<DailyFood> createState() => _DailyFoodState();
}

class _DailyFoodState extends State<DailyFood> {
  List<Repas>? menuItems;

  @override
  void initState() {
    super.initState();
    fetchMenuItems();
  }

  void fetchMenuItems() async {
    try {
      final response = await http.get(Uri.parse(
          'https://apiwadounnou.wadounnou.com/api/repa?restaurant_id=${widget.restaurant.id}'));
      if (response.statusCode == 200) {
        // Si la requête réussit, on parse les données JSON
        final List<dynamic> decodedData = json.decode(response.body)['data'];
        // On transforme les données en liste de Repas
        List<Repas> meals =
            decodedData.map((data) => Repas.fromJson(data)).toList();
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
                          /* prix: widget.restaurant.menu!.prix.toString(), */
                          press: () {
                            Navigator.pushNamed(
                              context,
                              DailyFoodDetailPage.routeName,
                              arguments: ProductDetailArguments(
                                repas: menuItems![index],
                                restaurant: widget.restaurant,
                              ),
                            );
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailsPage()));
                          },
                        )),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
    );
  }
}

/*class ProductDetailArguments {
  final Repas repas;
  final Commandes? commandes;
  final Restaurant? restaurant;

  ProductDetailArguments({
    required this.repas,
    this.restaurant,
    this.commandes,
  });
}*/
