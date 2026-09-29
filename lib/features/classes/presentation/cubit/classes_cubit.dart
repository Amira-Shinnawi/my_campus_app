import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/class_entity.dart';
import '../../domain/usecases/get_classes.dart';
import 'classes_state.dart';

/// Cubit managing state for student class timetable screen.
class ClassesCubit extends Cubit<ClassesState> {
  final GetClasses getClasses;

  /// Default list of days in week.
  static const List<String> availableDays = <String>[
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
  ];

  ClassesCubit({required this.getClasses}) : super(const ClassesInitial());

  /// Fetches classes from repository and sets initial selected day.
  Future<void> fetchClasses() async {
    emit(const ClassesLoading());

    final result = await getClasses(NoParams());

    result.fold(
      (failure) => emit(ClassesError(failure.message)),
      (List<ClassEntity> classes) {
        final String initialDay = _getInitialDay();
        emit(
          ClassesLoaded(
            allClasses: classes,
            selectedDay: initialDay,
          ),
        );
      },
    );
  }

  /// Updates selected day without re-fetching from repository.
  void selectDay(String day) {
    if (state is ClassesLoaded) {
      final ClassesLoaded currentState = state as ClassesLoaded;
      emit(currentState.copyWith(selectedDay: day));
    }
  }

  /// Helper to pick today's name if matching available days, otherwise 'Saturday'.
  String _getInitialDay() {
    final DateTime now = DateTime.now();
    final List<String> days = <String>[
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final String todayName = days[now.weekday - 1];
    if (availableDays.contains(todayName)) {
      return todayName;
    }
    return availableDays.first;
  }
}
