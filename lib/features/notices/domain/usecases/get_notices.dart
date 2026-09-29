import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/notice_entity.dart';
import '../repositories/notices_repository.dart';

/// Use case for retrieving campus notices.
class GetNotices implements UseCase<List<NoticeEntity>, NoParams> {
  final NoticesRepository repository;

  const GetNotices(this.repository);

  @override
  Future<Either<Failure, List<NoticeEntity>>> call(NoParams params) async {
    return repository.getNotices();
  }
}
