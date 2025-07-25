import 'package:uol_teacher_admin/data/models/classSection.dart';
import 'package:uol_teacher_admin/data/models/subject.dart';

class TimeTableSlot {
  final int? id;
  final int? subjectTeacherId;
  final int? classSectionId;
  final int? subjectId;
  final String? startTime;
  final String? endTime;
  final String? note;
  final String? day;
  final String? type;
  final int? semesterId;
  final int? schoolId;
  final String? createdAt;
  final String? updatedAt;
  final String? title;
  final ClassSection? classSection;
  final Subject? subject;

  TimeTableSlot(
      {this.id,
      this.subjectTeacherId,
      this.classSectionId,
      this.subjectId,
      this.startTime,
      this.endTime,
      this.note,
      this.day,
      this.type,
      this.semesterId,
      this.schoolId,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.classSection,
      this.subject});

  TimeTableSlot copyWith(
      {int? id,
      int? subjectTeacherId,
      int? classSectionId,
      int? subjectId,
      String? startTime,
      String? endTime,
      String? note,
      String? day,
      String? type,
      int? semesterId,
      int? schoolId,
      String? createdAt,
      String? updatedAt,
      String? title,
      ClassSection? classSection,
      Subject? subject}) {
    return TimeTableSlot(
      id: id ?? this.id,
      classSection: classSection ?? this.classSection,
      subject: subject ?? this.subject,
      subjectTeacherId: subjectTeacherId ?? this.subjectTeacherId,
      classSectionId: classSectionId ?? this.classSectionId,
      subjectId: subjectId ?? this.subjectId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      note: note ?? this.note,
      day: day ?? this.day,
      type: type ?? this.type,
      semesterId: semesterId ?? this.semesterId,
      schoolId: schoolId ?? this.schoolId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
    );
  }

  TimeTableSlot.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        subjectTeacherId = json['subject_teacher_id'] as int?,
        classSectionId = json['class_section_id'] as int?,
        subjectId = json['subject_id'] as int?,
        startTime = json['start_time'] as String?,
        endTime = json['end_time'] as String?,
        note = json['note'] as String?,
        day = json['day'] as String?,
        type = json['type'] as String?,
        semesterId = json['semester_id'] as int?,
        schoolId = json['school_id'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        classSection =
            ClassSection.fromJson(Map.from(json['class_section'] ?? {})),
        subject = Subject.fromJson(Map.from(json['subject'] ?? {})),
        title = json['title'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject_teacher_id': subjectTeacherId,
        'class_section_id': classSectionId,
        'subject_id': subjectId,
        'start_time': startTime,
        'end_time': endTime,
        'note': note,
        'day': day,
        'type': type,
        'semester_id': semesterId,
        'school_id': schoolId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'title': title
      };
}
