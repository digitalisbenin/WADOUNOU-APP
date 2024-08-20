import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/deliver/widgets/all_delivery_page.dart';
import 'package:flutter/material.dart';

class AllDeliverScreens extends StatefulWidget {
  const AllDeliverScreens({super.key});

  static String routeName = 'delivery-list';

  @override
  State<AllDeliverScreens> createState() => _AllDeliverScreensState();
}

class _AllDeliverScreensState extends State<AllDeliverScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOnBoardingBackgroundColor,
        title: const Text('Mes Livraisons', style: TextStyle(color: kWhite),),
        centerTitle: true,
      ),
      body: AllDeliveryBodyPage(),
    );
  }
}
