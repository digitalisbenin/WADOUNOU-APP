// ignore_for_file: dead_code

import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:flutter/material.dart';
class AppLogo extends StatelessWidget {
  final Function()? onTap;
  final double? width;
  final double? height;
  final Widget text;
  final bool showOnlyLogo;
  final LogoDirection logoDirection;
  final LogoType logoType;

  const AppLogo(
      {Key? key,
      this.width = 80,
      this.height = 80,
      this.text = const Text(
        'Smart Dining',
        style: TextStyle(
            color: kcWhiteColor, fontSize: 24, fontWeight: FontWeight.w400),
      ),
      this.onTap,
      this.showOnlyLogo = false,
      this.logoDirection = LogoDirection.vertical,
      this.logoType = LogoType.primary})
      : super(key: key);

  const AppLogo.smallWhite(
      {Key? key,
      this.width = 50,
      this.height = 50,
      this.text = const Text(
        'Smart Dining',
        style: TextStyle(
            color: kcWhiteColor, fontSize: 24, fontWeight: FontWeight.w400),
      ),
      this.onTap,
      this.showOnlyLogo = false,
      this.logoDirection = LogoDirection.vertical,
      this.logoType = LogoType.white});

  const AppLogo.mediumWhite(
      {Key? key,
      this.width = 80,
      this.height = 80,
      this.text = const Text(
        'Smart Dining',
        style: TextStyle(
            color: kcWhiteColor, fontSize: 32, fontWeight: FontWeight.w400),
      ),
      this.onTap,
      this.showOnlyLogo = false,
      this.logoDirection = LogoDirection.vertical,
      this.logoType = LogoType.primary});

  const AppLogo.largeWhite(
      {Key? key,
      this.width = 100,
      this.height = 100,
      this.text = const Text(
        'Smart Dining',
        style: TextStyle(
            color: kcWhiteColor, fontSize: 38, fontWeight: FontWeight.w400),
      ),
      this.onTap,
      this.showOnlyLogo = false,
      this.logoDirection = LogoDirection.vertical,
      this.logoType = LogoType.primary});

  const AppLogo.smallPrimary(
      {Key? key,
      this.width = 50,
      this.height = 50,
      this.text = const Text(
        'Smart Dining',
        style: TextStyle(
            color: kcPrimaryColor, fontSize: 24, fontWeight: FontWeight.w400),
      ),
      this.onTap,
      this.showOnlyLogo = false,
      this.logoDirection = LogoDirection.vertical,
      this.logoType = LogoType.primary});

  const AppLogo.mediumPrimary(
      {Key? key,
      this.width = 80,
      this.height = 80,
      this.text = const Text(
        'Smart Dining',
        style: TextStyle(
            color: kcPrimaryColor, fontSize: 32, fontWeight: FontWeight.w400),
      ),
      this.onTap,
      this.showOnlyLogo = false,
      this.logoDirection = LogoDirection.vertical,
      this.logoType = LogoType.primary});

  const AppLogo.largePrimary(
      {Key? key,
      this.width = 100,
      this.height = 100,
      this.text = const Text(
        'Smart Dining',
        style: TextStyle(
            color: kcPrimaryColor, fontSize: 38, fontWeight: FontWeight.w400),
      ),
      this.onTap,
      this.showOnlyLogo = false,
      this.logoDirection = LogoDirection.vertical,
      this.logoType = LogoType.primary});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: showOnlyLogo ? _getLogo() : _orientatedLogo(),
    );
  }

  _getLogo() {
    switch (logoType) {
      case LogoType.primary:
        return Image.asset(""); /* Assets.images.branding.logoPurple
            .svg(height: height, width: width); */
        break;
      case LogoType.white:
        return Image.asset(""); /* Assets.images.branding.logoWhite
            .svg(height: height, width: width); */
        break;
    }
  }

  _orientatedLogo() {
    switch (logoDirection) {
      case LogoDirection.horizontal:
        return Row(
          children: [
           // Assets.images.branding.logoWhite.svg(height: height, width: width),
            horizontalSpaceSmall,
            text,
          ],
        );
        break;
      case LogoDirection.vertical:
        return Column(
          children: [
           // Assets.images.branding.logoWhite.svg(height: height, width: width),
            verticalSpaceSmall,
            text,
          ],
        );
        break;
    }
  }
}

enum LogoDirection { horizontal, vertical }

enum LogoType { primary, white }
