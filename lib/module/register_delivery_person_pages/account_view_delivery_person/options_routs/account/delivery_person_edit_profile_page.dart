import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/account/delivery_person_edit_profile_page_body.dart';
import 'package:flutter/material.dart';

class DeliveryPersonEditProfilePage extends StatefulWidget {
  const DeliveryPersonEditProfilePage({super.key});

  static String routeName = "/delivery_person_edit_profile_page";

  @override
  State<DeliveryPersonEditProfilePage> createState() => _DeliveryPersonEditProfilePageState();
}

class _DeliveryPersonEditProfilePageState extends State<DeliveryPersonEditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Editer votre profil",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18.0,
            ),
          )
      ),
      body: const DeliveryPersonEditProfilePageBody(),
    );
  }
}
