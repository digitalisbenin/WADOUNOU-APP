import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/inputs/app_input_field.dart';
import 'package:digitalis_restaurant_app/module/forgot_password/widgets/new_password_widgets/new_password_widget_page.dart';
import 'package:digitalis_restaurant_app/provider/forgot_password_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final _formkey = GlobalKey<FormState>();

  String? user_email;

  final TextEditingController _userEmailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _userEmailController.clear();
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
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppInputField(
                title: 'Adresse email de connexion',
                hintText: 'email@gmail.com',
                keyboardType: TextInputType.emailAddress,
                controller: _userEmailController,
                validator: (value) {
                  if (_userEmailController.text.isEmpty) {
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
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                width: double.infinity,
                child: Consumer<ForgotPasswordProvider>(
                    builder: (context, snapshot, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (snapshot.resMessage != '') {
                      showMessage(
                          message: snapshot.resMessage, context: context);
                      snapshot.clear();
                    }
                  });
                  return AppFilledButton(
                    text: "Suivant",
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        snapshot.sendEmailForResetPassword(
                          context: context,
                            email: _userEmailController.text.trim());
                      } else if (_userEmailController.text.isEmpty) {
                        showMessage(
                          message:
                          'L\'email est obligatoire',
                          context: context,
                        );
                      }
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
