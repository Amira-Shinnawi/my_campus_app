import 'package:equatable/equatable.dart';

/// Entity representing an academic subject result entry.
class ResultEntity extends Equatable {
  /// Unique result identifier.
  final String id;

  /// Subject name.
  final String subjectName;

  /// Academic semester (e.g., "Fall 2025", "Spring 2026").
  final String semester;

  /// Letter grade earned (e.g., "A", "B+").
  final String grade;

  /// Numerical score percentage (e.g., 92.5).
  final double score;

  /// Credit hours assigned to subject.
  final int creditHours;

  const ResultEntity({
    required this.id,
    required this.subjectName,
    required this.semester,
    required this.grade,
    required this.score,
    required this.creditHours,
  });

  /// Converts letter grade to grade point scale (4.0 max).
  double get gradePoints {
    switch (grade.toUpperCase()) {
      case 'A+':
      case 'A':
        return 4.0;
      case 'B+':
        return 3.5;
      case 'B':
        return 3.0;
      case 'C+':
        return 2.5;
      case 'C':
        return 2.0;
      case 'D+':
        return 1.5;
      case 'D':
        return 1.0;
      case 'F':
      default:
        return 0.0;
    }
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        subjectName,
        semester,
        grade,
        score,
        creditHours,
      ];
}
