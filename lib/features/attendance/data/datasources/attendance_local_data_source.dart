import '../models/attendance_record_model.dart';

/// Abstract data source interface for local attendance records storage.
abstract class AttendanceLocalDataSource {
  /// Fetches cached or mock list of attendance records.
  Future<List<AttendanceRecordModel>> getAttendanceRecords();
}

/// Implementation of [AttendanceLocalDataSource] returning mock attendance data.
class AttendanceLocalDataSourceImpl implements AttendanceLocalDataSource {
  const AttendanceLocalDataSourceImpl();

  static final List<Map<String, dynamic>> _mockRecords =
      <Map<String, dynamic>>[
    // Mobile Programming (9 present, 1 late out of 10 -> 90% attendance)
    <String, dynamic>{'id': 'a1', 'subject_name': 'Mobile Programming', 'date': '2026-09-27T09:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a2', 'subject_name': 'Mobile Programming', 'date': '2026-09-20T09:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a3', 'subject_name': 'Mobile Programming', 'date': '2026-09-13T09:00:00Z', 'status': 'late'},
    <String, dynamic>{'id': 'a4', 'subject_name': 'Mobile Programming', 'date': '2026-09-06T09:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a5', 'subject_name': 'Mobile Programming', 'date': '2026-08-30T09:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a6', 'subject_name': 'Mobile Programming', 'date': '2026-08-23T09:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a7', 'subject_name': 'Mobile Programming', 'date': '2026-08-16T09:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a8', 'subject_name': 'Mobile Programming', 'date': '2026-08-09T09:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a9', 'subject_name': 'Mobile Programming', 'date': '2026-08-02T09:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a10', 'subject_name': 'Mobile Programming', 'date': '2026-07-26T09:00:00Z', 'status': 'present'},

    // Database Systems (6 present, 1 late, 1 absent out of 8 -> 75% attendance)
    <String, dynamic>{'id': 'a11', 'subject_name': 'Database Systems', 'date': '2026-09-28T10:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a12', 'subject_name': 'Database Systems', 'date': '2026-09-21T10:00:00Z', 'status': 'absent'},
    <String, dynamic>{'id': 'a13', 'subject_name': 'Database Systems', 'date': '2026-09-14T10:00:00Z', 'status': 'late'},
    <String, dynamic>{'id': 'a14', 'subject_name': 'Database Systems', 'date': '2026-09-07T10:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a15', 'subject_name': 'Database Systems', 'date': '2026-08-31T10:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a16', 'subject_name': 'Database Systems', 'date': '2026-08-24T10:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a17', 'subject_name': 'Database Systems', 'date': '2026-08-17T10:00:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a18', 'subject_name': 'Database Systems', 'date': '2026-08-10T10:00:00Z', 'status': 'present'},

    // Operating Systems (5 present, 0 late, 3 absent out of 8 -> 62.5% attendance - AT RISK!)
    <String, dynamic>{'id': 'a19', 'subject_name': 'Operating Systems', 'date': '2026-09-26T11:30:00Z', 'status': 'absent'},
    <String, dynamic>{'id': 'a20', 'subject_name': 'Operating Systems', 'date': '2026-09-19T11:30:00Z', 'status': 'absent'},
    <String, dynamic>{'id': 'a21', 'subject_name': 'Operating Systems', 'date': '2026-09-12T11:30:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a22', 'subject_name': 'Operating Systems', 'date': '2026-09-05T11:30:00Z', 'status': 'absent'},
    <String, dynamic>{'id': 'a23', 'subject_name': 'Operating Systems', 'date': '2026-08-29T11:30:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a24', 'subject_name': 'Operating Systems', 'date': '2026-08-22T11:30:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a25', 'subject_name': 'Operating Systems', 'date': '2026-08-15T11:30:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a26', 'subject_name': 'Operating Systems', 'date': '2026-08-08T11:30:00Z', 'status': 'present'},

    // Software Engineering (6 present out of 6 -> 100% attendance)
    <String, dynamic>{'id': 'a27', 'subject_name': 'Software Engineering', 'date': '2026-09-25T08:30:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a28', 'subject_name': 'Software Engineering', 'date': '2026-09-18T08:30:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a29', 'subject_name': 'Software Engineering', 'date': '2026-09-11T08:30:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a30', 'subject_name': 'Software Engineering', 'date': '2026-09-04T08:30:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a31', 'subject_name': 'Software Engineering', 'date': '2026-08-28T08:30:00Z', 'status': 'present'},
    <String, dynamic>{'id': 'a32', 'subject_name': 'Software Engineering', 'date': '2026-08-21T08:30:00Z', 'status': 'present'},
  ];

  @override
  Future<List<AttendanceRecordModel>> getAttendanceRecords() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _mockRecords
        .map((Map<String, dynamic> json) =>
            AttendanceRecordModel.fromJson(json))
        .toList();
  }
}
