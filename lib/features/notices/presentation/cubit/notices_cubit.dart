import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/notice_entity.dart';
import '../../domain/usecases/get_notices.dart';
import 'notices_state.dart';

/// Cubit managing state for campus notices feature.
class NoticesCubit extends Cubit<NoticesState> {
  final GetNotices getNotices;

  NoticesCubit({
    required this.getNotices,
  }) : super(const NoticesInitial());

  /// Loads notices list and emits appropriate state.
  Future<void> fetchNotices() async {
    emit(const NoticesLoading());

    final Either<Failure, List<NoticeEntity>> result =
        await getNotices(NoParams());

    result.fold(
      (Failure failure) => emit(NoticesError(failure.message)),
      (List<NoticeEntity> notices) => emit(NoticesLoaded(notices)),
    );
  }
}
