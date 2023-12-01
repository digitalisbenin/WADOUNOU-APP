import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/inputs/app_input_field.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:digitalis_restaurant_app/widgets/line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditRestaurantInfoBody extends StatefulWidget {
  const EditRestaurantInfoBody({super.key});

  @override
  State<EditRestaurantInfoBody> createState() => _EditRestaurantInfoBodyState();
}

class _EditRestaurantInfoBodyState extends State<EditRestaurantInfoBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _editingRestaurantNameController = TextEditingController();
  final TextEditingController _editingRestaurantLocationController = TextEditingController();
  final TextEditingController _editingRestaurantPhoneNumberController = TextEditingController();
  final TextEditingController _editingRestaurantDescriptionController = TextEditingController();
  
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
                'Informations sur le restaurant',
                color: kOnBoardingBackgroundColor,
              ),
              verticalSpaceMedium,
              _buildHeader(),
              verticalSpaceMedium,
                Line(),
                verticalSpaceMedium,
                verticalSpaceMedium,
                _buildRestaurantNameInput(),
                verticalSpaceRegular,
                _buildRestaurantLocationInput(),
                verticalSpaceRegular,
                _buildRestaurantPhoneNumberInput(),
                verticalSpaceRegular,
                _buildRestaurantDescriptionInput(),
                verticalSpaceRegular,
                verticalSpaceRegular,
                Column(
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
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantDescriptionInput() {
    return AppInputField(
      title: 'Description',
      hintText: 'Description, Raison Sociale ou Slogan',
      maxLines: 3,
      controller: _editingRestaurantDescriptionController,
      /* validator: (value) {

      }, */
    );
  }

  Widget _buildRestaurantPhoneNumberInput() {
    return AppInputField(
      title: 'Contact du restaurant',
      keyboardType: TextInputType.phone,
      hintText: 'Contact du restaurant',
      controller: _editingRestaurantPhoneNumberController,
    );
  }

  AppInputField _buildRestaurantLocationInput() {
    return AppInputField(
      title: 'Adresse du restaurant',
      hintText: 'Adresse',
      keyboardType: TextInputType.streetAddress,
      controller: _editingRestaurantLocationController,
    );
  }

  Widget _buildRestaurantNameInput() {
    return AppInputField(
      title: 'Nom du restaurant',
      hintText: 'Nom du restaurant',
      controller: _editingRestaurantNameController,
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
              child: badges.Badge(
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
                  "assets/images/res_logo.png",
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
                  'Restaurant Name',
                  color: kcBlackColor,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}