import '../models/notice_model.dart';

/// Contract for local notices data source operations.
abstract class NoticesLocalDataSource {
  /// Retrieves mock notices list.
  Future<List<NoticeModel>> getNotices();
}

/// Implementation of [NoticesLocalDataSource] returning realistic mock data.
class NoticesLocalDataSourceImpl implements NoticesLocalDataSource {
  const NoticesLocalDataSourceImpl();

  @override
  Future<List<NoticeModel>> getNotices() async {
    // Simulate loading latency
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return <NoticeModel>[
      NoticeModel(
        id: 'n1',
        title: 'Midterm Examination Schedule Released',
        description:
            'The midterm exam timetable for the Fall semester has been published. '
            'Please check your student portal for specific hall assignments, '
            'timings, and seat numbers. Make sure to carry your student ID card.',
        date: DateTime.now().subtract(const Duration(hours: 4)),
        category: 'Exam',
        isImportant: true,
      ),
      NoticeModel(
        id: 'n2',
        title: 'Annual Campus Hackathon Registration',
        description:
            'Registration is now open for the 2026 Campus Innovation Hackathon! '
            'Form teams of up to 4 members and solve real-world problems. '
            'Cash prizes and mentorship opportunities await winning teams.',
        date: DateTime.now().subtract(const Duration(days: 1)),
        category: 'Event',
        isImportant: true,
      ),
      NoticeModel(
        id: 'n3',
        title: 'Library Maintenance & Extended Hours',
        description:
            'Central Library quiet study area will undergo system maintenance '
            'this Saturday from 8:00 AM to 12:00 PM. Extended opening hours '
            'will apply during the upcoming examination weeks.',
        date: DateTime.now().subtract(const Duration(days: 2)),
        category: 'General',
        isImportant: false,
      ),
      NoticeModel(
        id: 'n4',
        title: 'Campus Wi-Fi Infrastructure Upgrade',
        description:
            'IT Department will perform router upgrades across main lecture halls '
            'on Friday evening. Intermittent wireless network downtime may occur '
            'between 10:00 PM and 2:00 AM.',
        date: DateTime.now().subtract(const Duration(days: 3)),
        category: 'General',
        isImportant: false,
      ),
      NoticeModel(
        id: 'n5',
        title: 'Guest Seminar on Artificial Intelligence in Healthcare',
        description:
            'Join us in Auditorium A for a keynote session by Dr. Sarah Ahmed '
            'exploring practical machine learning applications in modern medical diagnostics. '
            'All engineering and computer science students are welcome.',
        date: DateTime.now().subtract(const Duration(days: 4)),
        category: 'Event',
        isImportant: false,
      ),
    ];
  }
}
