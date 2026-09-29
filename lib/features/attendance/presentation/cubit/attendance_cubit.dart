import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/attendance_record_entity.dart';
import '../../domain/usecases/get_attendance_records.dart';
import 'attendance_state.dart';

/// Cubit managing state for student attendance screen.
class AttendanceCubit extends Cubit<AttendanceState> {
  final GetAttendanceRecords getAttendanceRecords;

  AttendanceCubit({required this.getAttendanceRecords})
      : super(const AttendanceInitial());

  /// Fetches raw attendance records from repository.
  Future<void> fetchAttendance() async {
    emit(const AttendanceLoading());

    final result = await getAttendanceRecords(NoParams());

    result.fold(
      (failure) => emit(AttendanceError(failure.message)),
      (List<AttendanceRecordEntity> records) {
        emit(AttendanceLoaded(records: records));
      },
    );
  }
}
