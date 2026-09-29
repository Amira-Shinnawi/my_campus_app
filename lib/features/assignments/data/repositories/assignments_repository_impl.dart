import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/assignment_entity.dart';
import '../../domain/entities/assignment_status.dart';
import '../../domain/repositories/assignments_repository.dart';
import '../datasources/assignments_local_data_source.dart';

/// Implementation of [AssignmentsRepository] accessing local data source.
class AssignmentsRepositoryImpl implements AssignmentsRepository {
  final AssignmentsLocalDataSource localDataSource;

  const AssignmentsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<AssignmentEntity>>> getAssignments() async {
    try {
      final List<AssignmentEntity> list =
          await localDataSource.getAssignments();
      return Right<Failure, List<AssignmentEntity>>(list);
    } catch (e) {
      return Left<Failure, List<AssignmentEntity>>(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateAssignmentStatus(
    String id,
    AssignmentStatus status,
  ) async {
    try {
      await localDataSource.updateAssignmentStatus(id, status);
      return const Right<Failure, void>(null);
    } catch (e) {
      return Left<Failure, void>(
        ServerFailure(e.toString()),
      );
    }
  }
}
