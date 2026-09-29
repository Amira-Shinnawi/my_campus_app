import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/assignment_entity.dart';
import '../repositories/assignments_repository.dart';

/// Use case for retrieving student assignments list.
class GetAssignments implements UseCase<List<AssignmentEntity>, NoParams> {
  final AssignmentsRepository repository;

  const GetAssignments(this.repository);

  @override
  Future<Either<Failure, List<AssignmentEntity>>> call(NoParams params) async {
    return repository.getAssignments();
  }
}
