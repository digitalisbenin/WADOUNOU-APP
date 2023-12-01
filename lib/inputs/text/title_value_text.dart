import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

import 'url_text.dart';

class TitleValueTextWidget extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;
  final bool enableColon;
  final Color titleTextColor;
  final Color valueTextColor;
  final TextAlign titleTextAlignment;
  final TextAlign valueTextAlignment;
  final TitleValueOrientation orientation;
  final TitleValueTextType textType;

  const TitleValueTextWidget(
      {Key? key,
      required this.title,
      this.value,
      this.valueWidget,
      this.enableColon = true,
      this.titleTextColor = kcTitleTextColor,
      this.valueTextColor = kcBlackColor,
      this.titleTextAlignment = TextAlign.start,
      this.valueTextAlignment = TextAlign.start,
      this.orientation = TitleValueOrientation.row,
      this.textType = TitleValueTextType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (orientation) {
      case TitleValueOrientation.row:
        return _buildRowView();
      case TitleValueOrientation.column:
        return _buildColumnView();
        break;
    }
  }

  _buildValueUi() {
    if (value != null && value != '') {
      switch (textType) {
        case TitleValueTextType.text:
          return AppText.body(value, color: valueTextColor);
        case TitleValueTextType.url:
          return UrlText(url: value ?? '');
      }
    } else if (valueWidget != null) {
      return valueWidget;
    }

    return AppText.body(
      'N/A',
      color: kcBlackColor,
      align: valueTextAlignment,
    );
  }

  _buildRowView() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: AppText.headingFour(
            title,
            align: titleTextAlignment,
            color: titleTextColor,
          )),
      horizontalSpaceMedium,
      enableColon
          ? Row(mainAxisSize: MainAxisSize.min, children: [
              AppText.body(':', color: valueTextColor),
              horizontalSpaceMedium
            ])
          : SizedBox(),
      Flexible(fit: FlexFit.tight, flex: 7, child: _buildValueUi()),
    ]);
  }

  _buildColumnView() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppText.headingFour(
            title,
            color: kcDarkGreyColor,
          ),
          verticalSpaceSmall,
          _buildValueUi()
        ],
      ),
    );
  }
}

enum TitleValueOrientation { row, column }

enum TitleValueTextType { text, url }
