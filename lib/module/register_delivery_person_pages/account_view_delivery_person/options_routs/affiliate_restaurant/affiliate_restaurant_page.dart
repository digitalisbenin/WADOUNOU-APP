import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/affiliate_restaurant/affiliate_restaurant_page_body.dart';
import 'package:flutter/material.dart';

class AffiliateRestaurantPage extends StatelessWidget {
  const AffiliateRestaurantPage({super.key});

  static String routeName = "/affiliate_restaurant_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Restaurant Affilié",
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
      body: const AffiliateRestaurantPageBody(),
    );
  }
}
