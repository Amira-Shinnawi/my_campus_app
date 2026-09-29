import '../models/class_model.dart';

/// Abstract data source interface for local class timetable storage.
abstract class ClassesLocalDataSource {
  /// Fetches mock or cached list of class schedule entries.
  Future<List<ClassModel>> getClasses();
}

/// Implementation of [ClassesLocalDataSource] returning mock dataset.
class ClassesLocalDataSourceImpl implements ClassesLocalDataSource {
  const ClassesLocalDataSourceImpl();

  static final List<Map<String, dynamic>> _mockClasses =
      <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 'c1',
      'subject_name': 'Mobile Programming',
      'instructor_name': 'Dr. Sarah Ahmed',
      'day': 'Saturday',
      'start_time': '09:00 AM',
      'end_time': '11:00 AM',
      'location': 'Lab 4 - CS Building',
      'type': 'Lab',
    },
    <String, dynamic>{
      'id': 'c2',
      'subject_name': 'Software Engineering',
      'instructor_name': 'Prof. Mohamed Hassan',
      'day': 'Saturday',
      'start_time': '11:30 AM',
      'end_time': '01:30 PM',
      'location': 'Hall A - Main Hall',
      'type': 'Lecture',
    },
    <String, dynamic>{
      'id': 'c3',
      'subject_name': 'Database Systems',
      'instructor_name': 'Dr. Eng. Omar Khaled',
      'day': 'Sunday',
      'start_time': '10:00 AM',
      'end_time': '12:00 PM',
      'location': 'Hall C - 2nd Floor',
      'type': 'Lecture',
    },
    <String, dynamic>{
      'id': 'c4',
      'subject_name': 'Database Systems Lab',
      'instructor_name': 'Eng. Nouran Ali',
      'day': 'Sunday',
      'start_time': '12:30 PM',
      'end_time': '02:30 PM',
      'location': 'Lab 2 - CS Building',
      'type': 'Lab',
    },
    <String, dynamic>{
      'id': 'c5',
      'subject_name': 'Computer Networks',
      'instructor_name': 'Dr. Tarek Mahmoud',
      'day': 'Monday',
      'start_time': '08:30 AM',
      'end_time': '10:30 AM',
      'location': 'Hall B - 1st Floor',
      'type': 'Lecture',
    },
    <String, dynamic>{
      'id': 'c6',
      'subject_name': 'Algorithm Analysis',
      'instructor_name': 'Dr. Hisham Mostafa',
      'day': 'Monday',
      'start_time': '11:00 AM',
      'end_time': '01:00 PM',
      'location': 'Hall A - Main Hall',
      'type': 'Lecture',
    },
    <String, dynamic>{
      'id': 'c7',
      'subject_name': 'Operating Systems',
      'instructor_name': 'Prof. Ayman Radwan',
      'day': 'Tuesday',
      'start_time': '09:30 AM',
      'end_time': '11:30 AM',
      'location': 'Hall D - 3rd Floor',
      'type': 'Lecture',
    },
    <String, dynamic>{
      'id': 'c8',
      'subject_name': 'OS Practical Section',
      'instructor_name': 'Eng. Mostafa Zaki',
      'day': 'Tuesday',
      'start_time': '12:00 PM',
      'end_time': '01:30 PM',
      'location': 'Section Room 12',
      'type': 'Section',
    },
    <String, dynamic>{
      'id': 'c9',
      'subject_name': 'Artificial Intelligence',
      'instructor_name': 'Dr. Mona Ibrahim',
      'day': 'Wednesday',
      'start_time': '10:00 AM',
      'end_time': '12:00 PM',
      'location': 'Hall B - 1st Floor',
      'type': 'Lecture',
    },
    <String, dynamic>{
      'id': 'c10',
      'subject_name': 'AI Workshop & Lab',
      'instructor_name': 'Eng. Kareem Nabil',
      'day': 'Wednesday',
      'start_time': '01:00 PM',
      'end_time': '03:00 PM',
      'location': 'AI Innovation Lab',
      'type': 'Lab',
    },
  ];

  @override
  Future<List<ClassModel>> getClasses() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _mockClasses
        .map((Map<String, dynamic> json) => ClassModel.fromJson(json))
        .toList();
  }
}
