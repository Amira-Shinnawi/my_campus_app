import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/result_entity.dart';
import '../../domain/repositories/results_repository.dart';
import '../datasources/results_local_data_source.dart';

/// Implementation of [ResultsRepository] accessing local data source.
class ResultsRepositoryImpl implements ResultsRepository {
  final ResultsLocalDataSource localDataSource;

  const ResultsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ResultEntity>>> getResults() async {
    try {
      final List<ResultEntity> results = await localDataSource.getResults();
      return Right<Failure, List<ResultEntity>>(results);
    } catch (e) {
      return Left<Failure, List<ResultEntity>>(
        ServerFailure(e.toString()),
      );
    }
  }
}
