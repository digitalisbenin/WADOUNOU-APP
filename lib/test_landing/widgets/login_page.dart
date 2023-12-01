/* import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/widgets/custom_suffi_icon.dart';
import 'package:digitalis_restaurant_app/widgets/form_error.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;
  String? confirm_password;
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
        /* BackgroundImage(), */
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.white, Colors.black26],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center)
              .createShader(bounds),
          blendMode: BlendMode.darken,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/feeme_mange.jpg'),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black12, BlendMode.darken))),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50.0,
                          ),
                          Text('WADOUNOU',
                              style: GoogleFonts.pacifico(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Container(
                            color: Colors.white,
                            width: 150,
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "Connectez-vous à votre compte",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee(
                        fontSize: 28.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
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
                              child: buildEmailFormField()),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[600]!.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: buildNameFormField()),
                        ),
                        SizedBox(
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
                        SizedBox(
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
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: MaterialButton(
                              height: 55.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)),
                                color: Colors.white,
                                onPressed: () {
                                  /* Navigator.pushNamed(context, HomeScreen.routeName); */
                                },
                                child: Text(
                                  "Inscription",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18.0,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
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
  TextFormField buildNameFormField() {
    return TextFormField(
      onChanged: (value) {
        if (value.isNotEmpty /* && errors.contains(kPassNullError) */) {
          removeError(error: kNamelNullError);
        } else if (value.length >= 3 /* && errors.contains(kShortPassError) */) {
          removeError(error: kNamelNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty /* && !errors.contains(kPassNullError) */) {
          addError(error: kNamelNullError);
          return "";
        } else if (value.length < 3 /* && !errors.contains(kShortPassError) */) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      cursorColor: kPrimaryColor,
      decoration: const InputDecoration(
        hintText: "Enter your password",
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
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
        hintText: "Enter your password",
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
      onSaved: (newValue) => email = newValue,
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
        hintText: "Enter your email",
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
 */