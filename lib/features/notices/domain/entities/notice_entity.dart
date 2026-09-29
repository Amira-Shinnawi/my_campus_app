import 'package:equatable/equatable.dart';

/// Represents a campus notice or announcement entity.
class NoticeEntity extends Equatable {
  /// Unique identifier of the notice.
  final String id;

  /// Title of the notice.
  final String title;

  /// Full description text of the notice.
  final String description;

  /// Date when notice was issued.
  final DateTime date;

  /// Category tag (e.g., Exam, Event, General).
  final String category;

  /// Whether the notice is marked high priority/important.
  final bool isImportant;

  const NoticeEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    this.isImportant = false,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        description,
        date,
        category,
        isImportant,
      ];
}
