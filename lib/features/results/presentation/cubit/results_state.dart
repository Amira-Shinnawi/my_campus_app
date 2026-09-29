import 'package:equatable/equatable.dart';

import '../../domain/entities/result_entity.dart';

/// Base state class for ResultsCubit.
abstract class ResultsState extends Equatable {
  const ResultsState();

  @override
  List<Object?> get props => <Object?>[];
}

/// Initial state before fetching academic results.
class ResultsInitial extends ResultsState {
  const ResultsInitial();
}

/// Loading state while fetching results.
class ResultsLoading extends ResultsState {
  const ResultsLoading();
}

/// Loaded state containing all academic results and selected semester filter.
class ResultsLoaded extends ResultsState {
  final List<ResultEntity> allResults;
  final String selectedSemester;

  const ResultsLoaded({
    required this.allResults,
    required this.selectedSemester,
  });

  /// Filtered results matching [selectedSemester] (or all if 'All').
  List<ResultEntity> get filteredResults {
    if (selectedSemester.toLowerCase() == 'all') {
      return allResults;
    }
    return allResults
        .where(
          (ResultEntity r) =>
              r.semester.toLowerCase() == selectedSemester.toLowerCase(),
        )
        .toList();
  }

  /// Calculates cumulative GPA weighted by credit hours.
  double get gpa {
    final List<ResultEntity> list = filteredResults;
    if (list.isEmpty) {
      return 0.0;
    }
    double totalPoints = 0.0;
    int totalCredits = 0;

    for (final ResultEntity item in list) {
      totalPoints += item.gradePoints * item.creditHours;
      totalCredits += item.creditHours;
    }

    if (totalCredits <= 0) {
      return 0.0;
    }
    return totalPoints / totalCredits;
  }

  /// Calculates total completed credit hours for filtered view.
  int get totalCreditHours {
    return filteredResults.fold(
      0,
      (int sum, ResultEntity item) => sum + item.creditHours,
    );
  }

  /// Extract list of available unique semesters.
  List<String> get availableSemesters {
    final Set<String> set = <String>{'All'};
    for (final ResultEntity r in allResults) {
      set.add(r.semester);
    }
    return set.toList();
  }

  /// Creates a copy of [ResultsLoaded] with an updated [selectedSemester].
  ResultsLoaded copyWith({
    List<ResultEntity>? allResults,
    String? selectedSemester,
  }) {
    return ResultsLoaded(
      allResults: allResults ?? this.allResults,
      selectedSemester: selectedSemester ?? this.selectedSemester,
    );
  }

  @override
  List<Object?> get props => <Object?>[allResults, selectedSemester];
}

/// Error state containing error message.
class ResultsError extends ResultsState {
  final String message;

  const ResultsError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
