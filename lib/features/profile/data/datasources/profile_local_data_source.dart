import '../models/student_profile_model.dart';

/// Abstract data source interface for local student profile.
abstract class ProfileLocalDataSource {
  /// Fetches cached or mock single student profile.
  Future<StudentProfileModel> getProfile();
}

/// Implementation of [ProfileLocalDataSource] returning realistic student profile.
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  const ProfileLocalDataSourceImpl();

  static const Map<String, dynamic> _mockProfile = <String, dynamic>{
    'id': 'st_1001',
    'full_name': 'Amira Shinnawi',
    'student_id': 'CS-202301549',
    'faculty': 'Faculty of Computer Science',
    'department': 'Software Engineering',
    'level': 'Level 3 - Junior',
    'email': 'amira.shinnawi@campus.edu.eg',
    'profile_image_url': null,
  };

  @override
  Future<StudentProfileModel> getProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return StudentProfileModel.fromJson(_mockProfile);
  }
}
