import 'package:equatable/equatable.dart';

import '../../domain/entities/assignment_entity.dart';
import '../../domain/entities/assignment_status.dart';

/// Base state class for AssignmentsCubit.
abstract class AssignmentsState extends Equatable {
  const AssignmentsState();

  @override
  List<Object?> get props => <Object?>[];
}

/// Initial state before fetching assignments.
class AssignmentsInitial extends AssignmentsState {
  const AssignmentsInitial();
}

/// Loading state while fetching assignments or updating status.
class AssignmentsLoading extends AssignmentsState {
  const AssignmentsLoading();
}

/// Loaded state containing assignments list and optional filter.
class AssignmentsLoaded extends AssignmentsState {
  final List<AssignmentEntity> allAssignments;
  final AssignmentStatus? filter;

  const AssignmentsLoaded({
    required this.allAssignments,
    this.filter,
  });

  /// Computed list of assignments filtered by [filter] (or all if null).
  List<AssignmentEntity> get filteredAssignments {
    if (filter == null) {
      return allAssignments;
    }
    return allAssignments
        .where((AssignmentEntity a) => a.status == filter)
        .toList();
  }

  /// Creates a copy of [AssignmentsLoaded] with updated fields.
  AssignmentsLoaded copyWith({
    List<AssignmentEntity>? allAssignments,
    AssignmentStatus? filter,
    bool clearFilter = false,
  }) {
    return AssignmentsLoaded(
      allAssignments: allAssignments ?? this.allAssignments,
      filter: clearFilter ? null : (filter ?? this.filter),
    );
  }

  @override
  List<Object?> get props => <Object?>[allAssignments, filter];
}

/// Error state containing error message.
class AssignmentsError extends AssignmentsState {
  final String message;

  const AssignmentsError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
