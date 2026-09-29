import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/notice_entity.dart';
import '../../domain/repositories/notices_repository.dart';
import '../datasources/notices_local_data_source.dart';

/// Implementation of [NoticesRepository] delegating to [NoticesLocalDataSource].
class NoticesRepositoryImpl implements NoticesRepository {
  final NoticesLocalDataSource localDataSource;

  const NoticesRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<NoticeEntity>>> getNotices() async {
    try {
      final List<NoticeEntity> notices = await localDataSource.getNotices();
      return Right(notices);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to load notices: ${e.toString()}'));
    }
  }
}
