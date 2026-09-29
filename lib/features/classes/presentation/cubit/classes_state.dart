import 'package:equatable/equatable.dart';

import '../../domain/entities/class_entity.dart';

/// Base state class for ClassesCubit.
abstract class ClassesState extends Equatable {
  const ClassesState();

  @override
  List<Object?> get props => <Object?>[];
}

/// Initial state before fetching classes.
class ClassesInitial extends ClassesState {
  const ClassesInitial();
}

/// Loading state while fetching classes.
class ClassesLoading extends ClassesState {
  const ClassesLoading();
}

/// Loaded state containing all fetched classes and currently selected day.
class ClassesLoaded extends ClassesState {
  final List<ClassEntity> allClasses;
  final String selectedDay;

  const ClassesLoaded({
    required this.allClasses,
    required this.selectedDay,
  });

  /// Helper getter returning classes filtered for [selectedDay].
  List<ClassEntity> get filteredClasses {
    final List<ClassEntity> filtered = allClasses
        .where(
          (ClassEntity c) =>
              c.day.toLowerCase() == selectedDay.toLowerCase(),
        )
        .toList();

    filtered.sort((ClassEntity a, ClassEntity b) {
      return a.startTime.compareTo(b.startTime);
    });

    return filtered;
  }

  /// Creates a copy of [ClassesLoaded] with an updated [selectedDay].
  ClassesLoaded copyWith({
    List<ClassEntity>? allClasses,
    String? selectedDay,
  }) {
    return ClassesLoaded(
      allClasses: allClasses ?? this.allClasses,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  @override
  List<Object?> get props => <Object?>[allClasses, selectedDay];
}

/// Error state containing error message.
class ClassesError extends ClassesState {
  final String message;

  const ClassesError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
