import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/assignment_entity.dart';
import '../../domain/entities/assignment_status.dart';
import '../../domain/usecases/get_assignments.dart';
import '../../domain/usecases/update_assignment_status.dart';
import '../../domain/usecases/update_assignment_status_params.dart';
import 'assignments_state.dart';

/// Cubit managing state for student assignments task list.
class AssignmentsCubit extends Cubit<AssignmentsState> {
  final GetAssignments getAssignments;
  final UpdateAssignmentStatus updateAssignmentStatus;

  AssignmentsCubit({
    required this.getAssignments,
    required this.updateAssignmentStatus,
  }) : super(const AssignmentsInitial());

  /// Loads assignments list from repository.
  Future<void> loadAssignments() async {
    emit(const AssignmentsLoading());

    final result = await getAssignments(NoParams());

    result.fold(
      (failure) => emit(AssignmentsError(failure.message)),
      (List<AssignmentEntity> assignments) {
        emit(AssignmentsLoaded(allAssignments: assignments));
      },
    );
  }

  /// Updates current status filter (null = All).
  void changeFilter(AssignmentStatus? filter) {
    if (state is AssignmentsLoaded) {
      final AssignmentsLoaded currentState = state as AssignmentsLoaded;
      emit(
        currentState.copyWith(
          filter: filter,
          clearFilter: filter == null,
        ),
      );
    }
  }

  /// Marks assignment as submitted by [id] and reactively updates local state.
  Future<void> markAsSubmitted(String id) async {
    if (state is! AssignmentsLoaded) {
      return;
    }

    final AssignmentsLoaded currentState = state as AssignmentsLoaded;

    final result = await updateAssignmentStatus(
      UpdateAssignmentStatusParams(
        id: id,
        status: AssignmentStatus.submitted,
      ),
    );

    result.fold(
      (failure) => emit(AssignmentsError(failure.message)),
      (_) {
        // Optimistically update list state locally without full screen reload
        final List<AssignmentEntity> updatedList = currentState.allAssignments
            .map((AssignmentEntity item) {
          if (item.id == id) {
            return item.copyWith(status: AssignmentStatus.submitted);
          }
          return item;
        }).toList();

        emit(currentState.copyWith(allAssignments: updatedList));
      },
    );
  }
}
