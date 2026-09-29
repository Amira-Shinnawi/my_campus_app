import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/result_entity.dart';

/// Abstract repository contract for student academic results operations.
abstract class ResultsRepository {
  /// Fetches list of all academic subject results. Returns [Failure] or [List<ResultEntity>].
  Future<Either<Failure, List<ResultEntity>>> getResults();
}
