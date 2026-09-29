import '../../domain/entities/student_profile_entity.dart';

/// Data Transfer Object (DTO) model for student profile.
class StudentProfileModel extends StudentProfileEntity {
  const StudentProfileModel({
    required super.id,
    required super.fullName,
    required super.studentId,
    required super.faculty,
    required super.department,
    required super.level,
    required super.email,
    super.profileImageUrl,
  });

  /// Factory constructor to parse JSON map to [StudentProfileModel].
  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    return StudentProfileModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      studentId: json['student_id'] as String,
      faculty: json['faculty'] as String,
      department: json['department'] as String,
      level: json['level'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profile_image_url'] as String?,
    );
  }

  /// Converts [StudentProfileModel] instance into JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'full_name': fullName,
      'student_id': studentId,
      'faculty': faculty,
      'department': department,
      'level': level,
      'email': email,
      'profile_image_url': profileImageUrl,
    };
  }
}
