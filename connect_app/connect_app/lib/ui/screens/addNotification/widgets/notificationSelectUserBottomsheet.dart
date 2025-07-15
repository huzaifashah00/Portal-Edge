import 'package:uol_teacher_admin/ui/widgets/customBottomsheet.dart';
import 'package:uol_teacher_admin/ui/widgets/filterSelectionTile.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:flutter/material.dart';

class NotificationSelectUserBottomsheet extends StatelessWidget {
  const NotificationSelectUserBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomsheet(
      titleLabelKey: selectUserKey,
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          FilterSelectionTile(
            isSelected: true,
            title: "X student",
            onTap: () {},
          ),
          FilterSelectionTile(
            isSelected: false,
            title: "Y student",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
