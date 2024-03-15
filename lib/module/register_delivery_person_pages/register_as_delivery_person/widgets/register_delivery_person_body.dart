import 'dart:io';

import 'package:badges/badges.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/register_as_delivery_person/widgets/register_delivery_person_success.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:digitalis_restaurant_app/widgets/form_error.dart';
import 'package:badges/badges.dart' as badge;
import 'package:digitalis_restaurant_app/widgets/line.dart';
import 'package:flutter/material.dart';

class RegisterDeliveryPersonForm extends StatefulWidget {
  const RegisterDeliveryPersonForm({super.key});

  @override
  State<RegisterDeliveryPersonForm> createState() =>
      _RegisterDeliveryPersonFormState();
}

class _RegisterDeliveryPersonFormState
    extends State<RegisterDeliveryPersonForm> {
  final _formkey = GlobalKey<FormState>();
  String? deliveryPersonName;
  String? deliveryPersonAddress;
  File? deliveryPersonImagePath;
  String? deliveryPersonPhoneNumber;
  String? deliveryPersonEmailAddress;
  String? aboutDeliveryPerson;
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

  // Gestion du temps de chargement vers la page suivante

  Future<void> startLoading() async {
    setState(() {
      isLoading = true;
    });

    // Simuler le temps de chargement de 6 secondes
    await Future.delayed(const Duration(seconds: 10));

    setState(() {
      isLoading = false;
    });

    // une fois le chargement terminé, naviguez vers la page de succès !
    Navigator.of(context).pushNamed(RegisterDeliveryPersonSuccess.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                verticalSpaceMedium,
                AppText.headingThree(
                  'Dites nous qui êtes !',
                  color: kOnBoardingBackgroundColor,
                ),
                verticalSpaceMedium,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildMealHeader(),
                ),
                verticalSpaceMedium,
                Line(),
                verticalSpaceMedium,
                verticalSpaceMedium,
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 1.0),
                  child: _buildDeliveryPersonNameFormField(),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 1.0),
                  child: _buildDeliveryPersonAdressLocationFormField(),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 1.0),
                  child: _buildDeliveryPersonPhoneNumberFormField(),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 1.0),
                  child: _buildDeliveryPersonEmailFormField(),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 1.0),
                  child: _buildAboutDeliveryPersonFormField(),
                ),
                FormError(errors: errors),
                if (isLoading)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: const Center(
                          child: CircularProgressIndicator(color: kPrimaryColor,),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        "Nous vous enregistrons, veuillez patienter...",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppFilledButton(
                      text: "Sauvegarder les informations",
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          await startLoading();
                        }
                      },
                    ),
                  ),
                  /*DefaultButton(
                          text: "Suivant",
                          press: () async {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();
                              await startLoading();
                            }
                          },
                        ),*/
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildMealHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              child: badge.Badge(
                badgeContent: const SizedBox(
                  height: 10,
                  width: 10,
                  child: Center(
                    child: FittedBox(
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                badgeStyle: const BadgeStyle(
                  badgeColor: kPrimaryColor,
                ),
                position: BadgePosition.bottomEnd(bottom: 1.2, end: 1),
                child: Image.asset(
                  "assets/images/img_avatar.png",
                  height: 75,
                ),
              ),
              onTap: () {},
            ),
            horizontalSpaceLarge,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.headingThree(
                  'Nom du livreur',
                  color: kcBlackColor,
                ),
                verticalSpaceSmall,
                AppText.body('email'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  TextFormField _buildDeliveryPersonEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => deliveryPersonEmailAddress = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty /* && errors.contains(kEmailNullError) */) {
          removeError(error: kEmailNullError);
          /* setState(() {
            removeError(error: kEmailNullError);
          }); */
          //  return;
        } else if (emailValidatorRegExp.hasMatch(
                value) /* &&
            errors.contains(kInvalidEmailError) */
            ) {
          removeError(error: kInvalidEmailError);
          /*  setState(() {
            removeError(error: kInvalidEmailError);
          }); */
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty /* && !errors.contains(kEmailNullError) */) {
          addError(error: kEmailNullError);
          /* setState(() {
            addError(error: kEmailNullError);
          }); */
          return "";
        } else if (!emailValidatorRegExp.hasMatch(
                value) /* &&
            !errors.contains(kInvalidEmailError) */
            ) {
          addError(error: kInvalidEmailError);
          /* setState(() {
            addError(error: kInvalidEmailError);
          }); */
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "Votre adresse email (*)",
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField _buildAboutDeliveryPersonFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => aboutDeliveryPerson = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDeliveryPersonAboutInfoNullError);
        } else if (value.length > 2 || value.length == 10) {
          removeError(error: kDeliveryPersonAboutInfoNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kDeliveryPersonAboutInfoNullError);
          return "";
        } else if (value.length < 2 || value.length < 10) {
          addError(error: kDeliveryPersonAboutInfoNullError);
          return "";
        }
        return null;
      },
      maxLines: 5,
      textAlign: TextAlign.justify,
      style: const TextStyle(color: Colors.black),
      cursorColor: kTextColor,
      decoration: const InputDecoration(
          hintText: "Dites-nous quelque chose sur vous",
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          hintStyle: TextStyle(color: kTextColor)),
    );
  }

  TextFormField _buildDeliveryPersonNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => deliveryPersonName = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDeliveryPersonNullError);
        } else if (value.length > 2) {
          removeError(error: kDeliveryPersonNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kDeliveryPersonNullError);
          return "";
        } else if (value.length <= 2) {
          addError(error: kDeliveryPersonNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      cursorColor: kTextColor,
      decoration: const InputDecoration(
        hintText: "Nom et Prénom(s) (*)",
        hintStyle: TextStyle(color: kTextColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
      ),
    );
  }

  TextFormField _buildDeliveryPersonPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => deliveryPersonPhoneNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDeliveryPersonPhoneNumberNullError);
        } else if (value.length >= 8 || value.length == 13) {
          removeError(error: kDeliveryPersonPhoneNumberNullError);
          return;
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kDeliveryPersonPhoneNumberNullError);
          return "";
        } else if (value.length < 8 || value.length > 13) {
          addError(error: kDeliveryPersonPhoneNumberNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      cursorColor: kTextColor,
      decoration: const InputDecoration(
          hintText: "Numéro de téléphone",
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          hintStyle: TextStyle(color: kTextColor)),
    );
  }

  TextFormField _buildDeliveryPersonAdressLocationFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => deliveryPersonAddress = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDeliveryPersonAdressLocationNullError);
        } else if (value.length > 2) {
          removeError(error: kDeliveryPersonAdressLocationNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kDeliveryPersonAdressLocationNullError);
          return "";
        } else if (value.length <= 2) {
          addError(error: kDeliveryPersonAdressLocationNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      cursorColor: kPrimaryColor,
      decoration: const InputDecoration(
          hintText: "Adresse de domicile (*)",
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          hintStyle: TextStyle(color: kTextColor)),
    );
  }
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
