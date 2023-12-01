import 'package:badges/badges.dart';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/inputs/app_input_field.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_outline_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:badges/src/badge.dart' as badge;
import 'package:digitalis_restaurant_app/widgets/line.dart';
import 'package:flutter/material.dart';

class AddMealBody extends StatefulWidget {
  const AddMealBody({super.key});

  @override
  State<AddMealBody> createState() => _AddMealBodyState();
}

class _AddMealBodyState extends State<AddMealBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _mealTypeController = TextEditingController();
  final TextEditingController _mealPriceController = TextEditingController();
  final TextEditingController _mealDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              verticalSpaceMedium,
              AppText.headingThree(
                'Informations sur le repas',
                color: kOnBoardingBackgroundColor,
              ),
              verticalSpaceMedium,
              _buildMealHeader(),
              verticalSpaceMedium,
              Line(),
              verticalSpaceMedium,
              verticalSpaceMedium,
              _builMealNameFieldInput(),
              verticalSpaceRegular,
              _buildMealTypeFieldInput(),
              verticalSpaceRegular,
              _buildMealPriceFieldInput(),
              verticalSpaceRegular,
              _buildMealDescriptionFieldInput(),
              verticalSpaceRegular,
              verticalSpaceRegular,
               Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   SizedBox(
                     width: SizeConfig.screenWidth,
                     child: AppFilledButton(
                       text: "Sauvegarder les informations",
                       onPressed: () {

                       },
                     ),
                   ),
                   verticalSpaceRegular,
                   SizedBox(
                     width: SizeConfig.screenWidth,
                     child: AppOutlineButton(
                       text: 'Revenir en arrière',
                       onPressed: () {
                         Navigator.of(context).pop();
                       },
                     ),
                   )
                 ],
               )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealHeader() {
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
                        Icons.photo_camera,
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
                  "assets/images/img3.png",
                  height: 75,
                ),
              ),
              onTap: () {},
            ),
            horizontalSpaceLarge,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.headingThree(
                  'Meal Name',
                  color: kcBlackColor,
                ),
                verticalSpaceSmall,
                AppText.body('Meal Price'),
              ],
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _builMealNameFieldInput() {
    return AppInputField(
      title: 'Nom du plat',
      hintText: 'Riz + Frittes au poulet',
      controller: _mealNameController,
      validator: (value) {

      },
    );
  }
  
  Widget _buildMealTypeFieldInput() {
    return AppInputField(
      title: "Type du plat",
      hintText: "Plat Africains",
      controller: _mealTypeController,
      validator: (value) {

      },
    );
  }
  
  Widget _buildMealPriceFieldInput() {
    return AppInputField(
      title: "Prix du plat",
      hintText: "2500 FCFA",
      controller: _mealPriceController,
      validator: (value) {

      },
    );
  }
  
  Widget _buildMealDescriptionFieldInput() {
    return AppInputField(
      title: "Description du plat",
      hintText: "C'est un plat vraiment délicieux...etc...",
      controller: _mealDescriptionController,
      maxLines: 3,
      validator: (value) {

      },
    );
  }
}
