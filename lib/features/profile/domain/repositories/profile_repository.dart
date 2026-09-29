import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/student_profile_entity.dart';

/// Abstract repository contract for student profile operations.
abstract class ProfileRepository {
  /// Fetches single student profile object. Returns [Failure] or [StudentProfileEntity].
  Future<Either<Failure, StudentProfileEntity>> getProfile();
}
