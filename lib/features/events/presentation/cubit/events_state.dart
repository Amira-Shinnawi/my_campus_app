import 'package:equatable/equatable.dart';

import '../../domain/entities/event_entity.dart';

/// Base state class for EventsCubit.
abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object?> get props => <Object?>[];
}

/// Initial state before fetching campus events.
class EventsInitial extends EventsState {
  const EventsInitial();
}

/// Loading state while fetching events.
class EventsLoading extends EventsState {
  const EventsLoading();
}

/// Loaded state containing campus events list.
class EventsLoaded extends EventsState {
  final List<EventEntity> allEvents;
  final String? categoryFilter;

  const EventsLoaded({
    required this.allEvents,
    this.categoryFilter,
  });

  /// Computed list of events sorted by date ascending.
  List<EventEntity> get sortedEvents {
    final List<EventEntity> list = List<EventEntity>.from(
      categoryFilter == null || categoryFilter!.toLowerCase() == 'all'
          ? allEvents
          : allEvents.where(
              (EventEntity e) =>
                  e.category.toLowerCase() == categoryFilter!.toLowerCase(),
            ),
    );

    list.sort((EventEntity a, EventEntity b) => a.date.compareTo(b.date));
    return list;
  }

  /// Available categories list for filter options.
  List<String> get availableCategories {
    final Set<String> set = <String>{'All'};
    for (final EventEntity e in allEvents) {
      set.add(e.category);
    }
    return set.toList();
  }

  /// Creates a copy of [EventsLoaded] with updated category filter.
  EventsLoaded copyWith({
    List<EventEntity>? allEvents,
    String? categoryFilter,
    bool clearCategory = false,
  }) {
    return EventsLoaded(
      allEvents: allEvents ?? this.allEvents,
      categoryFilter:
          clearCategory ? null : (categoryFilter ?? this.categoryFilter),
    );
  }

  @override
  List<Object?> get props => <Object?>[allEvents, categoryFilter];
}

/// Error state containing error message.
class EventsError extends EventsState {
  final String message;

  const EventsError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
