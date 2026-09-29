import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/event_entity.dart';

/// Abstract repository contract for campus events operations.
abstract class EventsRepository {
  /// Fetches list of campus events. Returns [Failure] or [List<EventEntity>].
  Future<Either<Failure, List<EventEntity>>> getEvents();
}
