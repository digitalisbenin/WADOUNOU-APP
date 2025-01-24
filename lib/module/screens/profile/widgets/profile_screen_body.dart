import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/snack_message.dart';
import 'package:digitalis_restaurant_app/module/forgot_password/forgot_password_page.dart';
import 'package:digitalis_restaurant_app/module/screens/login/login_page.dart';
import 'package:digitalis_restaurant_app/module/screens/signup/sign_up_page.dart';
import 'package:digitalis_restaurant_app/module/selected_role_page/selected_role_screen.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/landing/presentation/landing_screen.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:digitalis_restaurant_app/provider/modify_user_profile_provider.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  final _formKey = GlobalKey<FormState>();

  final nomUser = GetStorage().read('userName') ?? '';
  final token = GetStorage().read('token');
  final mailUser = GetStorage().read('userMail') ?? '';

  String? globalRoleId;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    globalRoleId = GetStorage().read('role_id');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _userNameController =
        TextEditingController(text: nomUser);
    final TextEditingController _userEmailController =
        TextEditingController(text: mailUser);

    return SingleChildScrollView(
      child: Column(
        children: [
          if (((GetStorage().read('token')) != null &&
                  (GetStorage().read('token')).isNotEmpty) ||
              globalRoleId != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    GetStorage().remove('role_id');
                    GetStorage().remove('token');
                    DatabaseProvider().logOut(context);
                    PageNavigator(ctx: context)
                        .nextPageOnly(page: const LandingScreen());
                  },
                  child: const Text(
                    'Se Déconnecter',
                    style: TextStyle(color: kPrimaryColor, fontSize: 12.5),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, ForgotPasswordPage.routeName);
                //   },
                //   child: const Text(
                //     'Changer de mot de passe',
                //     style: TextStyle(color: kPrimaryColor, fontSize: 12.5),
                //   ),
                // ),
                Divider(
                  height: 4,
                  color: kSecondaryColor.withOpacity(0.3),
                  thickness: 4,
                  indent: SizeConfig.screenWidth * 0.025,
                  endIndent: SizeConfig.screenWidth * 0.025,
                )
              ],
            ),
          if (((GetStorage().read('token')) != null &&
                  (GetStorage().read('token')).isNotEmpty) ||
              globalRoleId != null)
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
          if (((GetStorage().read('token')) != null &&
                  (GetStorage().read('token')).isNotEmpty) ||
              globalRoleId != null)
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Paramètres de votre compte",
                    style:
                        TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
                  // OutlinedButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       isEditing = !isEditing;
                  //     });
                  //   },
                  //   child: isEditing
                  //       ? const Text(
                  //           "Annuler",
                  //           style: TextStyle(color: kPrimaryColor),
                  //         )
                  //       : const Text(
                  //           "Modifier",
                  //           style: TextStyle(color: kPrimaryColor),
                  //         ),
                  // ),
                ],
              ),
            ),
          if (((GetStorage().read('token')) != null &&
                  (GetStorage().read('token')).isNotEmpty) ||
              globalRoleId != null)
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(
                          'Nom complet',
                          style: TextStyle(fontSize: 10.0),
                        ),
                        hintText: 'Entrez votre nom',
                        hintStyle: TextStyle(color: kTextColor, fontSize: 10.0),
                      ),
                      controller: _userNameController,
                      enabled: isEditing,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(
                          'Email',
                          style: TextStyle(fontSize: 10.0),
                        ),
                        hintText: 'Entrez adresse email',
                        hintStyle: TextStyle(color: kTextColor, fontSize: 10.0),
                      ),
                      controller: _userEmailController,
                      enabled: isEditing,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.01,
                    ),
                    Consumer<ModifyUserProfile>(
                        builder: (context, update, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (update.resMessage != '') {
                          showMessage(
                              message: update.resMessage, context: context);
                          update.clear();
                        }
                      });
                      return TextButton(
                        onPressed: isEditing
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // Logique de soumission du formulaire
                                  if (_userEmailController.text.isEmpty ||
                                      _userEmailController.text.isEmpty) {
                                    showMessage(
                                      message:
                                          'Tout les champs sont obligatoires',
                                      context: context,
                                    );
                                  } else {
                                    GetStorage().write('userName', _userNameController.text);
                                    GetStorage().write('userMail', _userEmailController.text);
                                    update.updateUserInfo(
                                        username:
                                            _userNameController.text.trim(),
                                        userEmail:
                                            _userEmailController.text.trim(),
                                        context: context);
                                  }
                                }
                              }
                            : null,
                        child: Text(
                          ''.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w700),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          if ((GetStorage().read('token')) == null || globalRoleId == null)
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: AppFilledButton(
                        text: "Se connecter",
                        onPressed: () {
                          PageNavigator(ctx: context)
                              .nextPageOnly(page: const LoginPage());
                        },
                        color: kWhite,
                        txtColor: kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  const Text(
                    "ou",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: AppFilledButton(
                        text: "S'inscrire",
                        onPressed: () {
                          PageNavigator(ctx: context)
                              .nextPageOnly(page: const SelectedRoleScreen());
                        },
                        color: kPrimaryColor,
                        txtColor: kWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
