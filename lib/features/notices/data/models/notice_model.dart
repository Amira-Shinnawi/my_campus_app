import '../../domain/entities/notice_entity.dart';

/// Data Transfer Object (DTO) model for campus notices.
class NoticeModel extends NoticeEntity {
  const NoticeModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.category,
    super.isImportant,
  });

  /// Factory constructor to parse JSON map to [NoticeModel].
  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      category: json['category'] as String,
      isImportant: (json['is_important'] as bool?) ?? false,
    );
  }

  /// Converts [NoticeModel] instance into JSON map representation.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'category': category,
      'is_important': isImportant,
    };
  }
}
