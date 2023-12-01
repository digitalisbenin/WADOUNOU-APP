import 'package:digitalis_restaurant_app/core/constants/app_color_constants.dart';
import 'package:digitalis_restaurant_app/core/utils/date_time_utils.dart';
import 'package:digitalis_restaurant_app/core/utils/responsive.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppDateSwitcher extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime selectedDate) onDateChange;
  final Function() onBackPressed;
  final Function() onNextPressed;
  final DateTime? minTime;
  final DateTime? maxTime;

  const AppDateSwitcher(
      {Key? key,
      required this.selectedDate,
      required this.onDateChange,
      required this.onBackPressed,
      required this.onNextPressed,
      this.minTime,
      this.maxTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getScreenWidget(context,
        phoneWidget: _mobileView(), tabletWidget: _tabletView());
  }

  Widget _tabletView() {
    var displayPastDateButton = true;
    var displayFutureDateButton = true;
    var comp = minTime!.compareTo(selectedDate);
    if (minTime != null) {
      if (minTime!.year == selectedDate.year &&
          minTime!.month == selectedDate.month &&
          minTime!.day == selectedDate.day) {
        displayPastDateButton = false;
      }
    }

    if (maxTime != null) {
      if (maxTime!.year == selectedDate.year &&
          maxTime!.month == selectedDate.month &&
          maxTime!.day == selectedDate.day) {
        displayFutureDateButton = false;
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        color: kcUltraLightGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          displayPastDateButton
              ? FloatingActionButton.small(
                  heroTag: 'backArrow',
                  backgroundColor: Colors.white,
                  onPressed: () {
                    onBackPressed();
                  },
                  child: Icon(Icons.arrow_back_ios, color: kcDarkGreyColor),
                )
              : SizedBox(),
          horizontalSpaceSmall,
          AppText.body(DateTimeUtils.readableDateDDMMYY(selectedDate)),
          horizontalSpaceSmall,
          InkWell(
              onTap: () {
                showDatePicker();
              },
              child: SvgPicture.asset("assets/icons/calender_date.svg")),
          horizontalSpaceSmall,
          displayFutureDateButton
              ? FloatingActionButton.small(
                  heroTag: 'frontArrow',
                  backgroundColor: Colors.white,
                  onPressed: () {
                    onNextPressed();
                  },
                  child: Icon(Icons.arrow_forward_ios, color: kcDarkGreyColor),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _mobileView() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        showDatePicker();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                  onTap: () {},
                  child: SvgPicture.asset("assets/icons/calender_date.svg")),
              horizontalSpaceSmall,
              Icon(Icons.arrow_drop_down_rounded, color: kcDarkGreyColor)
            ],
          ),
          AppText.body(DateTimeUtils.readableDateDDMM(selectedDate)),
        ],
      ),
    );
  }

  showDatePicker() {
    DatePicker.showDatePicker(Get.context!,
        showTitleActions: true,
        minTime: minTime,
        maxTime: maxTime,
        onChanged: (date) {}, onConfirm: (date) {
      onDateChange(date);
    }, currentTime: DateTime.now(), locale: LocaleType.fr);
  }
}
