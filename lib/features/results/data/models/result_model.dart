import '../../domain/entities/result_entity.dart';

/// Data Transfer Object (DTO) model for student academic result.
class ResultModel extends ResultEntity {
  const ResultModel({
    required super.id,
    required super.subjectName,
    required super.semester,
    required super.grade,
    required super.score,
    required super.creditHours,
  });

  /// Factory constructor to parse JSON map to [ResultModel].
  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['id'] as String,
      subjectName: json['subject_name'] as String,
      semester: json['semester'] as String,
      grade: json['grade'] as String,
      score: (json['score'] as num).toDouble(),
      creditHours: json['credit_hours'] as int,
    );
  }

  /// Converts [ResultModel] instance into JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'subject_name': subjectName,
      'semester': semester,
      'grade': grade,
      'score': score,
      'credit_hours': creditHours,
    };
  }
}
