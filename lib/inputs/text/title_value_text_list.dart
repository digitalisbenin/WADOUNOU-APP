import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:digitalis_restaurant_app/widgets/line.dart';
import 'package:flutter/material.dart';

import 'title_value_text.dart';

class TitleValueTextListWidget extends StatelessWidget {
  final String? heading;
  final List<TitleValueData> items;
  final double? dividerSpace;
  final bool enableColon;
  final Color titleTextColor;
  final Color valueTextColor;
  final TextAlign titleTextAlignment;
  final TextAlign valueTextAlignment;
  final TitleValueOrientation type;
  final bool enableBottomSeperator;

  const TitleValueTextListWidget(
      {Key? key,
      this.heading,
      required this.items,
      this.dividerSpace = 4,
      this.enableColon = true,
      this.titleTextColor = Colors.grey,
      this.valueTextColor = kcBlackColor,
      this.titleTextAlignment = TextAlign.start,
      this.valueTextAlignment = TextAlign.start,
      this.type = TitleValueOrientation.row,
      this.enableBottomSeperator = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeading(),
        ...getWidgets(),
        enableBottomSeperator ? Line() : SizedBox()
      ],
    );
  }

  Widget _buildHeading() {
    if (heading != null) {
      return Column(
        children: [AppText.headingThree(heading, color: kcPrimaryColor)],
      );
    }
    return SizedBox();
  }

  List<Widget> getWidgets() {
    var list = <Widget>[];
    for (var item in items) {
      list.add(Column(
        children: [
          SizedBox(height: dividerSpace),
          _buildTitleValueView(item),
          SizedBox(height: dividerSpace)
        ],
      ));
    }
    return list;
  }

  Widget _buildTitleValueView(TitleValueData item) {
    if (item.hideWhenNull && item.value == null) {
      return SizedBox();
    } else {
      return TitleValueTextWidget(
        title: item.title,
        value: item.value,
        valueWidget: item.valueWidget,
        enableColon: enableColon,
        titleTextAlignment: titleTextAlignment,
        valueTextAlignment: valueTextAlignment,
        orientation: type,
        textType: item.textType,
      );
    }
  }
}

class TitleValueData {
  final String title;
  final String? value;
  final bool hideWhenNull;
  final Widget? valueWidget;
  final TitleValueTextType textType;

  TitleValueData(
      {required this.title,
      this.value,
      this.hideWhenNull = false,
      this.valueWidget,
      this.textType = TitleValueTextType.text});
}
