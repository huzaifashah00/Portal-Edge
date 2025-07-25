import 'package:uol_teacher_admin/app/routes.dart';
import 'package:uol_teacher_admin/cubits/teacherAcademics/classSectionsAndSubjects.dart';
import 'package:uol_teacher_admin/cubits/teacherAcademics/lesson/lessonsCubit.dart';
import 'package:uol_teacher_admin/cubits/teacherAcademics/topic/deleteTopicCubit.dart';
import 'package:uol_teacher_admin/cubits/teacherAcademics/topic/topicsCubit.dart';
import 'package:uol_teacher_admin/data/models/classSection.dart';
import 'package:uol_teacher_admin/data/models/lesson.dart';
import 'package:uol_teacher_admin/data/models/teacherSubject.dart';
import 'package:uol_teacher_admin/data/models/topic.dart';
import 'package:uol_teacher_admin/ui/screens/teacherAcademics/teacherAddEditTopicScreen.dart';
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

class TeacherManageTopicScreen extends StatefulWidget {
  //if user comes from a lesson item, this'll be not null
  final ClassSection? selectedClassSection;
  final TeacherSubject? selectedSubject;
  final Lesson? selectedLesson;
  static Widget getRouteInstance() {
    final arguments = Get.arguments as Map<String, dynamic>?;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LessonsCubit(),
        ),
        BlocProvider(
          create: (context) => ClassSectionsAndSubjectsCubit(),
        ),
        BlocProvider(
          create: (context) => TopicsCubit(),
        ),
      ],
      child: TeacherManageTopicScreen(
        selectedClassSection: arguments?['selectedClassSection'],
        selectedSubject: arguments?['selectedSubject'],
        selectedLesson: arguments?['selectedLesson'],
      ),
    );
  }

  static Map<String, dynamic> buildArguments(
      {required ClassSection? selectedClassSection,
      required TeacherSubject? selectedSubject,
      required Lesson? selectedLesson}) {
    return {
      "selectedClassSection": selectedClassSection,
      "selectedSubject": selectedSubject,
      "selectedLesson": selectedLesson,
    };
  }

  const TeacherManageTopicScreen(
      {super.key,
      this.selectedClassSection,
      this.selectedSubject,
      this.selectedLesson});

  @override
  State<TeacherManageTopicScreen> createState() =>
      _TeacherManageTopicScreenState();
}

class _TeacherManageTopicScreenState extends State<TeacherManageTopicScreen> {
  ClassSection? _selectedClassSection;
  TeacherSubject? _selectedSubject;
  Lesson? _selectedLesson;

  //this will be used to refresh previous page (if the user is from lessons)
  bool didCreateNewTopic = false;

