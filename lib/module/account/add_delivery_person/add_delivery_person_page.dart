import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Deliver_person/deliver_person.dart';
import 'package:digitalis_restaurant_app/module/account/add_delivery_person/widgets/add_delivery_person_body.dart';
import 'package:flutter/material.dart';

class AddDeliveryPersonPage extends StatelessWidget {
  const AddDeliveryPersonPage({super.key});

  static String routeName = '/add_delivery_person';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
            title: const Text(
              "Ajouter des livreurs",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18.0,
              ),
            )),
            body: AddDeliveryPersonBody(
              deliverPerson: demoDeliverPerson[0],
              press: () {
                
              },
            ),
    );
  }
}