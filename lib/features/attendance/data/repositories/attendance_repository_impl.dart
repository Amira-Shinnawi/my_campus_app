import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/attendance_record_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_local_data_source.dart';

/// Implementation of [AttendanceRepository] accessing local data source.
class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceLocalDataSource localDataSource;

  const AttendanceRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<AttendanceRecordEntity>>>
      getAttendanceRecords() async {
    try {
      final List<AttendanceRecordEntity> records =
          await localDataSource.getAttendanceRecords();
      return Right<Failure, List<AttendanceRecordEntity>>(records);
    } catch (e) {
      return Left<Failure, List<AttendanceRecordEntity>>(
        ServerFailure(e.toString()),
      );
    }
  }
}
