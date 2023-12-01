import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/inputs/app_input_field.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class NewPasswordWidgetBody extends StatefulWidget {
  const NewPasswordWidgetBody({super.key});

  @override
  State<NewPasswordWidgetBody> createState() => _NewPasswordWidgetBodyState();
}

class _NewPasswordWidgetBodyState extends State<NewPasswordWidgetBody> {
  final _formkey = GlobalKey<FormState>();

  String? newPassword;
  String? confirmNePassword;

  bool _isObscurePassword = true;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    _newPasswordController.clear();
    _confirmNewPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            verticalSpaceMedium,
            AppText.headingOne("Nouveau mot de passe"),
            verticalSpaceMedium,
            verticalSpaceMedium,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Vous pouvez maintenant changer votre mot de passe',
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
              child: TextFormField(
                obscureText: _isObscurePassword,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: const Text("Nouveau mot de passe", style: TextStyle(color: Colors.grey),),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  border: InputBorder.none,
                  hintText: "Nouveau mot de passe",
                  hintStyle: const TextStyle(color: kcLightGreyColor),
                  suffixIcon: IconButton(onPressed: () {
                    setState(() {
                      _isObscurePassword =! _isObscurePassword;
                    });
                  }, icon: _isObscurePassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off))
                )
              ),
            ),
            verticalSpaceLarge,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: TextFormField(
                obscureText: _isObscurePassword,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: const Text("Confirmer le mot de passe", style: TextStyle(color: Colors.grey),),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    border: InputBorder.none,
                    hintText: "Nouveau mot de passe",
                    hintStyle: const TextStyle(color: kcLightGreyColor),
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _isObscurePassword =! _isObscurePassword;
                      });
                    }, icon: _isObscurePassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off))
                ),
              ),
            ),
            verticalSpaceMedium,
            verticalSpaceMedium,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                width: double.infinity,
                child: AppFilledButton(
                  text: "Suivant",
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {

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
