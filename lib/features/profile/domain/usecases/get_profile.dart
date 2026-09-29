import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/student_profile_entity.dart';
import '../repositories/profile_repository.dart';

/// Use case for retrieving student profile information.
class GetProfile implements UseCase<StudentProfileEntity, NoParams> {
  final ProfileRepository repository;

  const GetProfile(this.repository);

  @override
  Future<Either<Failure, StudentProfileEntity>> call(NoParams params) async {
    return repository.getProfile();
  }
}
