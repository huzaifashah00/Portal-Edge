import 'package:uol_teacher_admin/data/repositories/teacherAnnouncementRepository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TeacherEditAnnouncementState {}

class TeacherEditAnnouncementInitial extends TeacherEditAnnouncementState {}

class TeacherEditAnnouncementInProgress extends TeacherEditAnnouncementState {}

class TeacherEditAnnouncementSuccess extends TeacherEditAnnouncementState {}

class TeacherEditAnnouncementFailure extends TeacherEditAnnouncementState {
  final String errorMessage;

  TeacherEditAnnouncementFailure(this.errorMessage);
}

class TeacherEditAnnouncementCubit extends Cubit<TeacherEditAnnouncementState> {
  final TeacherAnnouncementRepository _announcementRepository =
      TeacherAnnouncementRepository();

  TeacherEditAnnouncementCubit() : super(TeacherEditAnnouncementInitial());

  Future<void> editAnnouncement({
    required String title,
    required String description,
    required List<PlatformFile> attachments,
    required int classSectionId,
    required int classSubjectId,
    required int announcementId,
  }) async {
    emit(TeacherEditAnnouncementInProgress());
    try {
      await _announcementRepository.updateAnnouncement(
        title: title,
        description: description,
        attachments: attachments,
        classSectionId: classSectionId,
        classSubjectId: classSubjectId,
        announcementId: announcementId,
      );
      emit(TeacherEditAnnouncementSuccess());
    } catch (e) {
      emit(TeacherEditAnnouncementFailure(e.toString()));
    }
  }
}
