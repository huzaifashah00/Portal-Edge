import 'package:uol_teacher_admin/data/models/subject.dart';

class OfflineExamTimeTableSlot {
  final int? totalMarks;
  final int? passingMarks;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? subjectName;
  final Subject? subject;

  OfflineExamTimeTableSlot({
    this.totalMarks,
    this.passingMarks,
    this.date,
    this.startTime,
    this.endTime,
    this.subjectName,
    this.subject,
  });

  OfflineExamTimeTableSlot copyWith({
    int? totalMarks,
    int? passingMarks,
    String? date,
    String? startTime,
    String? endTime,
    String? subjectName,
    Subject? subject,
  }) {
    return OfflineExamTimeTableSlot(
      totalMarks: totalMarks ?? this.totalMarks,
      passingMarks: passingMarks ?? this.passingMarks,
      subject: subject ?? this.subject,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      subjectName: subjectName ?? this.subjectName,
    );
  }

  OfflineExamTimeTableSlot.fromJson(Map<String, dynamic> json)
      : totalMarks = json['total_marks'] as int?,
        passingMarks = json['passing_marks'] as int?,
        date = json['date'] as String?,
        startTime = json['start_time'] as String?,
        endTime = json['end_time'] as String?,
        subject =
            Subject.fromJson(Map.from(json['class_subject']?['subject'] ?? {})),
        subjectName = json['subject_name'] as String?;

  Map<String, dynamic> toJson() => {
        'total_marks': totalMarks,
        'passing_marks': passingMarks,
        'date': date,
        'start_time': startTime,
        'end_time': endTime,
        'subject_name': subjectName,
      };
}
