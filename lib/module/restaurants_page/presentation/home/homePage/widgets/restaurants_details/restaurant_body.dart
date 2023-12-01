import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/arguments/restaurant_detail_arguments.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/other_arrivals_widgets/daily_food_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/restaurant_info_details.dart';
import 'package:digitalis_restaurant_app/provider/booking_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RestaurantBody extends StatefulWidget {
  const RestaurantBody({
    super.key, required this.restaurant,
  });

  final Restaurant restaurant;

  static String routeName = "/restaurant_body";

  @override
  State<RestaurantBody> createState() => _RestaurantBodyState();
}

class _RestaurantBodyState extends State<RestaurantBody> {
  final _formKey = GlobalKey<FormState>();

  String? restaurantId;

  Restaurant? _selectedRestaurant;

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

  void _showBottomSheet(
      BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
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
                                  cursorColor: kTextColor,
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
                                  cursorColor: kTextColor,
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
                                    return null;
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
                                    lastDate:
                                        DateTime(DateTime.now().year + 1),
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
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.02,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _partySizeController,
                                cursorColor: kTextColor,
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
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.02,
                              ),
                              TextFormField(
                                controller: _descriptionController,
                                cursorColor: kTextColor,
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
                                      print(
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
                                            widget.restaurant.id!.toString(),
                                        context: context,
                                      );

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

                                        // Fermer le Bottom Sheet après un délai (par exemple, 2 secondes)
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          Navigator.of(context).pop();
                                         /*  Navigator.pop(context); */
                                        });
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
    arguments =
        ModalRoute.of(context)?.settings.arguments as RestaurantDetailArgument?;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(""),
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
          )),
      backgroundColor: kBackgroundForRestaurant,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RestaurantInfoDetails(
              restaurant: widget.restaurant,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            /* const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Nouveau Venus",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const RestaurantsNewArrivalScreen(),
            verticalSpaceRegular, */
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Mets du jour",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            DailyFood(restaurant: widget.restaurant,),
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
              print("ID du restaurant sélectionné : $restaurantId");
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
    );
  }
}
