import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/assignment_entity.dart';
import '../entities/assignment_status.dart';

/// Abstract repository contract for student assignment operations.
abstract class AssignmentsRepository {
  /// Fetches list of all assignments.
  Future<Either<Failure, List<AssignmentEntity>>> getAssignments();

  /// Updates status of a target assignment by [id].
  Future<Either<Failure, void>> updateAssignmentStatus(
    String id,
    AssignmentStatus status,
  );
}
