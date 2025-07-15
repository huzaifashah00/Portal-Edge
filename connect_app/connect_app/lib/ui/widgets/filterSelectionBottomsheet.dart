import 'package:uol_teacher_admin/ui/widgets/customBottomsheet.dart';
import 'package:uol_teacher_admin/ui/widgets/filterSelectionTile.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:uol_teacher_admin/utils/utils.dart';
import 'package:flutter/material.dart';

class FilterSelectionBottomsheet<T> extends StatelessWidget {
  final List<T> values;
  final Function(T? value) onSelection;
  final T selectedValue;
  final String titleKey;
  final bool showFilterByLabel;
  const FilterSelectionBottomsheet(
      {super.key,
      required this.onSelection,
      required this.selectedValue,
      required this.titleKey,
      required this.values,
      this.showFilterByLabel = true});

  @override
  Widget build(BuildContext context) {
    return CustomBottomsheet(
      titleLabelKey:
          "${showFilterByLabel ? '${Utils.getTranslatedLabel(filterByKey)} : ' : ''}${Utils.getTranslatedLabel(titleKey)}",
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          ...values.map((value) => FilterSelectionTile(
              onTap: () {
                onSelection.call(value);
              },
              isSelected: value == selectedValue,
              title: value.toString()))
        ],
      ),
    );
  }
}
