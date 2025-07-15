import 'package:uol_teacher_admin/app/routes.dart';
import 'package:uol_teacher_admin/cubits/homeScreenDataCubit.dart';
import 'package:uol_teacher_admin/ui/screens/home/widgets/homeContainer/widgets/contentTitleWithViewmoreButton.dart';
import 'package:uol_teacher_admin/ui/screens/home/widgets/homeContainer/widgets/overviewDetailsContainer.dart';
import 'package:uol_teacher_admin/ui/styles/themeExtensions/customColorsExtension.dart';
import 'package:uol_teacher_admin/utils/constants.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:uol_teacher_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class TeacherHomeOverviewContainer extends StatelessWidget {
  const TeacherHomeOverviewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ContentTitleWithViewMoreButton(
            showViewMoreButton: false, contentTitleKey: overviewKey),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding:
                EdgeInsets.symmetric(horizontal: appContentHorizontalPadding),
            children: [
              OverviewDetailsContainer(
                  backgroundColor: Theme.of(context)
                      .extension<CustomColors>()!
                      .totalStudentOverviewBackgroundColor!,
                  titleKey: totalStudentsKey,
                  value: context
                      .read<HomeScreenDataCubit>()
                      .getTotalStudents()
                      .toString(),
                  iconPath: Utils.getImagePath("students_overview.svg"),
                  bottomButtonTitleKey: viewStudentsKey,
                  onTapBottomViewButton: () {
                    Get.toNamed(Routes.studentsScreen);
                  })
            ],
          ),
        ),
      ],
    );
  }
}
