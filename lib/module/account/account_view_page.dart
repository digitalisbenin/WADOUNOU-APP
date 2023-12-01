import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/enums/menu_enums.dart';
import 'package:digitalis_restaurant_app/module/account/widgets/account_view_body.dart';
import 'package:digitalis_restaurant_app/widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

class AccountViewPage extends StatelessWidget {
  const AccountViewPage({super.key});

  static String routeName = "/account_view";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: kBackground,
          appBar: AppBar(
              title: const Text(
                "Profil",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
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
              ) */), 
              body: const AccountViewBody(),
              bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.profile,),
              ),
    );
  }
}
