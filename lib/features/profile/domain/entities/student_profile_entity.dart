import 'package:equatable/equatable.dart';

/// Entity representing a student's personal and academic profile details.
class StudentProfileEntity extends Equatable {
  /// Unique profile identifier.
  final String id;

  /// Full student name.
  final String fullName;

  /// Official university student ID number.
  final String studentId;

  /// Faculty or college name.
  final String faculty;

  /// Academic department or specialization.
  final String department;

  /// Academic level or year.
  final String level;

  /// University email address.
  final String email;

  /// Optional profile picture image URL.
  final String? profileImageUrl;

  const StudentProfileEntity({
    required this.id,
    required this.fullName,
    required this.studentId,
    required this.faculty,
    required this.department,
    required this.level,
    required this.email,
    this.profileImageUrl,
  });

  /// Returns 2-letter uppercase initials for profile avatar fallback.
  String get initials {
    final List<String> parts = fullName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return 'ST';
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        fullName,
        studentId,
        faculty,
        department,
        level,
        email,
        profileImageUrl,
      ];
}
