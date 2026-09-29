import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/class_entity.dart';

/// Abstract repository contract for student class timetable operations.
abstract class ClassesRepository {
  /// Fetches list of all student classes. Returns [Failure] or [List<ClassEntity>].
  Future<Either<Failure, List<ClassEntity>>> getClasses();
}
