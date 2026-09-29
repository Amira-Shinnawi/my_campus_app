import 'package:equatable/equatable.dart';

/// Entity representing aggregated attendance summary for a specific subject.
class SubjectAttendanceEntity extends Equatable {
  /// Name of the subject.
  final String subjectName;

  /// Total number of sessions held for this subject.
  final int totalSessions;

  /// Number of sessions attended (Present or Late).
  final int attendedSessions;

  /// Number of late sessions.
  final int lateSessions;

  /// Number of absent sessions.
  final int absentSessions;

  const SubjectAttendanceEntity({
    required this.subjectName,
    required this.totalSessions,
    required this.attendedSessions,
    required this.lateSessions,
    required this.absentSessions,
  });

  /// Computed getter for attendance percentage (0.0 to 100.0).
  double get attendancePercentage {
    if (totalSessions <= 0) {
      return 0.0;
    }
    return (attendedSessions / totalSessions) * 100.0;
  }

  @override
  List<Object?> get props => <Object?>[
        subjectName,
        totalSessions,
        attendedSessions,
        lateSessions,
        absentSessions,
      ];
}
