import 'package:uol_teacher_admin/cubits/announcement/deleteNotificationCubit.dart';
import 'package:uol_teacher_admin/ui/widgets/customCircularProgressIndicator.dart';
import 'package:uol_teacher_admin/ui/widgets/customTextButton.dart';
import 'package:uol_teacher_admin/ui/widgets/customTextContainer.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:uol_teacher_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class DeleteNotificationConfirmationDialog extends StatelessWidget {
  final int notificationId;
  const DeleteNotificationConfirmationDialog(
      {super.key, required this.notificationId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const CustomTextContainer(
        textKey: areYouSureToDeleteKey,
      ),
      actions: [
        BlocConsumer<DeleteNotificationCubit, DeleteNotificationState>(
          listener: (context, state) {
            if (state is DeleteNotificationSuccess) {
              Get.back(result: notificationId);
              Utils.showSnackBar(
                  message: notificationDeletedSuccessfullyKey,
                  context: context);
            } else if (state is DeleteNotificationFailure) {
              Get.back();
              Utils.showSnackBar(message: state.errorMessage, context: context);
            }
          },
          builder: (context, state) {
            return state is DeleteNotificationInProgress
                ? PopScope(
                    canPop: false,
                    child: CustomCircularProgressIndicator(
                      indicatorColor: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(
                          buttonTextKey: yesKey,
                          onTapButton: () {
                            context
                                .read<DeleteNotificationCubit>()
                                .deleteNotification(
                                    notificationId: notificationId);
                          }),
                      const SizedBox(
                        width: 25.0,
                      ),
                      CustomTextButton(
                          buttonTextKey: noKey,
                          onTapButton: () {
                            Get.back();
                          }),
                    ],
                  );
          },
        )
      ],
    );
  }
}
