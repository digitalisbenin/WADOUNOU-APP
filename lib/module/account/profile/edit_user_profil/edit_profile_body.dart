import 'package:badges/badges.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/inputs/app_input_field.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_outline_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:digitalis_restaurant_app/widgets/line.dart';
import 'package:badges/src/badge.dart' as badge;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({super.key});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _editingFullnameController = TextEditingController();
  final TextEditingController _editingEmailController = TextEditingController();
  final TextEditingController _editingPhoneNumberController = TextEditingController();
  final TextEditingController _editingAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceMedium,
              AppText.headingThree(
                'Informations Personnelles',
                color: kOnBoardingBackgroundColor,
              ),
              verticalSpaceMedium,
              _buildHeader(),
              verticalSpaceMedium,
              Line(),
              verticalSpaceMedium,
              verticalSpaceMedium,
              _buildFullnameInput(),
              verticalSpaceRegular,
              _buildEmailInput(),
              verticalSpaceRegular,
              _buildPhoneNumberInput(),
              verticalSpaceRegular,
              _buildAddressInput(),
              verticalSpaceRegular,
              verticalSpaceRegular,
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: SizeConfig.screenWidth,
                      child: AppFilledButton(
                        text: "Sauvegarder",
                        onPressed: () {

                        },
                      ),
                    ),
                    verticalSpaceRegular,
                    SizedBox(
                      width: SizeConfig.screenWidth,
                      child: AppOutlineButton(
                        text: 'Changer de mot de passe',
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressInput() {
    return AppInputField(
      title: 'Votre adresse',
      hintText: 'Adresse',
      keyboardType: TextInputType.streetAddress,
      controller: _editingAddressController,
    );
  }

  Widget _buildPhoneNumberInput() {
    return AppInputField(
      title: 'Numéro de Téléphone',
      keyboardType: TextInputType.phone,
      hintText: 'Numéro de Téléphone',
      controller: _editingPhoneNumberController,
    );
  }

  Widget _buildEmailInput() {
    return AppInputField(
      title: 'Votre Email (optionelle)',
      hintText: 'Email',
      keyboardType: TextInputType.emailAddress,
      controller: _editingEmailController,
    );
  }

  Widget _buildFullnameInput() {
    return AppInputField(
      title: 'Nom Complet',
      hintText: 'Nom Complet',
      controller: _editingFullnameController,
      /* validator: (value) {

      }, */
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              child: badge.Badge(
                badgeContent: const SizedBox(
                  height: 10,
                  width: 10,
                  child: Center(
                    child: FittedBox(
                      child: Icon(
                        CupertinoIcons.camera,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                badgeStyle: const BadgeStyle(
                  badgeColor: kPrimaryColor,
                ),
                position: BadgePosition.bottomEnd(bottom: 1.2, end: 1),
                child: Image.asset(
                  "assets/images/img_avatar.png",
                  height: 80,
                ),
              ),
              onTap: () {},
            ),
            horizontalSpaceRegular,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.headingThree(
                  'Username',
                  color: kcBlackColor,
                ),
                verticalSpaceSmall,
                AppText.body('User email')
              ],
            ),
          ],
        ),
      ],
    );
  }
}
