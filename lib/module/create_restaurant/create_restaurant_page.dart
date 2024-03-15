import 'dart:io';

import 'package:badges/badges.dart';
import 'package:badges/badges.dart' as badge;
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/create_restaurant/widgets/create_restaurant_background_image.dart';
import 'package:digitalis_restaurant_app/module/screens/signup/sign_up_page.dart';
import 'package:digitalis_restaurant_app/provider/restaurant_provider/add_restaurant_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_outline_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:digitalis_restaurant_app/widgets/custom_button.dart';
import 'package:digitalis_restaurant_app/widgets/form_error.dart';
import 'package:digitalis_restaurant_app/widgets/line.dart';
import 'package:digitalis_restaurant_app/widgets/restaurant_created_successfully.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/Restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateRestaurant extends StatefulWidget {
  const CreateRestaurant({super.key});

  static String routeName = "/create_restaurant";

  @override
  State<CreateRestaurant> createState() => _CreateRestaurantState();
}

class _CreateRestaurantState extends State<CreateRestaurant> {
  final _formkey = GlobalKey<FormState>();

  Restaurant? newRestaurant;

  String? restaurantName;
  String? restaurantLocalisationAddress;
  File? restaurantUrlImage;
  String? restaurantContact;
  String? restaurantDescription;
  File? imagePath;


  final TextEditingController _restaurantNameController =
      TextEditingController();
  final TextEditingController _restaurantLocalisationAddressController =
      TextEditingController();
  final TextEditingController _restaurantContactController =
      TextEditingController();
  final TextEditingController _restaurantDescriptionController =
      TextEditingController();


  @override
  void dispose() {
    super.dispose();
    _restaurantNameController.clear();
    _restaurantLocalisationAddressController.clear();
    _restaurantContactController.clear();
    _restaurantDescriptionController.clear();
  }

  final List<String> errors = [];

