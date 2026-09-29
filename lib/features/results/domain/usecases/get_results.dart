import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/result_entity.dart';
import '../repositories/results_repository.dart';

/// Use case for retrieving student academic results.
class GetResults implements UseCase<List<ResultEntity>, NoParams> {
  final ResultsRepository repository;

  const GetResults(this.repository);

  @override
  Future<Either<Failure, List<ResultEntity>>> call(NoParams params) async {
    return repository.getResults();
  }
}
