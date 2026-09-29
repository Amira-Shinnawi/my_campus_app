import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/notice_entity.dart';

/// Abstract repository contract for campus notice operations.
abstract class NoticesRepository {
  /// Fetches list of notices. Returns [Failure] on error or [List<NoticeEntity>].
  Future<Either<Failure, List<NoticeEntity>>> getNotices();
}
