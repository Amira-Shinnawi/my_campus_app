import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/event_entity.dart';
import '../repositories/events_repository.dart';

/// Use case for retrieving campus events list.
class GetEvents implements UseCase<List<EventEntity>, NoParams> {
  final EventsRepository repository;

  const GetEvents(this.repository);

  @override
  Future<Either<Failure, List<EventEntity>>> call(NoParams params) async {
    return repository.getEvents();
  }
}
