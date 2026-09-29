import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/usecases/get_events.dart';
import 'events_state.dart';

/// Cubit managing state for campus events feature.
class EventsCubit extends Cubit<EventsState> {
  final GetEvents getEvents;

  EventsCubit({required this.getEvents}) : super(const EventsInitial());

  /// Fetches campus events list from repository.
  Future<void> fetchEvents() async {
    emit(const EventsLoading());

    final result = await getEvents(NoParams());

    result.fold(
      (failure) => emit(EventsError(failure.message)),
      (List<EventEntity> events) {
        emit(EventsLoaded(allEvents: events));
      },
    );
  }

  /// Updates current category filter option.
  void selectCategory(String? category) {
    if (state is EventsLoaded) {
      final EventsLoaded currentState = state as EventsLoaded;
      emit(
        currentState.copyWith(
          categoryFilter: category,
          clearCategory: category == null || category.toLowerCase() == 'all',
        ),
      );
    }
  }
}
