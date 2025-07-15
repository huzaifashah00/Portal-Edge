import 'package:uol_teacher_admin/data/models/leaveDetails.dart';
import 'package:uol_teacher_admin/data/repositories/leaveRepository.dart';
import 'package:uol_teacher_admin/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GeneralLeavesState {}

class GeneralLeavesInitial extends GeneralLeavesState {}

class GeneralLeavesFetchInProgress extends GeneralLeavesState {}

class GeneralLeavesFetchSuccess extends GeneralLeavesState {
  final List<LeaveDetails> leaves;

  GeneralLeavesFetchSuccess({required this.leaves});
}

class GeneralLeavesFetchFailure extends GeneralLeavesState {
  final String errorMessage;

  GeneralLeavesFetchFailure(this.errorMessage);
}

class GeneralLeavesCubit extends Cubit<GeneralLeavesState> {
  final LeaveRepository _leaveRepository = LeaveRepository();

  GeneralLeavesCubit() : super(GeneralLeavesInitial());

  void getGeneralLeaves({required LeaveDayType leaveDayType}) async {
    try {
      emit(GeneralLeavesFetchInProgress());

      emit(GeneralLeavesFetchSuccess(
          leaves:
              await _leaveRepository.getLeaves(leaveDayType: leaveDayType)));
    } catch (e) {
      emit(GeneralLeavesFetchFailure(e.toString()));
    }
  }
}
