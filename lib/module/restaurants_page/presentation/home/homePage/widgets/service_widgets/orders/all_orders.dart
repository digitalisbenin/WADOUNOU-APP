import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/orders/widgets/all_user_orders.dart';
import 'package:flutter/material.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  static String routeName = '/order_list_page';

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kOnBoardingBackgroundColor,
        title: const Text('Mes Commandes', style: TextStyle(color: kWhite),),
        centerTitle: true,
      ),
      body: const AllUserOrdersBodyPage(),
    );
  }
}
