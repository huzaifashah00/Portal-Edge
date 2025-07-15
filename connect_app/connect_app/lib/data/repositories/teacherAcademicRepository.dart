import 'package:uol_teacher_admin/data/models/classSection.dart';
import 'package:uol_teacher_admin/data/models/timeTableSlot.dart';
import 'package:uol_teacher_admin/utils/api.dart';

class TeacherAcademicsRepository {
  Future<List<TimeTableSlot>> getTeacherMyTimetable() async {
    try {
      final result = await Api.get(
        url: Api.getTeacherMyTimetable,
      );
      return ((result['data'] ?? []) as List)
          .map((timeTableSlot) =>
              TimeTableSlot.fromJson(Map.from(timeTableSlot ?? {})))
          .toList();
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<List<ClassSection>> getClassSectionDetails({int? classId}) async {
    try {
      final result = await Api.post(
        url: Api.getClassDetails,
        body: {if (classId != null) "class_id": classId},
      );
      return ((result['data'] ?? []) as List)
          .map((classDetails) =>
              ClassSection.fromJson(Map.from(classDetails ?? {})))
          .toList();
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
