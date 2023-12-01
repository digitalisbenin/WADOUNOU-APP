import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/widgets/account_view_delivery_person_body.dart';
import 'package:flutter/material.dart';

class AccountViewDeliveryPerson extends StatelessWidget {
  const AccountViewDeliveryPerson({super.key});

  static String routeName = "/account_view_delivery_person";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil Livreur",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        /* leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18.0,
          ),
        ) */
      ),
      body: AccountViewDeliveryPersonBody(),
    );
  }
}
