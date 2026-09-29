import 'package:equatable/equatable.dart';

/// Entity representing a campus event, workshop, or competition.
class EventEntity extends Equatable {
  /// Unique event identifier.
  final String id;

  /// Title or headline of event.
  final String title;

  /// Detailed description of event activities and agenda.
  final String description;

  /// Event date and time.
  final DateTime date;

  /// Event location venue (e.g. "Main Auditorium", "Hall C").
  final String location;

  /// Event category (e.g. "Workshop", "Seminar", "Social", "Sports").
  final String category;

  /// Optional image URL or asset illustration path.
  final String? imageUrl;

  const EventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.category,
    this.imageUrl,
  });

  /// Helper returning whether event is happening within the next 3 days.
  bool get isSoon {
    final DateTime now = DateTime.now();
    final Duration diff = date.difference(now);
    return !diff.isNegative && diff.inDays <= 3;
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        description,
        date,
        location,
        category,
        imageUrl,
      ];
}
