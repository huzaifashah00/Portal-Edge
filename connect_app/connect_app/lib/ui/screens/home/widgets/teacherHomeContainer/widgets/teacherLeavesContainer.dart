import 'package:uol_teacher_admin/app/routes.dart';
import 'package:uol_teacher_admin/cubits/homeScreenDataCubit.dart';
import 'package:uol_teacher_admin/ui/screens/home/widgets/homeContainer/widgets/contentTitleWithViewmoreButton.dart';
import 'package:uol_teacher_admin/ui/screens/home/widgets/teacherHomeContainer/widgets/roundedBackgroundContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/customTextContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/leaveDetailsContainer.dart';
import 'package:uol_teacher_admin/utils/constants.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TeacherLeavesContainer extends StatelessWidget {
  const TeacherLeavesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final todaysLeave = context.read<HomeScreenDataCubit>().getTodayLeaves();
    return RoundedBackgroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentTitleWithViewMoreButton(
            contentTitleKey: leavesKey,
            showViewMoreButton: true,
            viewMoreOnTap: () {
              Get.toNamed(Routes.generalLeavesScreen);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          todaysLeave.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: appContentHorizontalPadding),
                  child: const CustomTextContainer(
                      textKey: everyoneIsPresentTodayKey),
                )
              : Column(
                  children: [
                    LeaveDetailsContainer(
                      leaveDetails: todaysLeave.first,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    todaysLeave.length > 2
                        ? LeaveDetailsContainer(leaveDetails: todaysLeave[1])
                        : const SizedBox(),
                  ],
                ),
        ],
      ),
    );
  }
}
