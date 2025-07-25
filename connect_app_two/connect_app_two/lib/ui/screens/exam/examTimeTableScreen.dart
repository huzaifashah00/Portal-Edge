import 'package:uol_student/cubits/authCubit.dart';
import 'package:uol_student/cubits/examTimeTableCubit.dart';
import 'package:uol_student/data/models/exam.dart';
import 'package:uol_student/data/models/student.dart';
import 'package:uol_student/data/repositories/studentRepository.dart';
import 'package:uol_student/ui/widgets/customShimmerContainer.dart';
import 'package:uol_student/ui/widgets/errorContainer.dart';
import 'package:uol_student/ui/widgets/noDataContainer.dart';
import 'package:uol_student/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:uol_student/ui/widgets/shimmerLoadingContainer.dart';
import 'package:uol_student/ui/widgets/subjectImageContainer.dart';
import 'package:uol_student/ui/widgets/svgButton.dart';
import 'package:uol_student/utils/animationConfiguration.dart';
import 'package:uol_student/utils/labelKeys.dart';
import 'package:uol_student/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ExamTimeTableScreen extends StatefulWidget {
  final int? childID;
  final int examID;
  final String examName;

  const ExamTimeTableScreen({
    Key? key,
    this.childID,
    required this.examID,
    required this.examName,
  }) : super(key: key);

  @override
  State<ExamTimeTableScreen> createState() => _ExamTimeTableState();

  static Widget routeInstance() {
    final examDetails = Get.arguments as Map<String, dynamic>;

    return BlocProvider(
      create: (context) => ExamTimeTableCubit(StudentRepository()),
      child: ExamTimeTableScreen(
        childID: examDetails['childID'],
        examID: examDetails['examID'],
        examName: examDetails['examName'],
      ),
    );
  }
}

