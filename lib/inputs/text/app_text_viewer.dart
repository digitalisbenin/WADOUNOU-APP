import 'package:digitalis_restaurant_app/core/utils/row_expanded.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:flutter/cupertino.dart';

class AppTextViewer extends StatelessWidget {
  final String? title;
  final String? value;

  const AppTextViewer({
    this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.body(title),
        verticalSpaceTiny,
        RowExpanded(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: kcLightGreyColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: AppText.body(value),
          ),
        ),
      ],
    );
  }
}
