import '../../domain/entities/attendance_record_entity.dart';
import '../../domain/entities/attendance_status.dart';

/// Data Transfer Object (DTO) model for student attendance record.
class AttendanceRecordModel extends AttendanceRecordEntity {
  const AttendanceRecordModel({
    required super.id,
    required super.subjectName,
    required super.date,
    required super.status,
  });

  /// Factory constructor to parse JSON map to [AttendanceRecordModel].
  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      id: json['id'] as String,
      subjectName: json['subject_name'] as String,
      date: DateTime.parse(json['date'] as String),
      status: _parseStatus(json['status'] as String),
    );
  }

  /// Converts [AttendanceRecordModel] instance into JSON map representation.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'subject_name': subjectName,
      'date': date.toIso8601String(),
      'status': status.name,
    };
  }

  static AttendanceStatus _parseStatus(String statusStr) {
    switch (statusStr.toLowerCase()) {
      case 'absent':
        return AttendanceStatus.absent;
      case 'late':
        return AttendanceStatus.late;
      case 'present':
      default:
        return AttendanceStatus.present;
    }
  }
}
