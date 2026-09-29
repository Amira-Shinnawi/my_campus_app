import '../models/event_model.dart';

/// Abstract data source interface for local campus events.
abstract class EventsLocalDataSource {
  /// Fetches cached or mock events dataset.
  Future<List<EventModel>> getEvents();
}

/// Implementation of [EventsLocalDataSource] returning mock dataset.
class EventsLocalDataSourceImpl implements EventsLocalDataSource {
  const EventsLocalDataSourceImpl();

  static final List<Map<String, dynamic>> _mockEvents =
      <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 'e1',
      'title': 'AI & Machine Learning Hackathon 2026',
      'description':
          'Join the 48-hour annual AI hackathon! Form teams, build innovative machine learning solutions, and win exciting prizes from industry sponsors.',
      'date': DateTime.now().add(const Duration(days: 2)).toIso8601String(),
      'location': 'CS Innovation Lab & Main Auditorium',
      'category': 'Competition',
      'image_url': null,
    },
    <String, dynamic>{
      'id': 'e2',
      'title': 'Flutter & Cross-Platform Dev Workshop',
      'description':
          'Interactive hands-on session introducing modern Flutter UI design, Clean Architecture, and state management using Bloc & Provider.',
      'date': DateTime.now().add(const Duration(days: 5)).toIso8601String(),
      'location': 'Hall B - Computer Science Building',
      'category': 'Workshop',
      'image_url': null,
    },
    <String, dynamic>{
      'id': 'e3',
      'title': 'Annual Campus Tech Career Fair',
      'description':
          'Meet top software engineering tech companies, submit resumes, and interview on-site for summer internships and full-time software engineering roles.',
      'date': DateTime.now().add(const Duration(days: 10)).toIso8601String(),
      'location': 'University Central Exhibition Hall',
      'category': 'Seminar',
      'image_url': null,
    },
    <String, dynamic>{
      'id': 'e4',
      'title': 'Inter-College Football Tournament Finals',
      'description':
          'Cheer for your department in the thrilling final football match! Refreshments and trophy ceremony right after the game.',
      'date': DateTime.now().add(const Duration(days: 14)).toIso8601String(),
      'location': 'Main Campus Sports Stadium',
      'category': 'Sports',
      'image_url': null,
    },
    <String, dynamic>{
      'id': 'e5',
      'title': 'Campus Welcome & Cultural Night',
      'description':
          'An evening of live music, student talent performances, food stalls, and networking with fellow campus clubs and societies.',
      'date': DateTime.now().add(const Duration(days: 20)).toIso8601String(),
      'location': 'Student Union Outdoor Garden',
      'category': 'Social',
      'image_url': null,
    },
    <String, dynamic>{
      'id': 'e6',
      'title': 'Cybersecurity & Ethical Hacking Seminar',
      'description':
          'Learn about penetration testing, network security fundamentals, and defensive engineering from certified ethical security experts.',
      'date': DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
      'location': 'Hall A - Main Hall',
      'category': 'Seminar',
      'image_url': null,
    },
  ];

  @override
  Future<List<EventModel>> getEvents() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _mockEvents
        .map((Map<String, dynamic> json) => EventModel.fromJson(json))
        .toList();
  }
}
