import 'package:digitalis_restaurant_app/module/account/orders/make_order_body.dart';
import 'package:flutter/material.dart';

class MakeOrderScreen extends StatelessWidget {
  const MakeOrderScreen({super.key});

  static String routeName = '/make_order_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Faire une commande",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
      ),
      body: const MakeOrderBody(),
    );
  }
}
