import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/restaurant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/provider/booking_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:digitalis_restaurant_app/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/*class Restaurant {
  final String name;
  final int stars;
  final String location;

  Restaurant(this.name, this.stars, this.location);
}*/

class MakeReservationBody extends StatefulWidget {
  const MakeReservationBody({
    super.key,
  });

  @override
  State<MakeReservationBody> createState() => _MakeReservationBodyState();
}

class _MakeReservationBodyState extends State<MakeReservationBody> {
  final _formKey = GlobalKey<FormState>();

  //Restaurant? _selectedRestaurant;

  Restaurant? selectedRestaurants;

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: RestaurantList.getRestaurants(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 8.0,
                ),
                Text("Veuillez Patienter un moment..."),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else {
          final restaurants = snapshot.data as List<Restaurant>;

          // Créez la liste dropdownItems avec des valeurs uniques
          final dropdownItems = restaurants.map((restaurant) {
            return DropdownMenuItem<String>(
              value: restaurant.id, // Utilisez l'ID comme valeur
              child: Text(restaurant.name.toString()),
            );
          }).toList();

          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 3.0),
                    child: DropdownButtonFormField<String>(
                      // Utilisez String comme type pour la liste déroulante
                      value: selectedRestaurants != null
                          ? selectedRestaurants!.id
                          : null,
                      items: dropdownItems,
                      onChanged: (value) {
                        final selectedRestaurant = restaurants
                            .firstWhere((restaurant) => restaurant.id == value);
                        setState(() {
                          selectedRestaurants = selectedRestaurant;
                        });
                        print(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 3.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _partySizeController,
                      cursorColor: kTextColor,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          hintText: "Nombre de places à réserver",
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 3.0),
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
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            hintText: 'Date et Heure de la réservation',
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: TextFormField(
                      controller: _nameController,
                      cursorColor: kTextColor,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          hintText: "Nom & prénoms",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 3.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      cursorColor: kTextColor,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          hintText: "Numéro de téléphone",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: kTextColor)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Renseignez votre numéro de téléphone";
                        }
                        return null;
                      },
                    ),
                  ),
                  
                  
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 3.0),
                    child: TextFormField(
                      controller: _descriptionController,
                      cursorColor: kTextColor,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          hintText:
                              "Motif de la reservation (Une Occasion spéciale)",
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          hintStyle: TextStyle(color: kTextColor)),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Consumer<BookingProvider>(
                        builder: (context, booking, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (booking.resMessage != '') {
                          showMessage(
                              message: booking.resMessage, context: context);
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
      },
    );
  }
}
