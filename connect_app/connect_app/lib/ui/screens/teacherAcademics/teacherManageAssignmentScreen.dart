import 'package:uol_teacher_admin/app/routes.dart';
import 'package:uol_teacher_admin/cubits/teacherAcademics/assignment/assignmentCubit.dart';
import 'package:uol_teacher_admin/cubits/teacherAcademics/assignment/deleteAssignmentCubit.dart';
import 'package:uol_teacher_admin/cubits/teacherAcademics/classSectionsAndSubjects.dart';
import 'package:uol_teacher_admin/data/models/assignment.dart';
import 'package:uol_teacher_admin/data/models/classSection.dart';
import 'package:uol_teacher_admin/data/models/teacherSubject.dart';
import 'package:uol_teacher_admin/ui/screens/teacherAcademics/teacherAddEditAssignmentScreen.dart';
import 'package:uol_teacher_admin/ui/screens/teacherAcademics/teacherManageAssignmentSubmissionScreen.dart';
import 'package:uol_teacher_admin/ui/screens/teacherAcademics/widgets/confirmDeleteDialog.dart';
import 'package:uol_teacher_admin/ui/screens/teacherAcademics/widgets/customExpandableContainer.dart';
import 'package:uol_teacher_admin/ui/screens/teacherAcademics/widgets/customTitleDescriptionContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/appbarFilterBackgroundContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/customAppbar.dart';
import 'package:uol_teacher_admin/ui/widgets/customCircularProgressIndicator.dart';
import 'package:uol_teacher_admin/ui/widgets/customRoundedButton.dart';
import 'package:uol_teacher_admin/ui/widgets/customTextContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/errorContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/filterButton.dart';
import 'package:uol_teacher_admin/ui/widgets/filterSelectionBottomsheet.dart';
import 'package:uol_teacher_admin/utils/constants.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:uol_teacher_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TeacherManageAssignmentScreen extends StatefulWidget {
  static Widget getRouteInstance() {
    //final arguments = Get.arguments as Map<String,dynamic>;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AssignmentCubit(),
        ),
        BlocProvider(
          create: (context) => ClassSectionsAndSubjectsCubit(),
        ),
      ],
      child: const TeacherManageAssignmentScreen(),
    );
  }

  static Map<String, dynamic> buildArguments() {
    return {};
  }

  const TeacherManageAssignmentScreen({super.key});

  @override
  State<TeacherManageAssignmentScreen> createState() =>
      _TeacherManageAssignmentScreenState();
}

