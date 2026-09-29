import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/result_entity.dart';
import '../../domain/usecases/get_results.dart';
import 'results_state.dart';

/// Cubit managing state for student academic results and GPA screen.
class ResultsCubit extends Cubit<ResultsState> {
  final GetResults getResults;

  ResultsCubit({required this.getResults}) : super(const ResultsInitial());

  /// Fetches academic results from repository and sets initial filter.
  Future<void> fetchResults() async {
    emit(const ResultsLoading());

    final result = await getResults(NoParams());

    result.fold(
      (failure) => emit(ResultsError(failure.message)),
      (List<ResultEntity> results) {
        emit(
          ResultsLoaded(
            allResults: results,
            selectedSemester: 'All',
          ),
        );
      },
    );
  }

  /// Updates current semester filter.
  void selectSemester(String semester) {
    if (state is ResultsLoaded) {
      final ResultsLoaded currentState = state as ResultsLoaded;
      emit(currentState.copyWith(selectedSemester: semester));
    }
  }
}
