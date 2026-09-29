import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/assignments_repository.dart';
import 'update_assignment_status_params.dart';

/// Use case for updating state of an assignment task.
class UpdateAssignmentStatus
    implements UseCase<void, UpdateAssignmentStatusParams> {
  final AssignmentsRepository repository;

  const UpdateAssignmentStatus(this.repository);

  @override
  Future<Either<Failure, void>> call(
    UpdateAssignmentStatusParams params,
  ) async {
    return repository.updateAssignmentStatus(params.id, params.status);
  }
}
