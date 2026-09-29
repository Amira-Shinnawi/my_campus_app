import '../../domain/entities/class_entity.dart';

/// Data Transfer Object (DTO) model for student class session.
class ClassModel extends ClassEntity {
  const ClassModel({
    required super.id,
    required super.subjectName,
    required super.instructorName,
    required super.day,
    required super.startTime,
    required super.endTime,
    required super.location,
    required super.type,
  });

  /// Factory constructor to parse JSON map to [ClassModel].
  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] as String,
      subjectName: json['subject_name'] as String,
      instructorName: json['instructor_name'] as String,
      day: json['day'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      location: json['location'] as String,
      type: json['type'] as String,
    );
  }

  /// Converts [ClassModel] instance into JSON map representation.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'subject_name': subjectName,
      'instructor_name': instructorName,
      'day': day,
      'start_time': startTime,
      'end_time': endTime,
      'location': location,
      'type': type,
    };
  }
}