class _ExamTimeTableState extends State<ExamTimeTableScreen> {
  //
  Widget _buildExamTimeTableContainer({
    required ExamTimeTable examTimeTable,
  }) {
    final subjectDetails = examTimeTable.subject;
    return Container(
      margin: EdgeInsetsDirectional.only(
        bottom: 20.0,
        start: MediaQuery.of(context).size.width * (0.15),
        end: MediaQuery.of(context).size.width * (0.075),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              PositionedDirectional(
                top: boxConstraints.maxHeight * (0.5) -
                    boxConstraints.maxWidth * (0.118),
                start: boxConstraints.maxWidth * (-0.125),
                child: SubjectImageContainer(
                  showShadow: true,
                  height: boxConstraints.maxWidth * (0.235),
                  radius: 10,
                  subject: subjectDetails!,
                  width: boxConstraints.maxWidth * (0.26),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: boxConstraints.maxWidth * (0.175),
                    top: boxConstraints.maxHeight * (0.125),
                    bottom: boxConstraints.maxHeight * (0.075),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: boxConstraints.maxWidth * 0.51,
                            child: Text(
                              subjectDetails.name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.center,
                            width: boxConstraints.maxWidth * (0.31),
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 3,
                            ),
                            child: Text(
                              '${examTimeTable.totalMarks} ${Utils.getTranslatedLabel(marksKey)}', //
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.75,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subjectDetails.type == ' '
                          ? const SizedBox()
                          : Text(
                              Utils.getTranslatedLabel(
                                  subjectDetails.isPractial()
                                      ? practicalKey
                                      : theoryKey),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w400,
                                fontSize: 10.5,
                              ),
                            ),
                      const Spacer(),
                      examTimeTable.date == ''
                          ? const SizedBox()
                          : Text(
                              Utils.formatDate(
                                DateTime.parse(examTimeTable.date!),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.0,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                              ),
                            ),
                      examTimeTable.startingTime == '' &&
                              examTimeTable.endingTime == ''
                          ? const SizedBox()
                          : Text(
                              '${Utils.formatTime(examTimeTable.startingTime!)} - ${Utils.formatTime(examTimeTable.endingTime!)}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w400,
                                fontSize: 10.5,
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExamTimeTableLoading() {
    return Column(
      children: List.generate(
        Utils.defaultShimmerLoadingContentCount,
        (index) => _buildShimmerLoadingExamTimeTableContainer(context),
      ),
    );
  }

  Widget _buildExamTimeTableDetailsContainer() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: Utils.getScrollViewBottomPadding(context),
        top: Utils.getScrollViewTopPadding(
          context: context,
          appBarHeightPercentage: Utils.appBarBiggerHeightPercentage - 0.025,
        ),
      ),
      child: BlocBuilder<ExamTimeTableCubit, ExamTimeTableState>(
        builder: (context, state) {
          if (state is ExamTimeTableFetchSuccess) {
            return state.examTimeTableList.isEmpty
                ? const NoDataContainer(titleKey: noExamTimeTableFoundKey)
                : Column(
                    children: List.generate(
                      state.examTimeTableList.length,
                      (index) => Animate(
                        effects: listItemAppearanceEffects(
                          itemIndex: index,
                          totalLoadedItems: state.examTimeTableList.length,
                        ),
                        child: _buildExamTimeTableContainer(
                          examTimeTable: state.examTimeTableList[index],
                        ),
                      ),
                    ),
                  );
          } else if (state is ExamTimeTableFetchFailure) {
            return ErrorContainer(
              errorMessageCode: state.errorMessage,
              onTapRetry: fetchExamTimeTableList,
            );
          }

          return _buildExamTimeTableLoading();
        },
      ),
    );
  }

  void fetchExamTimeTableList() {
    context.read<ExamTimeTableCubit>().fetchStudentExamsList(
          useParentApi: context.read<AuthCubit>().isParent(),
          examID: widget.examID,
          childId: widget.childID,
        );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchExamTimeTableList();
    });
  }

  Widget _buildAppBar(BuildContext context) {
    String studentName = "";
    if (context.read<AuthCubit>().isParent()) {
      final Student student =
          (context.read<AuthCubit>().getParentDetails().children ?? [])
              .where((element) => element.id == widget.childID)
              .first;

      studentName = "${student.firstName} ${student.lastName}";
    }
    return ScreenTopBackgroundContainer(
      heightPercentage: Utils.appBarMediumtHeightPercentage,
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Utils.screenContentHorizontalPadding,
                  ),
                  child: SvgButton(
                    onTap: () {
                      Get.back();
                    },
                    svgIconUrl: Utils.getBackButtonPath(context),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  Utils.getTranslatedLabel(examTimeTableKey),
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: Utils.screenTitleFontSize,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: boxConstraints.maxHeight * (0.075) +
                        Utils.screenTitleFontSize,
                  ),
                  child: Text(
                    studentName,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: Utils.screenSubTitleFontSize,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                left: MediaQuery.of(context).size.width * (0.075),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 12.5,
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.075),
                        offset: const Offset(2.5, 2.5),
                        blurRadius: 5,
                      )
                    ],
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  width: MediaQuery.of(context).size.width * (0.85),
                  child: Column(
                    children: [
                      Text(
                        widget.examName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
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
          Align(
            alignment: Alignment.topCenter,
            child: _buildExamTimeTableDetailsContainer(),
          ),
          Align(alignment: Alignment.topCenter, child: _buildAppBar(context)),
        ],
      ),
    );
  }

  Container _buildShimmerLoadingExamTimeTableContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        bottom: 20,
        left: MediaQuery.of(context).size.width * (0.075),
        right: MediaQuery.of(context).size.width * (0.075),
      ),
      height: 90,
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          return ShimmerLoadingContainer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmerContainer(
                  borderRadius: 10,
                  height: boxConstraints.maxHeight,
                  width: boxConstraints.maxWidth * (0.26),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.05),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: boxConstraints.maxHeight * (0.075),
                    ),
                    CustomShimmerContainer(
                      borderRadius: 10,
                      width: boxConstraints.maxWidth * (0.6),
                    ),
                    SizedBox(
                      height: boxConstraints.maxHeight * (0.075),
                    ),
                    CustomShimmerContainer(
                      height: 8,
                      borderRadius: 10,
                      width: boxConstraints.maxWidth * (0.45),
                    ),
                    const Spacer(),
                    CustomShimmerContainer(
                      height: 8,
                      borderRadius: 10,
                      width: boxConstraints.maxWidth * (0.3),
                    ),
                    SizedBox(
                      height: boxConstraints.maxHeight * (0.075),
                    ),
                    CustomShimmerContainer(
                      height: 8,
                      borderRadius: 10,
                      width: boxConstraints.maxWidth * (0.3),
                    ),
                    SizedBox(
                      height: boxConstraints.maxHeight * (0.075),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
