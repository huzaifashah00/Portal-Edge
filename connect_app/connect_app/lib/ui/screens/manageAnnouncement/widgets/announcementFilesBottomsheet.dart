import 'package:uol_teacher_admin/data/models/studyMaterial.dart';
import 'package:uol_teacher_admin/ui/screens/teacherAcademics/widgets/studyMaterialContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/customBottomsheet.dart';
import 'package:uol_teacher_admin/utils/constants.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:flutter/material.dart';

class AnnouncementFilesBottomsheet extends StatelessWidget {
  final List<StudyMaterial> files;
  const AnnouncementFilesBottomsheet({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    return CustomBottomsheet(
        titleLabelKey: viewFilesKey,
        child: Column(
          children: files
              .map((file) => Padding(
                    padding: EdgeInsets.all(appContentHorizontalPadding),
                    child: StudyMaterialContainer(
                        studyMaterial: file, showEditAndDeleteButton: false),
                  ))
              .toList(),
        ));
  }
}
