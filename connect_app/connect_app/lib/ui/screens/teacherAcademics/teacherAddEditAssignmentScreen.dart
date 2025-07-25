import 'package:uol_teacher_admin/cubits/teacherAcademics/assignment/createAssignmentCubit.dart';
import 'package:uol_teacher_admin/cubits/teacherAcademics/assignment/editAssignmentCubit.dart';
import 'package:uol_teacher_admin/cubits/teacherAcademics/classSectionsAndSubjects.dart';
import 'package:uol_teacher_admin/data/models/assignment.dart';
import 'package:uol_teacher_admin/data/models/classSection.dart';
import 'package:uol_teacher_admin/data/models/studyMaterial.dart';
import 'package:uol_teacher_admin/data/models/teacherSubject.dart';
import 'package:uol_teacher_admin/ui/screens/teacherAcademics/widgets/customFileContainer.dart';
import 'package:uol_teacher_admin/ui/screens/teacherAcademics/widgets/studyMaterialContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/customAppbar.dart';
import 'package:uol_teacher_admin/ui/widgets/customCheckboxContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/customCircularProgressIndicator.dart';
import 'package:uol_teacher_admin/ui/widgets/customDropdownSelectionButton.dart';
import 'package:uol_teacher_admin/ui/widgets/customRoundedButton.dart';
import 'package:uol_teacher_admin/ui/widgets/customTextFieldContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/errorContainer.dart';
import 'package:uol_teacher_admin/ui/widgets/filterSelectionBottomsheet.dart';
import 'package:uol_teacher_admin/ui/widgets/uploadImageOrFileButton.dart';
import 'package:uol_teacher_admin/utils/constants.dart';
import 'package:uol_teacher_admin/utils/labelKeys.dart';
import 'package:uol_teacher_admin/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TeacherAddEditAssignmentScreen extends StatefulWidget {
  final Assignment? assignment;
  final ClassSection? selectedClassSection;
  final TeacherSubject? selectedSubject;
  static Widget getRouteInstance() {
    final arguments = Get.arguments as Map<String, dynamic>?;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateAssignmentCubit(),
        ),
        BlocProvider(
          create: (context) => EditAssignmentCubit(),
        ),
        BlocProvider(
          create: (context) => ClassSectionsAndSubjectsCubit(),
        ),
      ],
      child: TeacherAddEditAssignmentScreen(
        assignment: arguments?['assignment'],
        selectedClassSection: arguments?['selectedClassSection'],
        selectedSubject: arguments?['selectedSubject'],
      ),
    );
  }

  static Map<String, dynamic> buildArguments(
      {required Assignment? assignment,
      required ClassSection? selectedClassSection,
      required TeacherSubject? selectedSubject}) {
    return {
      "assignment": assignment,
      "selectedClassSection": selectedClassSection,
      "selectedSubject": selectedSubject
    };
  }

  const TeacherAddEditAssignmentScreen(
      {super.key,
      required this.assignment,
      this.selectedClassSection,
      this.selectedSubject});

  @override
  State<TeacherAddEditAssignmentScreen> createState() =>
      _TeacherAddEditAssignmentScreenState();
}

