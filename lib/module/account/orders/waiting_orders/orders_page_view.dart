import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/account/orders/waiting_orders/widget/orders_page_listview.dart';
import 'package:flutter/material.dart';

class OrdersPageView extends StatefulWidget {
  const OrdersPageView({super.key});

  static String routeName = '/orders_page_view';

  @override
  State<OrdersPageView> createState() => _OrdersPageViewState();
}

class _OrdersPageViewState extends State<OrdersPageView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackground,
      body: OrdersPageListView(),
    );
  }
}
