import 'package:uol_student/cubits/timeTableCubit.dart';
import 'package:uol_student/data/repositories/studentRepository.dart';
import 'package:uol_student/ui/widgets/timetableContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ChildTimeTableScreen extends StatelessWidget {
  final int childId;
  const ChildTimeTableScreen({Key? key, required this.childId})
      : super(key: key);

  static Widget routeInstance() {
    return BlocProvider<TimeTableCubit>(
      create: (context) => TimeTableCubit(StudentRepository()),
      child: ChildTimeTableScreen(childId: Get.arguments as int),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TimeTableContainer(
        childId: childId,
      ),
    );
  }
}
