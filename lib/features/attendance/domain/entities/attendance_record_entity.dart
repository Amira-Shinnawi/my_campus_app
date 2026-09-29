import 'package:equatable/equatable.dart';

import 'attendance_status.dart';

/// Entity representing a single attendance log entry.
class AttendanceRecordEntity extends Equatable {
  /// Unique record identifier.
  final String id;

  /// Subject name.
  final String subjectName;

  /// Session date.
  final DateTime date;

  /// Attendance status for this session.
  final AttendanceStatus status;

  const AttendanceRecordEntity({
    required this.id,
    required this.subjectName,
    required this.date,
    required this.status,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        subjectName,
        date,
        status,
      ];
}
