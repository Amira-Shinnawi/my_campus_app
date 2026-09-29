import '../../domain/entities/event_entity.dart';

/// Data Transfer Object (DTO) model for campus event.
class EventModel extends EventEntity {
  const EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.location,
    required super.category,
    super.imageUrl,
  });

  /// Factory constructor to parse JSON map to [EventModel].
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String,
      category: json['category'] as String,
      imageUrl: json['image_url'] as String?,
    );
  }

  /// Converts [EventModel] instance into JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'category': category,
      'image_url': imageUrl,
    };
  }
}
