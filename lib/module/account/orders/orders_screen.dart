import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/enums/menu_enums.dart';
import 'package:digitalis_restaurant_app/module/account/orders/pending_orders/doned_orders_view_page.dart';
import 'package:digitalis_restaurant_app/module/account/orders/waiting_orders/orders_page_view.dart';
import 'package:digitalis_restaurant_app/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

class OrdersScreens extends StatelessWidget {
  const OrdersScreens({super.key});

  static String routeName = '/orders_screen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       return false;
      },
      child: DefaultTabController(
        length: 2, // Nombre d'onglets
        child: Scaffold(
          backgroundColor: kBackground,
          appBar: AppBar(
            title: const Text(
              "Commandes",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              onTap: (index) {
                print(index);
              },
              indicatorColor: kPrimaryColor,
              labelColor: kTextColor,
              mouseCursor: SystemMouseCursors.click,
              tabs: [
                Tab(
                  text: "En Cours (0)".toUpperCase(),
                ),
                Tab(
                  text: 'Terminée(s) (0)'.toUpperCase(),
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              OrdersPageView(),
              DonedOrdersViewPage(),
            ],
          ),
          bottomNavigationBar:
              const CustomBottomNavBar(selectedMenu: MenuState.orders),
        ),
      ),
    );
  }
}