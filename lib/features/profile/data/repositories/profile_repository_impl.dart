import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/student_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';

/// Implementation of [ProfileRepository] accessing local data source.
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  const ProfileRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, StudentProfileEntity>> getProfile() async {
    try {
      final StudentProfileEntity profile = await localDataSource.getProfile();
      return Right<Failure, StudentProfileEntity>(profile);
    } catch (e) {
      return Left<Failure, StudentProfileEntity>(
        ServerFailure(e.toString()),
      );
    }
  }
}