class _TeacherManageAssignmentScreenState
    extends State<TeacherManageAssignmentScreen> {
  ClassSection? _selectedClassSection;
  TeacherSubject? _selectedSubject;

  late final ScrollController _scrollController = ScrollController()
    ..addListener(scrollListener);

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        context
            .read<ClassSectionsAndSubjectsCubit>()
            .getClassSectionsAndSubjects();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      if (context.read<AssignmentCubit>().hasMore()) {
        getMoreAssignments();
      }
    }
  }

  void changeSelectedClassSection(ClassSection? classSection,
      {bool fetchNewSubjects = true}) {
    if (_selectedClassSection != classSection) {
      _selectedClassSection = classSection;
      //fetching new subjects after user changes the selected class
      if (fetchNewSubjects && _selectedClassSection != null) {
        context
            .read<ClassSectionsAndSubjectsCubit>()
            .getNewSubjectsFromSelectedClassSectionIndex(
                newClassSectionId: classSection?.id ?? 0)
            .then((value) {
          if (mounted) {
            if (context.read<ClassSectionsAndSubjectsCubit>().state
                is ClassSectionsAndSubjectsFetchSuccess) {
              changeSelectedTeacherSubject((context
                      .read<ClassSectionsAndSubjectsCubit>()
                      .state as ClassSectionsAndSubjectsFetchSuccess)
                  .subjects
                  .firstOrNull);
            }
          }
        });
      }
      setState(() {});
    }
  }

  void changeSelectedTeacherSubject(TeacherSubject? teacherSubject) {
    if (_selectedSubject != teacherSubject) {
      _selectedSubject = teacherSubject;
      setState(() {});
      getAssignments();
    }
  }

  void getAssignments() {
    context.read<AssignmentCubit>().fetchAssignment(
        subjectId: _selectedSubject?.classSubjectId ?? 0,
        classSectionId: _selectedClassSection?.id ?? 0);
  }

  void getMoreAssignments() {
    context.read<AssignmentCubit>().fetchMoreAssignment(
        classSubjectId: _selectedSubject?.classSubjectId ?? 0,
        classSectionId: _selectedClassSection?.id ?? 0);
  }

  Widget _buildAssignmentItem({required Assignment assignment}) {
    return BlocProvider<DeleteAssignmentCubit>(
      create: (context) => DeleteAssignmentCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<DeleteAssignmentCubit, DeleteAssignmentState>(
              listener: (context, state) {
            if (state is DeleteAssignmentSuccess) {
              context.read<AssignmentCubit>().deleteAssignment(assignment.id);
            } else if (state is DeleteAssignmentFailure) {
              Utils.showSnackBar(
                context: context,
                message: unableToDeleteAssignmentKey,
              );
            }
          }, builder: (context, state) {
            return CustomExpandableContainer(
                key: ValueKey(assignment.id),
                customActionContainer: InkWell(
                  onTap: () {
                    Get.toNamed(
                      Routes.teacherManageAssignmentSubmissionScreen,
                      arguments: TeacherManageAssignmentSubmissionScreen
                          .buildArguments(
                        assignment: assignment,
                      ),
                    );
                  },
                  child: CustomTextContainer(
                    textKey: submissionsKey,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                contractedContentWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTitleDescriptionContainer(
                      titleKey: dueDateKey,
                      description: Utils.formatDateAndTime(assignment.dueDate),
                    ),
                    if (assignment.points != 0 ||
                        assignment.extraDaysForResubmission != 0) ...[
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          if (assignment.points != 0)
                            Expanded(
                              child: CustomTitleDescriptionContainer(
                                  titleKey: pointsKey,
                                  description: assignment.points.toString()),
                            ),
                          if (assignment.extraDaysForResubmission != 0)
                            CustomTitleDescriptionContainer(
                              titleKey: extraDaysForResubmissionKey,
                              description: assignment.extraDaysForResubmission
                                  .toString(),
                              useReadMoreForDescription: false,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
                expandedContentWidget: assignment.instructions.trim().isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTitleDescriptionContainer(
                              titleKey: instructionsKey,
                              description: assignment.instructions),
                        ],
                      )
                    : null,
                onDelete: () {
                  if (state is DeleteAssignmentInProgress) {
                    return;
                  }
                  showDialog<bool>(
                    context: context,
                    builder: (_) => const ConfirmDeleteDialog(),
                  ).then((value) {
                    if (value != null && value) {
                      if (context.mounted) {
                        context.read<DeleteAssignmentCubit>().deleteAssignment(
                              assignmentId: assignment.id,
                            );
                      }
                    }
                  });
                },
                isDeleteLoading: state is DeleteAssignmentInProgress,
                onEdit: () {
                  Get.toNamed(Routes.teacherAddEditAssignmentScreen,
                          arguments:
                              TeacherAddEditAssignmentScreen.buildArguments(
                                  assignment: assignment,
                                  selectedClassSection: _selectedClassSection,
                                  selectedSubject: _selectedSubject))
                      ?.then((value) {
                    if (value != null && value is bool && value) {
                      //re-fetch assignments if they edit or add
                      getAssignments();
                    }
                  });
                },
                isStudyMaterialFile: true,
                studyMaterials: assignment.studyMaterial,
                titleText: assignment.name);
          });
        },
      ),
    );
  }

  Widget _buildAssignmentList() {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(
            bottom: 70,
            top: Utils.appContentTopScrollPadding(context: context) + 100),
        child: BlocBuilder<AssignmentCubit, AssignmentState>(
          builder: (context, state) {
            if (state is AssignmentsFetchSuccess) {
              if (state.assignment.isEmpty) {
                return const SizedBox.shrink();
              }
              return Container(
                padding: EdgeInsets.all(appContentHorizontalPadding),
                color: Theme.of(context).colorScheme.surface,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const CustomTextContainer(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textKey: assignmentListKey,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ...List.generate(
                      state.assignment.length,
                      (index) => _buildAssignmentItem(
                          assignment: state.assignment[index]),
                    ),
                  ],
                ),
              );
            } else if (state is AssignmentFetchFailure) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: topPaddingOfErrorAndLoadingContainer),
                  child: ErrorContainer(
                    errorMessage: state.errorMessage,
                    onTapRetry: () {
                      getAssignments();
                    },
                  ),
                ),
              );
            } else {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: topPaddingOfErrorAndLoadingContainer),
                  child: CustomCircularProgressIndicator(
                    indicatorColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(appContentHorizontalPadding),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1)
        ], color: Theme.of(context).colorScheme.surface),
        width: MediaQuery.of(context).size.width,
        height: 70,
        child: CustomRoundedButton(
          height: 40,
          widthPercentage: 1.0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          buttonTitle: createAssignmentKey,
          showBorder: false,
          onTap: () {
            Get.toNamed(Routes.teacherAddEditAssignmentScreen,
                    arguments: TeacherAddEditAssignmentScreen.buildArguments(
                        assignment: null,
                        selectedClassSection: _selectedClassSection,
                        selectedSubject: _selectedSubject))
                ?.then((value) {
              if (value != null && value is bool && value) {
                //re-fetch assignments if they edit or add
                getAssignments();
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildAppbarAndFilters() {
    return Align(
      alignment: Alignment.topCenter,
      child: BlocConsumer<ClassSectionsAndSubjectsCubit,
          ClassSectionsAndSubjectsState>(
        listener: (context, state) {
          if (state is ClassSectionsAndSubjectsFetchSuccess) {
            if (_selectedClassSection == null) {
              changeSelectedClassSection(state.classSections.firstOrNull,
                  fetchNewSubjects: false);
            }
            if (_selectedSubject == null) {
              changeSelectedTeacherSubject(state.subjects.firstOrNull);
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              const CustomAppbar(titleKey: manageAssignmentKey),
              AppbarFilterBackgroundContainer(
                child: LayoutBuilder(builder: (context, boxConstraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilterButton(
                        onTap: () {
                          if (state is ClassSectionsAndSubjectsFetchSuccess) {
                            Utils.showBottomSheet(
                                child: FilterSelectionBottomsheet<ClassSection>(
                                  onSelection: (value) {
                                    changeSelectedClassSection(value!);
                                    Get.back();
                                  },
                                  selectedValue: _selectedClassSection!,
                                  titleKey: classKey,
                                  values: state.classSections,
                                ),
                                context: context);
                          }
                        },
                        titleKey: _selectedClassSection?.id == null
                            ? classKey
                            : (_selectedClassSection?.fullName ?? ""),
                        width: boxConstraints.maxWidth * (0.48),
                      ),
                      FilterButton(
                          onTap: () {
                            if (state is ClassSectionsAndSubjectsFetchSuccess) {
                              Utils.showBottomSheet(
                                  child: FilterSelectionBottomsheet<
                                      TeacherSubject>(
                                    selectedValue: _selectedSubject!,
                                    titleKey: subjectKey,
                                    values: state.subjects,
                                    onSelection: (value) {
                                      changeSelectedTeacherSubject(value!);
                                      Get.back();
                                    },
                                  ),
                                  context: context);
                            }
                          },
                          titleKey: _selectedSubject?.id == null
                              ? subjectKey
                              : _selectedSubject?.subject
                                      .getSybjectNameWithType() ??
                                  "",
                          width: boxConstraints.maxWidth * (0.48)),
                    ],
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<ClassSectionsAndSubjectsCubit,
              ClassSectionsAndSubjectsState>(
            builder: (context, state) {
              if (state is ClassSectionsAndSubjectsFetchSuccess) {
                return _buildAssignmentList();
              }

              if (state is ClassSectionsAndSubjectsFetchFailure) {
                return Center(
                    child: ErrorContainer(
                  errorMessage: state.errorMessage,
                  onTapRetry: () {
                    context
                        .read<ClassSectionsAndSubjectsCubit>()
                        .getClassSectionsAndSubjects();
                  },
                ));
              }
              return Center(
                child: CustomCircularProgressIndicator(
                  indicatorColor: Theme.of(context).colorScheme.primary,
                ),
              );
            },
          ),
          _buildSubmitButton(),
          _buildAppbarAndFilters(),
        ],
      ),
    );
  }
}
