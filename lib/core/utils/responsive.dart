import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';

enum DisplayType { phone, tablet }

// // Getx util
// DisplayType getDisplayType({ResponsiveScreen? screen}) {
//   ResponsiveScreen _screen = screen ?? Get.context!.responsiveValue();
//
//   if (_screen.isWatch) {
//     return DisplayType.phone;
//   }
//
//   if (_screen.isPhone) {
//     return DisplayType.phone;
//   }
//
//   if (_screen.isTablet) {
//     return DisplayType.tablet;
//   }
//
//   if (_screen.isDesktop) {
//     return DisplayType.tablet;
//   }
//
//   return DisplayType.phone;
// }

// ResponsiveBuilder util

DisplayType getDeviceScreenType(SizingInformation si) {
  switch (si.deviceScreenType) {
    case DeviceScreenType.Mobile:
      return DisplayType.phone;
      break;
    case DeviceScreenType.Tablet:
      return DisplayType.tablet;
      break;
    case DeviceScreenType.Desktop:
      return DisplayType.tablet;
      break;
    case DeviceScreenType.Watch:
      return DisplayType.phone;
      break;
    case DeviceScreenType.mobile:
      return DisplayType.phone;
      break;
    case DeviceScreenType.tablet:
      return DisplayType.tablet;
      break;
    case DeviceScreenType.desktop:
      return DisplayType.tablet;
      break;
    case DeviceScreenType.watch:
      return DisplayType.phone;
      break;
  }
}

bool isPhone(BuildContext context) {
  return getValueForScreenType<bool>(
          context: context, mobile: true, tablet: false, desktop: false)
      ? true
      : false;
}

Widget getScreenWidget(BuildContext context,
    {required Widget phoneWidget, required Widget tabletWidget}) {
  return getValueForScreenType<bool>(
          context: context, mobile: true, tablet: false, desktop: false)
      ? phoneWidget
      : tabletWidget;
}

dynamic getScreenDynamicWidget(BuildContext context,
    {required dynamic phoneWidget, required dynamic tabletWidget}) {
  return getValueForScreenType<bool>(
          context: context, mobile: true, tablet: false, desktop: false)
      ? phoneWidget
      : tabletWidget;
}
