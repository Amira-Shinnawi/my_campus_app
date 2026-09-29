import 'package:equatable/equatable.dart';

import '../../domain/entities/attendance_record_entity.dart';
import '../../domain/entities/attendance_status.dart';
import '../../domain/entities/subject_attendance_entity.dart';

/// Base state class for AttendanceCubit.
abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => <Object?>[];
}

/// Initial state before fetching records.
class AttendanceInitial extends AttendanceState {
  const AttendanceInitial();
}

/// Loading state while fetching records.
class AttendanceLoading extends AttendanceState {
  const AttendanceLoading();
}

/// Loaded state containing raw attendance records and computed metrics.
class AttendanceLoaded extends AttendanceState {
  final List<AttendanceRecordEntity> records;

  const AttendanceLoaded({required this.records});

  /// Total session records count.
  int get totalSessions => records.length;

  /// Count of present sessions.
  int get presentCount => records
      .where(
        (AttendanceRecordEntity r) => r.status == AttendanceStatus.present,
      )
      .length;

  /// Count of late sessions.
  int get lateCount => records
      .where(
        (AttendanceRecordEntity r) => r.status == AttendanceStatus.late,
      )
      .length;

  /// Count of absent sessions.
  int get absentCount => records
      .where(
        (AttendanceRecordEntity r) => r.status == AttendanceStatus.absent,
      )
      .length;

  /// Overall attendance percentage across all sessions (attending = present or late).
  double get overallPercentage {
    if (totalSessions <= 0) {
      return 0.0;
    }
    final int attended = presentCount + lateCount;
    return (attended / totalSessions) * 100.0;
  }

  /// Dynamically computes per-subject attendance summaries on the fly.
  List<SubjectAttendanceEntity> get subjectSummaries {
    final Map<String, List<AttendanceRecordEntity>> grouped =
        <String, List<AttendanceRecordEntity>>{};

    for (final AttendanceRecordEntity record in records) {
      grouped.putIfAbsent(record.subjectName, () => <AttendanceRecordEntity>[]).add(record);
    }

    final List<SubjectAttendanceEntity> summaries = <SubjectAttendanceEntity>[];

    grouped.forEach((String subject, List<AttendanceRecordEntity> items) {
      final int total = items.length;
      final int present = items.where((r) => r.status == AttendanceStatus.present).length;
      final int late = items.where((r) => r.status == AttendanceStatus.late).length;
      final int absent = items.where((r) => r.status == AttendanceStatus.absent).length;
      final int attended = present + late;

      summaries.add(
        SubjectAttendanceEntity(
          subjectName: subject,
          totalSessions: total,
          attendedSessions: attended,
          lateSessions: late,
          absentSessions: absent,
        ),
      );
    });

    // Sort by attendance percentage descending
    summaries.sort((a, b) => b.attendancePercentage.compareTo(a.attendancePercentage));

    return summaries;
  }

  @override
  List<Object?> get props => <Object?>[records];
}

/// Error state containing error message.
class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
