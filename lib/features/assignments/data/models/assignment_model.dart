import '../../domain/entities/assignment_entity.dart';
import '../../domain/entities/assignment_status.dart';

/// Data Transfer Object (DTO) model for student assignment.
class AssignmentModel extends AssignmentEntity {
  const AssignmentModel({
    required super.id,
    required super.title,
    required super.subjectName,
    required super.description,
    required super.dueDate,
    required super.status,
  });

  /// Factory constructor to parse JSON map to [AssignmentModel].
  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subjectName: json['subject_name'] as String,
      description: json['description'] as String,
      dueDate: DateTime.parse(json['due_date'] as String),
      status: _parseStatus(json['status'] as String),
    );
  }

  /// Converts [AssignmentModel] instance into JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subject_name': subjectName,
      'description': description,
      'due_date': dueDate.toIso8601String(),
      'status': status.name,
    };
  }

  @override
  AssignmentModel copyWith({
    String? id,
    String? title,
    String? subjectName,
    String? description,
    DateTime? dueDate,
    AssignmentStatus? status,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subjectName: subjectName ?? this.subjectName,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }

  static AssignmentStatus _parseStatus(String statusStr) {
    switch (statusStr.toLowerCase()) {
      case 'submitted':
        return AssignmentStatus.submitted;
      case 'overdue':
        return AssignmentStatus.overdue;
      case 'pending':
      default:
        return AssignmentStatus.pending;
    }
  }
}
