import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/forgot_password/forgot_password_page.dart';
import 'package:digitalis_restaurant_app/module/screens/login/widgets/background_image_login_signup.dart';
import 'package:digitalis_restaurant_app/provider/auth_provider.dart';
import 'package:digitalis_restaurant_app/widgets/custom_button.dart';
import 'package:digitalis_restaurant_app/widgets/custom_suffi_icon.dart';
import 'package:digitalis_restaurant_app/widgets/form_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String routeName = "/login_form";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool rememberMe = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.clear();
    _passwordController.clear();
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
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.07,
                  ),
                  const Text(
                    "Connectez-vous à votre compte restaurant",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
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
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Checkbox(
                                value: rememberMe,
                                activeColor: kPrimaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                },
                              ),
                            ),
                            const Text(
                              "Se souvenir de moi",
                              style: TextStyle(color: Colors.white70),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 17.0),
                              child: TextButton(
                                child: const Text("Mot de passe oublié",
                                style: TextStyle(
                                    color: Colors.white70,
                                    decoration: TextDecoration.underline),),
                                onPressed: () {
                                  Navigator.pushNamed(context, ForgotPasswordPage.routeName);
                                },
                              ),
                            )
                          ],
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
                              text: 'Se Connecter',
                              tap: () {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  auth.loginUser(
                                    context: context,
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                                } else if (_emailController.text.isEmpty ||
                                    _passwordController.text.isEmpty) {
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
                        /* LoginSignuoBtn(
                          text: "Connexion",
                          press: () {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            }
                          },
                        ), */
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty /* && errors.contains(kPassNullError) */) {
          removeError(error: kPassNullError);
          /* setState(() {
                removeError(error: kPassNullError);
              }); */
        } else if (value.length >=
            8 /* && errors.contains(kShortPassError) */) {
          removeError(error: kShortPassError);
          /* setState(() {
                removeError(error: kShortPassError);
              }); */
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty /* && !errors.contains(kPassNullError) */) {
          addError(error: kPassNullError);
          /* setState(() {
                addError(error: kPassNullError);
              }); */
          return "";
        } else if (value.length <
            8 /* && !errors.contains(kShortPassError) */) {
          addError(error: kShortPassError);
          /* setState(() {
                addError(error: kShortPassError);
              }); */
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      cursorColor: kPrimaryColor,
      decoration: const InputDecoration(
        hintText: "Votre Mot de Passe",
        hintStyle: TextStyle(color: Colors.white60),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 22, horizontal: 25),
        border: InputBorder.none,
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
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
        hintText: "Votre Adresse Email",
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
