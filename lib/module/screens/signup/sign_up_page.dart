import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Users/User.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/screens/login/widgets/background_image_login_signup.dart';
import 'package:digitalis_restaurant_app/provider/auth_provider.dart';
import 'package:digitalis_restaurant_app/widgets/custom_button.dart';
import 'package:digitalis_restaurant_app/widgets/custom_suffi_icon.dart';
import 'package:digitalis_restaurant_app/widgets/form_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String routeName = "/signup_form";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();

  Users? newUser;

  String? name;
  String? email;
  String? password;
  String? confirm_password;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirm_passwordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirm_passwordController.clear();
  }

  final List<String> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImageLoginSignup(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/WADOUNOU 01.png',
                    height: SizeConfig.screenHeight * 0.25,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.1,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.002,
                          ),
                          const Text('WADOUNOU',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Container(
                            color: Colors.white,
                            width: 150,
                            height: 3.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    "Inscrivez-vous afin d'ajouter votre restaurant à notre répertoire",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[600]!.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: buildUserNameFormField()),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[600]!.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: buildEmailFormField()),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[600]!.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: buildPasswordFormField()),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[600]!.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: buildConfirmPasswordFormField()),
                        ),
                        FormError(errors: errors),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Consumer<AuthenticationProvider>(
                            builder: (context, auth, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (auth.resMessage != '') {
                              showMessage(
                                  message: auth.resMessage, context: context);
                              auth.clear();
                            }
                          });
                          return customButton(
                              text: 'S\'inscrire',
                              tap: () {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  auth.registerUser(
                                    name: _nameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    context: context,
                                  );
                                } else if (_nameController.text.isEmpty ||
                                    _emailController.text.isEmpty ||
                                    _passwordController.text.isEmpty ||
                                    _confirm_passwordController.text.isEmpty) {
                                  showMessage(
                                    message:
                                        'Tout les champs sont obligatoires',
                                    context: context,
                                  );
                                }
                              },
                              context: context,
                              status: auth.isLoading);
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      controller: _confirm_passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      onSaved: (newValue) => confirm_password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirm_password) {
          removeError(error: kMatchPassError);
        }
        confirm_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (password != value) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: "Confirmez le mot de passe",
        hintStyle: TextStyle(color: Colors.white60),
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CustomSuffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 25),
        border: InputBorder.none,
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => name = newValue!,
      onChanged: (value) {
        setState(() {
          newUser?.name = value;
        });

        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        } else if (value.length > 2) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        } else if (value.length <= 2) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      cursorColor: kPrimaryColor,
      decoration: const InputDecoration(
        hintText: "Nom et Prénom(s)",
        hintStyle: TextStyle(color: Colors.white60),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 25),
        border: InputBorder.none,
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CustomSuffixIcon(svgIcon: "assets/icons/User Icon.svg"),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        setState(() {
          newUser?.password = value;
        });

        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: "Mot de passe",
        hintStyle: TextStyle(color: Colors.white60),
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CustomSuffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 25),
        border: InputBorder.none,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        setState(() {
          newUser?.email = value;
        });

        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      cursorColor: kPrimaryColor,
      decoration: const InputDecoration(
        hintText: "Saisissez votre email",
        hintStyle: TextStyle(color: Colors.white60),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 25),
        border: InputBorder.none,
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
        ),
      ),
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
