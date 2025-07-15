import 'package:uol_teacher_admin/data/models/offlineExamSubjectResult.dart';
import 'package:uol_teacher_admin/ui/widgets/customBottomsheet.dart';
import 'package:uol_teacher_admin/ui/widgets/customTextContainer.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:flutter/material.dart';

class StudentResultSubjectMarksBottomsheet extends StatelessWidget {
  final List<OfflineExamSubjectResult> subjectResults;
  const StudentResultSubjectMarksBottomsheet(
      {super.key, required this.subjectResults});

  @override
  Widget build(BuildContext context) {
    return CustomBottomsheet(
        titleLabelKey: subjectWiseMarksKey,
        child: Column(
          children: subjectResults
              .map((subjectResult) => ListTile(
                    title: CustomTextContainer(
                      textKey:
                          subjectResult.subject?.getSybjectNameWithType() ??
                              "-",
                    ),
                    subtitle: CustomTextContainer(
                        textKey:
                            "${subjectResult.obtainedMarks ?? 0}/${subjectResult.offlineExamTimeTableSlot?.totalMarks ?? 0}"),
                    trailing: CustomTextContainer(
                      textKey: subjectResult.grade ?? "-",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16.0,
                      ),
                    ),
                  ))
              .toList(),
        ));
  }
}
