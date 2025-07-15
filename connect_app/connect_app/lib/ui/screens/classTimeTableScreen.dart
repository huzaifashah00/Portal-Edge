import 'package:uol_teacher_admin/cubits/academics/classTimetableCubit.dart';
import 'package:uol_teacher_admin/cubits/academics/classesCubit.dart';
import 'package:uol_teacher_admin/data/models/classSection.dart';
import 'package:uol_teacher_admin/ui/widgets/appbarFilterBackgroundContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/customAppbar.dart';
import 'package:uol_teacher_admin/ui/widgets/customCircularProgressIndicator.dart';
import 'package:uol_teacher_admin/ui/widgets/errorContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/filterButton.dart';
import 'package:uol_teacher_admin/ui/widgets/filterSelectionBottomsheet.dart';
import 'package:uol_teacher_admin/ui/widgets/timetableSlotContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/weekdaysContainer.dart';
import 'package:uol_teacher_admin/utils/constants.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:uol_teacher_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ClassTimeTableScreen extends StatefulWidget {
  const ClassTimeTableScreen({super.key});

  static Widget getRouteInstance() {
    //final arguments = Get.arguments as Map<String, dynamic>;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClassesCubit(),
        ),
        BlocProvider(
          create: (context) => ClassTimetableCubit(),
        ),
      ],
      child: const ClassTimeTableScreen(),
    );
  }

  static Map<String, dynamic> buildArguments() {
    return {};
  }

  @override
  State<ClassTimeTableScreen> createState() => _ClassTimeTableScreenState();
}

class _ClassTimeTableScreenState extends State<ClassTimeTableScreen> {
  ClassSection? _selectedClassSection;
  late String _selectedDayKey = Utils.weekDays.first;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        context.read<ClassesCubit>().getClasses();
      }
    });
    super.initState();
  }

  void changeSelectedClassSection(ClassSection classSection) {
    _selectedClassSection = classSection;
    setState(() {});
    getClassTimetable();
  }

  void getClassTimetable() {
    context
        .read<ClassTimetableCubit>()
        .getClassTimetable(classSectionId: _selectedClassSection?.id ?? 0);
  }

  Widget _buildDaysContainer() {
    return WeekdaysContainer(
      selectedDayKey: _selectedDayKey,
      onSelectionChange: (String newSelection) {
        setState(() {
          _selectedDayKey = newSelection;
        });
      },
    );
  }

  Widget _buildClassTimetable() {
    return BlocBuilder<ClassTimetableCubit, ClassTimetableState>(
      builder: (context, state) {
        if (state is ClassTimetableFetchSuccess) {
          final slots = state.classTimetableSlots
              .where((element) =>
                  element.day ==
                  weekDays[Utils.weekDays.indexOf(_selectedDayKey)])
              .toList();

          if (slots.isEmpty) {
            return const SizedBox();
          }
          return Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: Utils.appContentTopScrollPadding(context: context) +
                        200),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(appContentHorizontalPadding),
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    children: slots
                        .map((timeTableSlot) => TimetableSlotContainer(
                              note: timeTableSlot.note ?? "",
                              endTime: timeTableSlot.endTime ?? "",
                              isForClass: true,
                              teacherName: timeTableSlot
                                      .subjectTeacher?.teacher?.fullName ??
                                  "-",
                              startTime: timeTableSlot.startTime ?? "",
                              subjectName: timeTableSlot.subject
                                      ?.getSybjectNameWithType() ??
                                  "-",
                            ))
                        .toList(),
                  ),
                ),
              ));
        }
        if (state is ClassTimetableFetchFailure) {
          return Center(
            child: ErrorContainer(
              errorMessage: state.errorMessage,
              onTapRetry: () {
                getClassTimetable();
              },
            ),
          );
        }
        return Center(
          child: CustomCircularProgressIndicator(
            indicatorColor: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BlocBuilder<ClassesCubit, ClassesState>(
          builder: (context, state) {
            if (state is ClassesFetchSuccess) {
              if (context.read<ClassesCubit>().getAllClasses().isEmpty) {
                return const SizedBox();
              }
              return _buildClassTimetable();
            }

            if (state is ClassesFetchFailure) {
              return Center(
                child: ErrorContainer(
                  errorMessage: state.errorMessage,
                  onTapRetry: () {
                    context.read<ClassesCubit>().getClasses();
                  },
                ),
              );
            }

            return Center(
              child: CustomCircularProgressIndicator(
                indicatorColor: Theme.of(context).colorScheme.primary,
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.topCenter,
          child: BlocConsumer<ClassesCubit, ClassesState>(
            listener: (context, state) {
              if (state is ClassesFetchSuccess &&
                  context.read<ClassesCubit>().getAllClasses().isNotEmpty) {
                changeSelectedClassSection(
                    context.read<ClassesCubit>().getAllClasses().first);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const CustomAppbar(titleKey: classTimetableKey),
                  AppbarFilterBackgroundContainer(
                      child: FilterButton(
                          onTap: () {
                            if (state is ClassesFetchSuccess &&
                                context
                                    .read<ClassesCubit>()
                                    .getAllClasses()
                                    .isNotEmpty) {
                              Utils.showBottomSheet(
                                  child:
                                      FilterSelectionBottomsheet<ClassSection>(
                                          onSelection: (value) {
                                            changeSelectedClassSection(value!);
                                            Get.back();
                                          },
                                          selectedValue: _selectedClassSection!,
                                          titleKey: classKey,
                                          values: context
                                              .read<ClassesCubit>()
                                              .getAllClasses()),
                                  context: context);
                            }
                          },
                          titleKey: _selectedClassSection == null
                              ? classKey
                              : (_selectedClassSection?.fullName ?? ""),
                          width: MediaQuery.of(context).size.width)),
                  _buildDaysContainer(),
                ],
              );
            },
          ),
        ),
      ],
    ));
  }
}
