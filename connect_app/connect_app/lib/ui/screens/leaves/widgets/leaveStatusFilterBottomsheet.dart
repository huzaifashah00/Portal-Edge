import 'package:uol_teacher_admin/ui/widgets/customBottomsheet.dart';
import 'package:uol_teacher_admin/ui/widgets/filterSelectionTile.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:uol_teacher_admin/utils/utils.dart';
import 'package:flutter/material.dart';

class LeaveStatusFilterBottomsheet extends StatelessWidget {
  final String? leaveStatus;
  const LeaveStatusFilterBottomsheet({super.key, this.leaveStatus});

  @override
  Widget build(BuildContext context) {
    return CustomBottomsheet(
      titleLabelKey:
          "${Utils.getTranslatedLabel(filterByKey)} : ${Utils.getTranslatedLabel(statusKey)}",
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          FilterSelectionTile(
            isSelected: true,
            title: allKey,
            onTap: () {},
          ),
          FilterSelectionTile(
            isSelected: false,
            title: pendingKey,
            onTap: () {},
          ),
          FilterSelectionTile(
            isSelected: false,
            title: approvedKey,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