class _TeacherAddEditAssignmentScreenState
    extends State<TeacherAddEditAssignmentScreen> {
  late ClassSection? _selectedClassSection = widget.selectedClassSection;
  late TeacherSubject? _selectedSubject = widget.selectedSubject;

  //This will determine if need to refresh the previous page
  //assignments data. If teacher remove the the any file
  //so we need to fetch the list again
  late bool refreshAssignmentsInPreviousPage = false;

  late final TextEditingController _assignmentNameTextEditingController =
      TextEditingController(
    text: widget.assignment?.name,
  );
  late final TextEditingController _assignmentInstructionTextEditingController =
      TextEditingController(
    text: widget.assignment?.instructions,
  );

  late final TextEditingController _assignmentPointsTextEditingController =
      TextEditingController(
    text: widget.assignment?.points.toString(),
  );

  late final TextEditingController _extraResubmissionDaysTextEditingController =
      TextEditingController(
    text: widget.assignment?.extraDaysForResubmission.toString(),
  );

  late bool _allowedReSubmissionOfRejectedAssignment =
      widget.assignment?.resubmission == 0;

  late DateTime? dueDate =
      DateTime.tryParse(widget.assignment?.dueDate.toString() ?? "");

  late TimeOfDay? dueTime = widget.assignment != null
      ? TimeOfDay.fromDateTime(widget.assignment!.dueDate)
      : null;

  List<PlatformFile> uploadedFiles = [];

  late List<StudyMaterial> assignmentAttachments =
      widget.assignment?.studyMaterial ?? [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        context
            .read<ClassSectionsAndSubjectsCubit>()
            .getClassSectionsAndSubjects(
                classSectionId: _selectedClassSection?.id);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _assignmentNameTextEditingController.dispose();
    _assignmentInstructionTextEditingController.dispose();
    _assignmentPointsTextEditingController.dispose();
    _extraResubmissionDaysTextEditingController.dispose();
    super.dispose();
  }

  Future<void> _addFiles() async {
    final result = await Utils.openFilePicker(context: context);
    if (result != null) {
      uploadedFiles.addAll(result.files);
      setState(() {});
    }
  }

  Future<void> openDatePicker() async {
    final temp = await Utils.openDatePicker(context: context);
    if (temp != null) {
      dueDate = temp;
      setState(() {});
    }
  }

  Future<void> openTimePicker() async {
    final temp = await Utils.openTimePicker(context: context);
    if (temp != null) {
      dueTime = temp;
      setState(() {});
    }
  }

  void showErrorMessage(String errorMessageKey) {
    Utils.showSnackBar(
      context: context,
      message: errorMessageKey,
    );
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
              final successState = (context
                  .read<ClassSectionsAndSubjectsCubit>()
                  .state as ClassSectionsAndSubjectsFetchSuccess);
              changeSelectedTeacherSubject(successState.subjects.firstOrNull);
            }
          }
        });
      }
      setState(() {});
    }
  }

  void changeSelectedTeacherSubject(TeacherSubject? teacherSubject,
      {bool fetchNewLessons = true}) {
    if (_selectedSubject != teacherSubject) {
      _selectedSubject = teacherSubject;
      setState(() {});
    }
  }

  void createAssignment() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_selectedSubject == null) {
      showErrorMessage(noSubjectSelectedKey);
      return;
    }

    if (_selectedClassSection == null) {
      showErrorMessage(noClassSectionSelectedKey);
      return;
    }

    if (_assignmentNameTextEditingController.text.trim().isEmpty) {
      showErrorMessage(pleaseEnterAssignmentNameKey);
      return;
    }
    if (_assignmentPointsTextEditingController.text.length >= 10) {
      showErrorMessage(invalidPointsLengthKey);
      return;
    }
    if (dueDate == null) {
      showErrorMessage(pleaseSelectDateKey);
      return;
    }
    if (dueTime == null) {
      showErrorMessage(pleaseSelectTimeKey);
      return;
    }
    if (_extraResubmissionDaysTextEditingController.text.trim().isEmpty &&
        _allowedReSubmissionOfRejectedAssignment) {
      showErrorMessage(pleaseEnterExtraDaysForResubmissionKey);
      return;
    }

    context.read<CreateAssignmentCubit>().createAssignment(
          classSectionId: _selectedClassSection?.id ?? 0,
          classSubjectId: _selectedSubject?.classSubjectId ?? 0,
          name: _assignmentNameTextEditingController.text.trim(),
          dateTime:
              "${DateFormat('dd-MM-yyyy').format(dueDate!).toString()} ${dueTime!.hour}:${dueTime!.minute}",
          extraDayForResubmission:
              _extraResubmissionDaysTextEditingController.text.trim(),
          instruction: _assignmentInstructionTextEditingController.text.trim(),
          points: _assignmentPointsTextEditingController.text.trim(),
          resubmission: _allowedReSubmissionOfRejectedAssignment,
          file: uploadedFiles,
        );
  }

  void editAssignment() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_assignmentNameTextEditingController.text.trim().isEmpty) {
      showErrorMessage(pleaseEnterAssignmentNameKey);
    }
    if (dueDate == null) {
      showErrorMessage(pleaseSelectDateKey);
    }
    if (_assignmentPointsTextEditingController.text.length >= 10) {
      showErrorMessage(invalidPointsLengthKey);
      return;
    }
    if (dueTime == null) {
      showErrorMessage(pleaseSelectDateKey);
    }
    if (_extraResubmissionDaysTextEditingController.text.trim().isEmpty &&
        _allowedReSubmissionOfRejectedAssignment) {
      showErrorMessage(pleaseEnterExtraDaysForResubmissionKey);
      return;
    }

    context.read<EditAssignmentCubit>().editAssignment(
          classSelectionId: _selectedClassSection?.id ?? 0,
          classSubjectId: _selectedSubject?.classSubjectId ?? 0,
          name: _assignmentNameTextEditingController.text.trim(),
          dateTime:
              "${DateFormat('dd-MM-yyyy').format(dueDate!).toString()} ${dueTime!.hour}:${dueTime!.minute}",
          extraDayForResubmission:
              _extraResubmissionDaysTextEditingController.text.trim(),
          instruction: _assignmentInstructionTextEditingController.text.trim(),
          points: _assignmentPointsTextEditingController.text.trim(),
          resubmission: _allowedReSubmissionOfRejectedAssignment ? 1 : 0,
          filePaths: uploadedFiles,
          assignmentId: widget.assignment!.id,
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
        child: widget.assignment != null
            ? BlocConsumer<EditAssignmentCubit, EditAssignmentState>(
                listener: (context, state) {
                  if (state is EditAssignmentSuccess) {
                    Get.back(result: true);
                    Utils.showSnackBar(
                        context: context,
                        message: assignmentEditedSuccessfullyKey);
                  } else if (state is EditAssignmentFailure) {
                    Utils.showSnackBar(
                        context: context, message: state.errorMessage);
                  }
                },
                builder: (context, state) {
                  return CustomRoundedButton(
                      height: 40,
                      widthPercentage: 1.0,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      buttonTitle: submitKey,
                      showBorder: false,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (state is EditAssignmentInProgress) {
                          return;
                        }
                        editAssignment();
                      },
                      child: state is EditAssignmentInProgress
                          ? const CustomCircularProgressIndicator(
                              strokeWidth: 2,
                              widthAndHeight: 20,
                            )
                          : null);
                },
              )
            : BlocConsumer<CreateAssignmentCubit, CreateAssignmentState>(
                listener: (context, state) {
                  if (state is CreateAssignmentSuccess) {
                    Utils.showSnackBar(
                        context: context,
                        message: assignmentAddedSuccessfullyKey);
                    _assignmentNameTextEditingController.text = "";
                    _assignmentInstructionTextEditingController.text = "";
                    _assignmentPointsTextEditingController.text = "";
                    _extraResubmissionDaysTextEditingController.text = "";
                    _allowedReSubmissionOfRejectedAssignment = false;
                    dueDate = null;
                    dueTime = null;
                    uploadedFiles = [];
                    assignmentAttachments = [];
                    refreshAssignmentsInPreviousPage = true;
                    setState(() {});
                  } else if (state is CreateAssignmentFailure) {
                    Utils.showSnackBar(
                      context: context,
                      message: state.errorMessage,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomRoundedButton(
                      height: 40,
                      widthPercentage: 1.0,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      buttonTitle: submitKey,
                      showBorder: false,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (state is CreateAssignmentInProcess) {
                          return;
                        }
                        createAssignment();
                      },
                      child: state is CreateAssignmentInProcess
                          ? const CustomCircularProgressIndicator(
                              strokeWidth: 2,
                              widthAndHeight: 20,
                            )
                          : null);
                },
              ),
      ),
    );
  }

  Widget _buildAddEditAssignmentForm() {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: 100,
            left: appContentHorizontalPadding,
            right: appContentHorizontalPadding,
            top: Utils.appContentTopScrollPadding(context: context) + 20),
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
            return state is ClassSectionsAndSubjectsFetchFailure
                ? Center(
                    child: ErrorContainer(
                    errorMessage: state.errorMessage,
                    onTapRetry: () {
                      context
                          .read<ClassSectionsAndSubjectsCubit>()
                          .getClassSectionsAndSubjects();
                    },
                  ))
                : Column(
                    children: [
                      CustomSelectionDropdownSelectionButton(
                        isDisabled: widget.assignment !=
                            null, //if user is editing, they can't change class
                        onTap: () {
                          if (state is ClassSectionsAndSubjectsFetchSuccess) {
                            Utils.showBottomSheet(
                                child: FilterSelectionBottomsheet<ClassSection>(
                                  showFilterByLabel: false,
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
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomSelectionDropdownSelectionButton(
                        isDisabled: widget.assignment !=
                            null, //if user is editing, they can't change subject
                        onTap: () {
                          if (state is ClassSectionsAndSubjectsFetchSuccess) {
                            Utils.showBottomSheet(
                                child:
                                    FilterSelectionBottomsheet<TeacherSubject>(
                                  showFilterByLabel: false,
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
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFieldContainer(
                          textEditingController:
                              _assignmentNameTextEditingController,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          hintTextKey: assignmentNameKey),
                      CustomTextFieldContainer(
                          textEditingController:
                              _assignmentInstructionTextEditingController,
                          maxLines: 5,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          hintTextKey: instructionsKey),
                      Row(
                        children: [
                          Expanded(
                            child: CustomSelectionDropdownSelectionButton(
                              onTap: () {
                                openDatePicker();
                              },
                              titleKey: dueDate != null
                                  ? Utils.getFormattedDate(dueDate!)
                                  : dueDateKey,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: CustomSelectionDropdownSelectionButton(
                              onTap: () {
                                openTimePicker();
                              },
                              titleKey: dueTime != null
                                  ? Utils.getFormattedDayOfTime(dueTime!)
                                  : dueTimeKey,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFieldContainer(
                        keyboardType: TextInputType.number,
                        textEditingController:
                            _assignmentPointsTextEditingController,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        hintTextKey: pointsKey,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      CustomCheckboxContainer(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        titleKey: resubmissionAllowedKey,
                        value: _allowedReSubmissionOfRejectedAssignment,
                        onValueChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              _allowedReSubmissionOfRejectedAssignment = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (_allowedReSubmissionOfRejectedAssignment) ...[
                        CustomTextFieldContainer(
                            textEditingController:
                                _extraResubmissionDaysTextEditingController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            hintTextKey: extraDaysForResubmissionKey),
                      ],

                      //pre-added study materials
                      widget.assignment != null
                          ? Column(
                              children: assignmentAttachments
                                  .map(
                                    (studyMaterial) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: StudyMaterialContainer(
                                        onDeleteStudyMaterial: (fileId) {
                                          assignmentAttachments.removeWhere(
                                              (element) =>
                                                  element.id == fileId);
                                          refreshAssignmentsInPreviousPage =
                                              true;
                                          setState(() {});
                                        },
                                        showOnlyStudyMaterialTitles: true,
                                        showEditAndDeleteButton: true,
                                        studyMaterial: studyMaterial,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          : const SizedBox(),

                      UploadImageOrFileButton(
                        uploadFile: true,
                        includeImageFileOnlyAllowedNote: true,
                        onTap: () {
                          _addFiles();
                        },
                      ),

                      //user's added study materials
                      ...List.generate(uploadedFiles.length, (index) => index)
                          .map(
                        (index) => Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: CustomFileContainer(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            onDelete: () {
                              uploadedFiles.removeAt(index);
                              setState(() {});
                            },
                            title: uploadedFiles[index].name,
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
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
        Get.back(result: refreshAssignmentsInPreviousPage);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: [
            _buildAddEditAssignmentForm(),
            _buildSubmitButton(),
            Align(
              alignment: Alignment.topCenter,
              child: CustomAppbar(
                titleKey: widget.assignment != null
                    ? editAssignmentKey
                    : createAssignmentKey,
                onBackButtonTap: () {
                  Get.back(result: refreshAssignmentsInPreviousPage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