  bool isLoading = false;

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error!);
      });
    }
  }

  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        });
    } on PlatformException catch(e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  // Gestion du temps de chargement vers la page suivante
  Future<void> startLoading() async {
    setState(() {
      isLoading = true;
    });

    // Simuler le temps de chargement de 6 secondes
    await Future.delayed(const Duration(seconds: 6));

    setState(() {
      isLoading = false;
    });

    // une fois le chargement terminé, naviguez vers la page de succès !
    Navigator.of(context).pushNamed(RestaurantCreatedSuccessfully.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CreateRestaurantBackgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SafeArea(
                  child: Column(children: [
                const SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "WADOUNOU",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 233, 70, 0),
                                fontSize: 30.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Création d'un nouveau compte Restaurant",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: kTextColor,
                                fontSize: 20.0),
                          )
                        ],
                      ),
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          verticalSpaceMedium,
                          _buildHeader(),
                          verticalSpaceMedium,
                          Line(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 3.0),
                              child: _buildRestaurantNameFormField(),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 3.0),
                              child: _buildRestaurantAddressLocationFormField(),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 3.0),
                              child: buildRestaurantContactFormField(),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 3.0),
                              child: _buildRestaurantDescriptionFormField(),
                            ),
                          ),
                          FormError(errors: errors),
                          verticalSpaceRegular,
                          if (isLoading)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: const Center(
                                    child: CircularProgressIndicator(color: kPrimaryColor,),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  "Veuillez patienter",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors
                                        .black, // Choisissez la couleur de texte appropriée
                                  ),
                                ),
                              ],
                            ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: SizeConfig.screenWidth,
                                  child: Consumer<AddRestaurantProvider>(
                                      builder: (context, addRestaurant, child) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      if (addRestaurant.getResponse != '') {
                                        showMessage(
                                          message: addRestaurant.getResponse,
                                          context: context,
                                        );
                                        addRestaurant.clear();
                                      }
                                    });
                                    return customButton(
                                        status: addRestaurant.getStatus,
                                        text: "Suivant",
                                        tap: () {
                                          if (_restaurantNameController
                                                  .text.isEmpty ||
                                              _restaurantLocalisationAddressController
                                                  .text.isEmpty ||
                                              _restaurantContactController
                                                  .text.isEmpty ||
                                              _restaurantDescriptionController
                                                  .text.isEmpty) {
                                            showMessage(
                                              message:
                                                  'Tout les champs sont requis',
                                              context: context,
                                            );
                                          } else {
                                            addRestaurant.addRestaurant(
                                              name: _restaurantNameController.text.trim(),
                                              addresse: _restaurantLocalisationAddressController.text.trim(),
                                              phone: _restaurantContactController.text.trim(),
                                              description: _restaurantDescriptionController.text.trim(),
                                              imageUrl: 'assets/images/res_logo.png',
                                            );
                                          }
                                        },
                                        context: context);

                                    /*AppFilledButton(
                                        text: "Suivant",
                                        onPressed: () async {
                                          if (_formkey.currentState!.validate()) {
                                            _formkey.currentState!.save();
                                            await startLoading();
                                          }
                                        },
                                      );*/
                                  }),
                                ),
                                verticalSpaceRegular,
                                SizedBox(
                                  width: SizeConfig.screenWidth,
                                  child: AppOutlineButton(
                                    text: 'Retour',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          /*
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Affichez le CircularProgressIndicator lorsque isLoading est true

                                Container(
                                  decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, SignUpScreen.routeName);
                                      },
                                      child: const Text(
                                        "Retour",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15.0,
                                        ),
                                      )),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: TextButton(
                                      onPressed: () async {
                                        if (_formkey.currentState!.validate()) {
                                          _formkey.currentState!.save();
                                          await startLoading();
                                        }
                                      },
                                      child: const Text(
                                        "Suivant",
                                        style: TextStyle(
                                          color: kStandartDeepGreenColor,
                                          fontSize: 15.0,
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ), */
                        ],
                      ),
                    ),
                  ],
                ),
              ])),
            ))
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueGrey,
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 20.0,
                        style: BorderStyle.none,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _image == null
                            ? const AssetImage('assets/images/res_logo.png')
                            : FileImage(_image!) as ImageProvider,
                      )),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: InkWell(
                      onTap: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: const Icon(
                        CupertinoIcons.camera_fill,
                        size: 25.0,
                        color: kPrimaryColor,
                      )),
                )
              ],
            ),
            /*InkWell(
              child: badge.Badge(
                badgeContent: const SizedBox(
                  height: 10,
                  width: 10,
                  child: Center(
                    child: FittedBox(
                      child: Icon(
                        CupertinoIcons.camera,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                badgeStyle: const BadgeStyle(
                  badgeColor: kPrimaryColor,
                ),
                position: BadgePosition.bottomEnd(bottom: 1.2, end: 1),
                child: selectedImagePath != null ? FileImage(selectedImagePath!) as Widget : Image.asset(
                  "assets/images/res_logo.png",
                  height: 80,
                ),
              ),
              onTap: () {
                _selectRestaurantLogo();
              },
            ),*/
            horizontalSpaceRegular,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.headingThree(
                  'Logo du restaurant',
                  color: kcBlackColor,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  TextFormField _buildRestaurantDescriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _restaurantDescriptionController,
      onSaved: (newValue) => restaurantDescription = newValue!,
      onChanged: (value) {

        setState(() {
          newRestaurant?.description = value;
        });

        if (value.isNotEmpty) {
          removeError(error: kRestaurantDescriptionNullError);
        } else if (value.length > 2 || value.length == 10) {
          removeError(error: kRestaurantDescriptionNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kRestaurantDescriptionNullError);
          return "";
        } else if (value.length < 2 || value.length < 10) {
          addError(error: kRestaurantDescriptionNullError);
          return "";
        }
        return null;
      },
      maxLines: 5,
      textAlign: TextAlign.justify,
      style: const TextStyle(color: Colors.black),
      cursorColor: kTextColor,
      decoration: const InputDecoration(
          hintText:
              "Description(*). Une petite description du restaurant, ou une raison social ou encore un slogan",
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          hintStyle: TextStyle(color: kTextColor)),
    );
  }

  TextFormField _buildRestaurantNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _restaurantNameController,
      onSaved: (newValue) => restaurantName = newValue!,
      onChanged: (value) {

        setState(() {
          newRestaurant?.name = value;
        });

        if (value.isNotEmpty) {
          removeError(error: kRestaurantNameNullError);
        } else if (value.length > 2) {
          removeError(error: kRestaurantNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kRestaurantNameNullError);
          return "";
        } else if (value.length <= 2) {
          addError(error: kRestaurantNameNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      cursorColor: kTextColor,
      decoration: const InputDecoration(
        hintText: "Nom du restaurant(*)",
        hintStyle: TextStyle(color: kTextColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
    );
  }

  TextFormField buildRestaurantContactFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _restaurantContactController,
      onSaved: (newValue) => restaurantContact = newValue!,
      onChanged: (value) {

        setState(() {
          newRestaurant?.phone = value;
        });

        if (value.isNotEmpty) {
          removeError(error: kRestaurantContactNullError);
        } else if (value.length >= 8 || value.length == 13) {
          removeError(error: kRestaurantContactNullError);
          return;
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kRestaurantContactNullError);
          return "";
        } else if (value.length < 8 || value.length > 13) {
          addError(error: kRestaurantContactNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      cursorColor: kTextColor,
      decoration: const InputDecoration(
          hintText: "Contact du restaurant(*)",
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          hintStyle: TextStyle(color: kTextColor)),
    );
  }

  TextFormField _buildRestaurantAddressLocationFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _restaurantLocalisationAddressController,
      onSaved: (newValue) => restaurantLocalisationAddress = newValue!,
      onChanged: (value) {

        setState(() {
          newRestaurant?.adresse = value;
        });

        if (value.isNotEmpty) {
          removeError(error: kRestaurantLocalisationNullError);
        } else if (value.length > 2) {
          removeError(error: kRestaurantLocalisationNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kRestaurantLocalisationNullError);
          return "";
        } else if (value.length <= 2) {
          addError(error: kRestaurantLocalisationNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      cursorColor: kPrimaryColor,
      decoration: const InputDecoration(
          hintText: "Adresse de localisation(*)",
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          hintStyle: TextStyle(color: kTextColor)),
    );
  }

  /*Widget bottomSheet(BuildContext context){
    return Container(
      height: 100,
      width: 100,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            "Choisissez une image pour le logo"
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                  onPressed: () => _selectRestaurantLogo(ImageSource.camera),
                  icon: const Icon(Icons.camera),
                  label: const Text("Caméra")),
              TextButton.icon(
                  onPressed: () => _selectRestaurantLogo(ImageSource.gallery),
                  icon: const Icon(Icons.image),
                  label: const Text("Gallerie"),)
            ],
          )
        ],
      ),
    );
  }*/
}

class LoginSignuoBtn extends StatelessWidget {
  const LoginSignuoBtn({
    super.key,
    required this.text,
    required this.press,
  });

  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        width: double.infinity,
        child: MaterialButton(
            height: 55.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            color: Colors.white,
            onPressed: press,
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 18.0,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
