import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/class_entity.dart';
import '../../domain/repositories/classes_repository.dart';
import '../datasources/classes_local_data_source.dart';

/// Implementation of [ClassesRepository] accessing local data source.
class ClassesRepositoryImpl implements ClassesRepository {
  final ClassesLocalDataSource localDataSource;

  const ClassesRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ClassEntity>>> getClasses() async {
    try {
      final List<ClassEntity> classes = await localDataSource.getClasses();
      return Right<Failure, List<ClassEntity>>(classes);
    } catch (e) {
      return Left<Failure, List<ClassEntity>>(
        ServerFailure(e.toString()),
      );
    }
  }
}
