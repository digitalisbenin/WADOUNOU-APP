import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/appbar_widget.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/pop_up_menu.dart';
import 'package:flutter/material.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppBarWidget(),
          
          /* IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () {
              // Navigator.pushNamed(context, CartScreen.routeName)
            },
          ), */
          PopUpMenu()
        ],
      ),
    );
  }
}