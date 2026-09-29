import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/attendance_record_entity.dart';

/// Abstract repository contract for student attendance operations.
abstract class AttendanceRepository {
  /// Fetches raw attendance log records. Returns [Failure] or [List<AttendanceRecordEntity>].
  Future<Either<Failure, List<AttendanceRecordEntity>>> getAttendanceRecords();
}
