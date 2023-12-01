import 'package:digitalis_restaurant_app/core/utils/row_expanded.dart';
import 'package:digitalis_restaurant_app/shared/ui/colors.dart';
import 'package:digitalis_restaurant_app/shared/ui/ui_helpers.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/buttons/app_outline_button.dart';
import 'package:digitalis_restaurant_app/shared/ui/widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_input_field.dart';
import 'spacings/app_padding.dart';
import 'text/error_text.dart';

class AppSingleSelectFormField<T> extends FormField<T> {
  AppSingleSelectFormField(
      {Key? key,
      String? title,
      FormFieldSetter<T>? onSaved,
      FormFieldValidator<T>? validator,
      T? initialValue,
      AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
      T? value,
      required List<T> items,
      int? maximumCount,
      String Function(int index)? itemTextBuilder,
      Widget Function(int index)? itemBuilder,
      Widget Function(int index)? itemSelectedBuilder,
      Widget Function(int index)? showAllListItemBuilder,
      required Function(T value) onItemSelected,
      required Function(T value) onItemUnSelected,
      Widget? childWidget,
      Color unselectedColor = kcBlueGrey50,
      Color selectedColor = kcPrimaryColor,
      Color selectedTextColor = kcWhiteColor,
      Color unSelectedTextColor = kcPrimaryColor})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<T> state) {
              state.setValue(value);
              Widget child = SizedBox();

              if (items.isEmpty) {
                child = AppText.body('No data available', color: kcBlackColor);
              } else {
                child = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    verticalSpaceTiny,
                    Wrap(
                      runSpacing: 12,
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ..._buildItems<T>(
                            title,
                            items,
                            maximumCount,
                            value,
                            itemTextBuilder,
                            itemBuilder,
                            itemSelectedBuilder,
                            showAllListItemBuilder,
                            onItemSelected,
                            onItemUnSelected,
                            childWidget,
                            selectedColor,
                            unselectedColor,
                            selectedTextColor,
                            unSelectedTextColor,
                            state)
                      ],
                    ),
                    verticalSpaceTiny,
                    state.hasError ? ErrorText(state.errorText) : Container()
                  ],
                );
              }
              return BaseInputField(
                title: title,
                inputControl: child,
              );
            });

  static List<Widget> _buildItems<T>(
      String? title,
      List<T> items,
      int? maximumCount,
      T? selectedItem,
      String Function(int index)? itemTextBuilder,
      Widget Function(int index)? itemBuilder,
      Widget Function(int index)? itemSelectedBuilder,
      Widget Function(int index)? showAllListItemBuilder,
      Function(T value) onItemSelected,
      Function(T value) onItemUnSelected,
      Widget? childWidget,
      Color selectedColor,
      Color unselectedColor,
      Color selectedTextColor,
      Color unSelectedTextColor,
      FormFieldState<T> state) {
    var widgets = <Widget>[];

    var itemsLength = items.length;

    var showingMaxCountItems = false;
    if (maximumCount != null) {
      if (maximumCount < itemsLength) {
        itemsLength = maximumCount;
        showingMaxCountItems = true;
      }
    }

    for (int i = 0; i < itemsLength; i++) {
      var isSelected = selectedItem == items[i] ? true : false;

      String? displayText;
      Widget? unselectedDisplayWidget;
      Widget? selectedDisplayWidget;

      if (itemTextBuilder != null) {
        displayText = itemTextBuilder(i);
      }

      if (itemBuilder != null) {
        unselectedDisplayWidget = itemBuilder(i);
      }

      if (itemSelectedBuilder != null) {
        selectedDisplayWidget = itemSelectedBuilder(i);
      }

      Widget childWidget = AppText.body('N/A',
          color: isSelected ? selectedTextColor : unSelectedTextColor);

      if (displayText != null) {
        childWidget = AppText.body(displayText,
            color: isSelected ? selectedTextColor : unSelectedTextColor);
      } else {
        if (isSelected) {
          childWidget =
              selectedDisplayWidget ?? unselectedDisplayWidget ?? SizedBox();
        } else {
          childWidget =
              unselectedDisplayWidget ?? selectedDisplayWidget ?? SizedBox();
        }
      }

      // var containerColor = itemTextBuilder != null
      //     ? (isSelected ? selectedColor : unselectedColor)
      //     : null;

      var widget = InkWell(
        onTap: () {
          if (isSelected) {
            onItemUnSelected(items[i]);
            state.didChange(null);
          } else {
            onItemSelected(items[i]);
            state.didChange(items[i]);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: childWidget,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? selectedColor : unselectedColor),
        ),
      );
      widgets.add(widget);
    }

    if (showingMaxCountItems) {
      widgets.add(InkWell(
        onTap: () {
          showListDialog<T>(
              title, items, showAllListItemBuilder, onItemSelected);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.body('Show All', color: kcBlackColor),
              horizontalSpaceTiny,
              Icon(Icons.arrow_forward, color: kcDarkGreyColor)
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: kcBlueGrey50),
        ),
      ));
    }
    return widgets;
  }

  static showListDialog<T>(
      String? title,
      List<T> items,
      Widget Function(int index)? showAllListItemBuilder,
      Function(T) onItemSelected) {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                width: 300,
                height: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppPadding.allSmall(
                        child: Row(
                      children: [
                        AppText.headingFour(title),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.close, color: kcDarkGreyColor))
                      ],
                    )),
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (showAllListItemBuilder == null) {
                              return ListTile(title: AppText.body('N/A'));
                            }
                            return InkWell(
                                onTap: () {
                                  Get.back();
                                  onItemSelected(items[index]);
                                },
                                child: showAllListItemBuilder(index));
                          },
                        ),
                      ),
                    ),
                    AppPadding.allSmall(
                      child: RowExpanded(
                        child: AppOutlineButton(
                            text: 'Cancel',
                            onPressed: () {
                              Get.back();
                            }),
                      ),
                    ),
                    verticalSpaceSmall
                  ],
                ),
              ));
        });
  }
}

class SelectorListTile extends StatelessWidget {
  final Widget? icon;
  final String? title;
  const SelectorListTile({Key? key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [icon ?? SizedBox(), horizontalSpaceSmall, AppText.body(title)],
    ));
  }
}
