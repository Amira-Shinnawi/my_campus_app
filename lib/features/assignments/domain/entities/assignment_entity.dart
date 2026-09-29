import 'package:equatable/equatable.dart';

import 'assignment_status.dart';

/// Entity representing a student homework or project assignment.
class AssignmentEntity extends Equatable {
  /// Unique assignment identifier.
  final String id;

  /// Title or headline of assignment task.
  final String title;

  /// Name of associated subject.
  final String subjectName;

  /// Full description or instructions text.
  final String description;

  /// Due deadline date.
  final DateTime dueDate;

  /// Current completion status of assignment.
  final AssignmentStatus status;

  const AssignmentEntity({
    required this.id,
    required this.title,
    required this.subjectName,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  /// Creates a copy of [AssignmentEntity] with updated fields.
  AssignmentEntity copyWith({
    String? id,
    String? title,
    String? subjectName,
    String? description,
    DateTime? dueDate,
    AssignmentStatus? status,
  }) {
    return AssignmentEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subjectName: subjectName ?? this.subjectName,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        subjectName,
        description,
        dueDate,
        status,
      ];
}
