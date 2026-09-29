import 'package:equatable/equatable.dart';

/// Represents a class/lecture entity in the timetable.
class ClassEntity extends Equatable {
  /// Unique identifier of the class.
  final String id;

  /// Subject or course name.
  final String subjectName;

  /// Name of the instructor or professor.
  final String instructorName;

  /// Day of the week (e.g., Saturday, Sunday).
  final String day;

  /// Class start time string (e.g., "09:00 AM").
  final String startTime;

  /// Class end time string (e.g., "11:00 AM").
  final String endTime;

  /// Physical location or room (e.g., "Hall A - 3rd Floor").
  final String location;

  /// Type of class session (e.g., "Lecture", "Lab", "Section").
  final String type;

  const ClassEntity({
    required this.id,
    required this.subjectName,
    required this.instructorName,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.type,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        subjectName,
        instructorName,
        day,
        startTime,
        endTime,
        location,
        type,
      ];
}
