import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/class_entity.dart';
import '../repositories/classes_repository.dart';

/// Use case for retrieving student class timetable.
class GetClasses implements UseCase<List<ClassEntity>, NoParams> {
  final ClassesRepository repository;

  const GetClasses(this.repository);

  @override
  Future<Either<Failure, List<ClassEntity>>> call(NoParams params) async {
    return repository.getClasses();
  }
}
