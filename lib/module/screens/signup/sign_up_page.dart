import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Role/role_model.dart';
import 'package:digitalis_restaurant_app/core/model/Users/User.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/screens/login/widgets/background_image_login_signup.dart';
import 'package:digitalis_restaurant_app/module/screens/signup/widgets/register_form.dart';
import 'package:digitalis_restaurant_app/provider/auth_provider.dart';
import 'package:digitalis_restaurant_app/provider/role_provider.dart';
import 'package:digitalis_restaurant_app/widgets/custom_button.dart';
import 'package:digitalis_restaurant_app/widgets/custom_suffi_icon.dart';
import 'package:digitalis_restaurant_app/widgets/form_error.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String routeName = "/signup_form";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    RoleModel? selectedRole = Provider.of<RoleProvider>(context).selectedRole;
    final selectedRoleId = ModalRoute.of(context)?.settings.arguments as String?;
    print('Rore id depuis la page de connexion $selectedRoleId');
    GetStorage().write('userRoleId', selectedRoleId);
    return Stack(
      children: [
        const BackgroundImageLoginSignup(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: RegisterForm(selectedRole: selectedRole, selectedRoleId: selectedRoleId,),
        )
      ],
    );
  }


}

class LoginSignuoBtn extends StatelessWidget {
  const LoginSignuoBtn({
    super.key,
    required this.text,
    required this.press,
  });

  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        width: double.infinity,
        child: MaterialButton(
            height: 55.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            color: Colors.white,
            onPressed: press,
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 18.0,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
