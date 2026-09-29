import 'package:equatable/equatable.dart';

/// Base class representing domain-level failures across the application.
abstract class Failure extends Equatable {
  /// User-friendly error message.
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Represents failure during local cache / storage operations.
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Represents failure during remote server / API operations.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
