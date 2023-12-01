import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/inputs/app_input_field.dart';
import 'package:digitalis_restaurant_app/module/forgot_password/widgets/new_password_widgets/new_password_widget_page.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final _formkey = GlobalKey<FormState>();

  String? user_email;

  final TextEditingController _user_email_controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _user_email_controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            verticalSpaceMedium,
            AppText.headingOne("Votre adresse email"),
            verticalSpaceMedium,
            verticalSpaceMedium,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Renseignez-nous votre adresse email avant de passe à l\'étape suivante...',
                    style: TextStyle(
                      overflow: TextOverflow.visible,
                      fontSize: 20.0,
                      color: kTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            verticalSpaceLarge,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: AppInputField(
                title: 'Adresse email de connexion',
                hintText: 'email@gmail.com',
                keyboardType: TextInputType.emailAddress,
                controller: _user_email_controller,
                validator: (value) {
                  if (_user_email_controller.text.isEmpty) {
                    return "L'adresse email est obligatoire pour continuer";
                  }
                  return null;
                },
                suffixIcon: const Icon(Icons.email_outlined),
              ),
            ),
            verticalSpaceMedium,
            verticalSpaceMedium,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                width: double.infinity,
                child: AppFilledButton(
                  text: "Suivant",
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      Navigator.pushNamed(context, NewPasswordWidgetPage.routeName);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
