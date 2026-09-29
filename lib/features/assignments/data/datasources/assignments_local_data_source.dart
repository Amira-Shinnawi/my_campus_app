import '../../domain/entities/assignment_status.dart';
import '../models/assignment_model.dart';

/// Abstract data source interface for local assignments storage.
abstract class AssignmentsLocalDataSource {
  /// Fetches cached or mock list of assignments.
  Future<List<AssignmentModel>> getAssignments();

  /// Updates status of target assignment in local storage.
  Future<void> updateAssignmentStatus(String id, AssignmentStatus status);
}

/// In-memory mutable implementation of [AssignmentsLocalDataSource].
class AssignmentsLocalDataSourceImpl implements AssignmentsLocalDataSource {
  AssignmentsLocalDataSourceImpl();

  final List<AssignmentModel> _assignments = <AssignmentModel>[
    AssignmentModel(
      id: 'as1',
      title: 'Build Flutter Clean Architecture Feature',
      subjectName: 'Mobile Programming',
      description:
          'Implement Domain, Data, and Presentation layers using Bloc/Cubit pattern.',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      status: AssignmentStatus.pending,
    ),
    AssignmentModel(
      id: 'as2',
      title: 'Database Schema Design & ERD',
      subjectName: 'Database Systems',
      description:
          'Design 3NF normalized database schema and draw ER diagram for university system.',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      status: AssignmentStatus.pending,
    ),
    AssignmentModel(
      id: 'as3',
      title: 'Software Requirements Specification Document',
      subjectName: 'Software Engineering',
      description:
          'Write comprehensive SRS document specifying functional and non-functional requirements.',
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      status: AssignmentStatus.overdue,
    ),
    AssignmentModel(
      id: 'as4',
      title: 'Socket Programming in C/Python',
      subjectName: 'Computer Networks',
      description:
          'Build TCP client-server chat application supporting multiple threads.',
      dueDate: DateTime.now().subtract(const Duration(days: 4)),
      status: AssignmentStatus.submitted,
    ),
    AssignmentModel(
      id: 'as5',
      title: 'Operating Systems Process Scheduler Simulation',
      subjectName: 'Operating Systems',
      description:
          'Simulate Round Robin and Priority Scheduling algorithms in C++.',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      status: AssignmentStatus.pending,
    ),
    AssignmentModel(
      id: 'as6',
      title: 'AI Search Algorithms Implementation',
      subjectName: 'Artificial Intelligence',
      description:
          'Implement A* and BFS search algorithms for maze solving problem.',
      dueDate: DateTime.now().subtract(const Duration(days: 6)),
      status: AssignmentStatus.submitted,
    ),
    AssignmentModel(
      id: 'as7',
      title: 'UI Design Mockups in Figma',
      subjectName: 'Mobile Programming',
      description:
          'Create high-fidelity wireframes and interactive prototypes for Campus app.',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      status: AssignmentStatus.pending,
    ),
    AssignmentModel(
      id: 'as8',
      title: 'SQL Complex Queries & Triggers',
      subjectName: 'Database Systems',
      description:
          'Write stored procedures and audit log triggers for transaction processing.',
      dueDate: DateTime.now().subtract(const Duration(days: 3)),
      status: AssignmentStatus.overdue,
    ),
  ];

  @override
  Future<List<AssignmentModel>> getAssignments() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return List<AssignmentModel>.from(_assignments);
  }

  @override
  Future<void> updateAssignmentStatus(
    String id,
    AssignmentStatus status,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final int index = _assignments.indexWhere((AssignmentModel a) => a.id == id);
    if (index != -1) {
      _assignments[index] = _assignments[index].copyWith(status: status);
    }
  }
}
