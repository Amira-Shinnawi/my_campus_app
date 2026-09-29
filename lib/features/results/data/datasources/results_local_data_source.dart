import '../models/result_model.dart';

/// Abstract data source interface for local student results.
abstract class ResultsLocalDataSource {
  /// Fetches cached or mock academic results dataset.
  Future<List<ResultModel>> getResults();
}

/// Implementation of [ResultsLocalDataSource] returning mock academic results.
class ResultsLocalDataSourceImpl implements ResultsLocalDataSource {
  const ResultsLocalDataSourceImpl();

  static final List<Map<String, dynamic>> _mockResults =
      <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 'r1',
      'subject_name': 'Mobile Programming',
      'semester': 'Spring 2026',
      'grade': 'A+',
      'score': 96.5,
      'credit_hours': 3,
    },
    <String, dynamic>{
      'id': 'r2',
      'subject_name': 'Software Engineering',
      'semester': 'Spring 2026',
      'grade': 'A',
      'score': 91.0,
      'credit_hours': 3,
    },
    <String, dynamic>{
      'id': 'r3',
      'subject_name': 'Database Systems',
      'semester': 'Spring 2026',
      'grade': 'B+',
      'score': 86.0,
      'credit_hours': 4,
    },
    <String, dynamic>{
      'id': 'r4',
      'subject_name': 'Computer Networks',
      'semester': 'Spring 2026',
      'grade': 'A',
      'score': 93.0,
      'credit_hours': 3,
    },
    <String, dynamic>{
      'id': 'r5',
      'subject_name': 'Operating Systems',
      'semester': 'Fall 2025',
      'grade': 'B',
      'score': 81.5,
      'credit_hours': 3,
    },
    <String, dynamic>{
      'id': 'r6',
      'subject_name': 'Algorithms & Data Structures',
      'semester': 'Fall 2025',
      'grade': 'A',
      'score': 94.0,
      'credit_hours': 4,
    },
    <String, dynamic>{
      'id': 'r7',
      'subject_name': 'Discrete Mathematics',
      'semester': 'Fall 2025',
      'grade': 'B+',
      'score': 87.5,
      'credit_hours': 3,
    },
  ];

  @override
  Future<List<ResultModel>> getResults() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _mockResults
        .map((Map<String, dynamic> json) => ResultModel.fromJson(json))
        .toList();
  }
}
