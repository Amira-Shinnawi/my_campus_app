import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/events_repository.dart';
import '../datasources/events_local_data_source.dart';

/// Implementation of [EventsRepository] accessing local data source.
class EventsRepositoryImpl implements EventsRepository {
  final EventsLocalDataSource localDataSource;

  const EventsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents() async {
    try {
      final List<EventEntity> events = await localDataSource.getEvents();
      return Right<Failure, List<EventEntity>>(events);
    } catch (e) {
      return Left<Failure, List<EventEntity>>(
        ServerFailure(e.toString()),
      );
    }
  }
}