  @override
  void initState() {
    if (widget.selectedLesson == null) {
      Future.delayed(Duration.zero, () {
        if (mounted) {
          context
              .read<ClassSectionsAndSubjectsCubit>()
              .getClassSectionsAndSubjects();
        }
      });
    } else {
      //if user came from a lesson, these will be pre-added to send to next page, but user's won't be able to select/change filters
      _selectedLesson = widget.selectedLesson;
      _selectedSubject = widget.selectedSubject;
      _selectedClassSection = widget.selectedClassSection;
      getTopics();
    }
    super.initState();
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
      getLessons();
    }
  }

  void getLessons() {
    context.read<LessonsCubit>().fetchLessons(
        classSubjectId: _selectedSubject?.classSubjectId ?? 0,
        classSectionId: _selectedClassSection?.id ?? 0);
  }

  void getTopics() {
    context.read<TopicsCubit>().fetchTopics(lessonId: _selectedLesson?.id ?? 0);
  }

  Widget _buildTopicItem({required Topic topic}) {
    return BlocProvider(
      create: (context) => DeleteTopicCubit(),
      child: Builder(builder: (context) {
        return BlocConsumer<DeleteTopicCubit, DeleteTopicState>(
          listener: (context, state) {
            if (state is DeleteTopicSuccess) {
              context.read<TopicsCubit>().deleteTopic(topic.id);
            } else if (state is DeleteTopicFailure) {
              Utils.showSnackBar(
                context: context,
                message:
                    "${Utils.getTranslatedLabel(unableToDeleteTopicKey)} ${topic.name}",
              );
            }
          },
          builder: (context, state) {
            return CustomExpandableContainer(
                key: ValueKey(topic.id),
                contractedContentWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTitleDescriptionContainer(
                        titleKey: descriptionKey,
                        description: topic.description),
                  ],
                ),
                isDeleteLoading: state is DeleteTopicInProgress,
                onDelete: () {
                  if (state is DeleteTopicInProgress) {
                    return;
                  }
                  showDialog<bool>(
                    context: context,
                    builder: (_) => const ConfirmDeleteDialog(),
                  ).then((value) {
                    if (value != null && value) {
                      if (context.mounted) {
                        context
                            .read<DeleteTopicCubit>()
                            .deleteTopic(topicId: topic.id);
                      }
                    }
                  });
                },
                onEdit: () {
                  Get.toNamed(Routes.teacherAddEditTopicScreen,
                      arguments: TeacherAddEditTopicScreen.buildArguments(
                        topic: topic,
                        selectedClassSection: _selectedClassSection,
                        selectedLesson: _selectedLesson,
                        selectedSubject: _selectedSubject,
                      ))?.then((value) {
                    if (value != null && value is bool && value) {
                      //re-fetch topics if they edit or add
                      getTopics();
                    }
                  });
                },
                studyMaterials: topic.studyMaterials,
                titleText: topic.name);
          },
        );
      }),
    );
  }

  Widget _buildTopicList() {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: 70,
            top: Utils.appContentTopScrollPadding(context: context) +
                (widget.selectedLesson == null ? 150 : 25)),
        child: BlocBuilder<TopicsCubit, TopicsState>(
          builder: (context, state) {
            if (state is TopicsFetchSuccess) {
              if (state.topics.isEmpty) {
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
                      textKey: topicListKey,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ...List.generate(
                      state.topics.length,
                      (index) => _buildTopicItem(topic: state.topics[index]),
                    ),
                  ],
                ),
              );
            } else if (state is TopicsFetchFailure) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: topPaddingOfErrorAndLoadingContainer),
                  child: ErrorContainer(
                    errorMessage: state.errorMessage,
                    onTapRetry: () {
                      getTopics();
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
          buttonTitle: createTopicKey,
          showBorder: false,
          onTap: () {
            Get.toNamed(Routes.teacherAddEditTopicScreen,
                arguments: TeacherAddEditTopicScreen.buildArguments(
                  topic: null,
                  selectedClassSection: _selectedClassSection,
                  selectedLesson: _selectedLesson,
                  selectedSubject: _selectedSubject,
                ))?.then((value) {
              if (value != null && value is bool && value) {
                //re-fetch topics if they edit or add
                getTopics();
                didCreateNewTopic = true;
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
              const CustomAppbar(titleKey: manageTopicKey),
              AppbarFilterBackgroundContainer(
                height: 130,
                child: LayoutBuilder(builder: (context, boxConstraints) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FilterButton(
                              onTap: () {
                                if (state
                                    is ClassSectionsAndSubjectsFetchSuccess) {
                                  Utils.showBottomSheet(
                                      child: FilterSelectionBottomsheet<
                                          ClassSection>(
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
                                  if (state
                                      is ClassSectionsAndSubjectsFetchSuccess) {
                                    Utils.showBottomSheet(
                                        child: FilterSelectionBottomsheet<
                                            TeacherSubject>(
                                          selectedValue: _selectedSubject!,
                                          titleKey: subjectKey,
                                          values: state.subjects,
                                          onSelection: (value) {
                                            changeSelectedTeacherSubject(
                                                value!);
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
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 40,
                        child: BlocConsumer<LessonsCubit, LessonsState>(
                          listener: (context, state) {
                            if (state is LessonsFetchSuccess) {
                              if (state.lessons.isNotEmpty) {
                                _selectedLesson = state.lessons.first;
                                getTopics();
                                setState(() {});
                              }
                            }
                          },
                          builder: (context, state) {
                            return FilterButton(
                              onTap: () {
                                if (state is LessonsFetchSuccess) {
                                  Utils.showBottomSheet(
                                      child: FilterSelectionBottomsheet<Lesson>(
                                        selectedValue: _selectedLesson!,
                                        titleKey: lessonKey,
                                        values: state.lessons,
                                        onSelection: (value) {
                                          if (value != _selectedLesson) {
                                            _selectedLesson = value;
                                            getTopics();
                                            setState(() {});
                                          }
                                          Get.back();
                                        },
                                      ),
                                      context: context);
                                }
                              },
                              titleKey: _selectedLesson?.id == null
                                  ? lessonKey
                                  : _selectedLesson?.name ?? "",
                              width: boxConstraints.maxWidth,
                            );
                          },
                        ),
                      ),
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        Get.back(result: didCreateNewTopic);
      },
      child: Scaffold(
        body: Stack(
          children: [
            if (widget.selectedLesson == null) ...[
              BlocBuilder<LessonsCubit, LessonsState>(
                  builder: (context, lessonState) {
                return BlocBuilder<ClassSectionsAndSubjectsCubit,
                    ClassSectionsAndSubjectsState>(
                  builder: (context, state) {
                    if (state is ClassSectionsAndSubjectsFetchSuccess &&
                        lessonState is LessonsFetchSuccess) {
                      if (lessonState.lessons.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return _buildTopicList();
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

                    if (lessonState is LessonsFetchFailure) {
                      return Center(
                          child: ErrorContainer(
                        errorMessage: lessonState.errorMessage,
                        onTapRetry: () {
                          getLessons();
                        },
                      ));
                    }

                    return Center(
                      child: CustomCircularProgressIndicator(
                        indicatorColor: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                );
              }),
            ] else ...[
              _buildTopicList(),
            ],
            _buildSubmitButton(),
            if (widget.selectedLesson == null) ...[
              _buildAppbarAndFilters(),
            ] else ...[
              CustomAppbar(
                titleKey: widget.selectedLesson?.name ?? "",
                onBackButtonTap: () {
                  Get.back(result: didCreateNewTopic);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
