import 'package:uol_teacher_admin/data/models/timeTableSlot.dart';
import 'package:uol_teacher_admin/data/models/userDetails.dart';
import 'package:uol_teacher_admin/utils/api.dart';

class TeacherRepository {
  Future<List<UserDetails>> getTeachers({String? search}) async {
    try {
      final result = await Api.get(
          url: Api.getTeachers, queryParameters: {"search": search});
      return ((result['data'] ?? []) as List)
          .map((teacher) => UserDetails.fromJson(Map.from(teacher ?? {})))
          .toList();
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<List<TimeTableSlot>> getTimeTableOfTeacher(
      {required int teacherId}) async {
    try {
      final result = await Api.get(
          url: Api.getTimeTableOfTeacher,
          queryParameters: {"teacher_id": teacherId});
      return ((result['data'] ?? []) as List)
          .map((timeTableSlot) =>
              TimeTableSlot.fromJson(Map.from(timeTableSlot ?? {})))
          .toList();
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
