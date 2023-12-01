import 'package:digitalis_restaurant_app/module/forgot_password/widgets/new_password_widgets/widgets/new_password_widget_body.dart';
import 'package:flutter/material.dart';

class NewPasswordWidgetPage extends StatelessWidget {
  const NewPasswordWidgetPage({super.key});

  static String routeName = '/new_password_widget';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mot de passe oublié",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
         leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18.0,
          ),
        )
      ),
      body: NewPasswordWidgetBody(),
    );
  }
}
