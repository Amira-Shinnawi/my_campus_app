import 'package:equatable/equatable.dart';

import '../../domain/entities/notice_entity.dart';

/// Base state class for Notices Cubit state management.
abstract class NoticesState extends Equatable {
  const NoticesState();

  @override
  List<Object?> get props => <Object?>[];
}

/// Initial state when Cubit is created.
class NoticesInitial extends NoticesState {
  const NoticesInitial();
}

/// State emitted while loading notices.
class NoticesLoading extends NoticesState {
  const NoticesLoading();
}

/// State emitted when notices are loaded successfully.
class NoticesLoaded extends NoticesState {
  final List<NoticeEntity> notices;

  const NoticesLoaded(this.notices);

  @override
  List<Object?> get props => <Object?>[notices];
}

/// State emitted when fetching notices fails.
class NoticesError extends NoticesState {
  final String message;

  const NoticesError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
