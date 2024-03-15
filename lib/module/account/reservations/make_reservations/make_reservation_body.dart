import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/provider/booking_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MakeReservationBody extends StatefulWidget {
  const MakeReservationBody({Key? key}) : super(key: key);

  @override
  State<MakeReservationBody> createState() => _MakeReservationBodyState();
}

class _MakeReservationBodyState extends State<MakeReservationBody> {
  final _formKey = GlobalKey<FormState>();
  Restaurant? selectedRestaurants;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  DateTime? _selectedDate;
  final TextEditingController _timeController = TextEditingController();
  TimeOfDay? _selectedTime;
  final TextEditingController _partySizeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchRestaurantByAdress =
      TextEditingController();

  List<Restaurant> restaurants = [];
  List<Restaurant> filteredRestaurants = [];
  String? selectedRestaurantImage;
  String? selectedRestaurantDescription;

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    final restaurantList = await RestaurantList.getRestaurants();
    setState(() {
      restaurants = restaurantList;
      filteredRestaurants = List.from(restaurants);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dropdownItems = filteredRestaurants.isNotEmpty
        ? filteredRestaurants.map((restaurant) {
            return DropdownMenuItem<String>(
              value: restaurant.id,
              child: Text(restaurant.name.toString()),
            );
          }).toList()
        : <DropdownMenuItem<String>>[];

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: TextFormField(
                controller: _searchRestaurantByAdress,
                cursorColor: kPrimaryColor,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      filteredRestaurants = restaurants
                          .where((restaurant) => restaurant.adresse!
                              .toLowerCase()
                              .contains(value.toLowerCase().toString()))
                          .toList();
                    } else {
                      filteredRestaurants = List.from(restaurants);
                    }
                  });
                },
                decoration: const InputDecoration(
                    hintText: "Rechercher par la ville",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: kTextColor)),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
              child: DropdownButtonFormField<String>(
                value: selectedRestaurants != null
                    ? selectedRestaurants!.id
                    : null,
                items: dropdownItems,
                onChanged: (value) {
                  final selectedRestaurant = (filteredRestaurants.isNotEmpty
                          ? filteredRestaurants
                          : restaurants)
                      .firstWhere((restaurant) => restaurant.id == value);
                  setState(() {
                    selectedRestaurants = selectedRestaurant;
                    selectedRestaurantImage = selectedRestaurant.image_url;
                    selectedRestaurantDescription =
                        selectedRestaurant.description;
                  });
                  debugPrint(
                      "ID du restaurant sélectionné : ${selectedRestaurant.id}");
                },
                decoration: const InputDecoration(
                  hintText: 'Choisissez un restaurant',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner un restaurant';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            if (selectedRestaurants != null)
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selectedRestaurantImage != null)
                      Image.network(
                        selectedRestaurantImage!,
                        width: 100.0, // ajuste la largeur selon tes besoins
                        height: 100.0, // ajuste la hauteur selon tes besoins
                      ),
                    if (selectedRestaurantDescription != null)
                      Expanded(
                          child: Text(
                        selectedRestaurantDescription ?? '',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      )),
                  ],
                ),
              ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _partySizeController,
                cursorColor: kPrimaryColor,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    hintText: "Nombre de places à réserver",
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
              child: InkWell(
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
                  child: TextFormField(
                    controller: _dateTimeController,
                    cursorColor: kPrimaryColor,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: 'Date et Heure de la réservation',
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
              height: SizeConfig.screenHeight * 0.04,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: TextFormField(
                controller: _nameController,
                cursorColor: kPrimaryColor,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    hintText: "Nom & prénoms",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                cursorColor: kPrimaryColor,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    hintText: "Numéro de téléphone",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: kTextColor)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Renseignez votre numéro de téléphone";
                  }

                  if (value.length == 8 ||
                      value.length == 12 ||
                      value.length == 13) {
                    return null; // La taille du numéro de téléphone est valide
                  } else {
                    return "Le numéro de téléphone n'est pas valide";
                  }
                },
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
              child: TextFormField(
                controller: _descriptionController,
                cursorColor: kPrimaryColor,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    hintText: "Dites nous plus sur la réservation (facultatif)",
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    hintStyle: TextStyle(color: kTextColor)),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Consumer<BookingProvider>(builder: (context, booking, child) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  if (booking.resMessage != '') {
                    showMessage(message: booking.resMessage, context: context);
                    booking.clear();
                  }
                });
                return AppFilledButton(
                  text: "Réserver maintenant",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      booking.postBooking(
                        name: _nameController.text.trim(),
                        contact: _phoneController.text.trim(),
                        dateAndTime: _dateTimeController.text.trim(),
                        place: _partySizeController.text.trim(),
                        description: _descriptionController.text.trim(),
                        restaurant_id: selectedRestaurants!.id.toString(),
                        context: context,
                      );
                      dispose();
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    } else if (_nameController.text.isEmpty ||
                        _phoneController.text.isEmpty ||
                        _dateTimeController.text.isEmpty ||
                        _partySizeController.text.isEmpty) {
                      showMessage(
                        message: 'Tous les champs sont obligatoires',
                        context: context,
                      );
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
