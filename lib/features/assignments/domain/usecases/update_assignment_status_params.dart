import 'package:equatable/equatable.dart';

import '../entities/assignment_status.dart';

/// Value parameters for updating assignment status.
class UpdateAssignmentStatusParams extends Equatable {
  /// Target assignment identifier.
  final String id;

  /// New status to assign.
  final AssignmentStatus status;

  const UpdateAssignmentStatusParams({
    required this.id,
    required this.status,
  });

  @override
  List<Object?> get props => <Object?>[id, status];
}
