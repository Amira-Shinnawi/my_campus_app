import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/attendance_record_entity.dart';
import '../repositories/attendance_repository.dart';

/// Use case for retrieving raw student attendance records.
class GetAttendanceRecords
    implements UseCase<List<AttendanceRecordEntity>, NoParams> {
  final AttendanceRepository repository;

  const GetAttendanceRecords(this.repository);

  @override
  Future<Either<Failure, List<AttendanceRecordEntity>>> call(
      NoParams params) async {
    return repository.getAttendanceRecords();
  }
}
