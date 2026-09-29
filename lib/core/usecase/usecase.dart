import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../errors/failures.dart';

/// Abstract contract for clean architecture domain use cases.
abstract class UseCase<T, Params> {
  /// Executes the use case with the given [params].
  Future<Either<Failure, T>> call(Params params);
}

/// Represents parameterless use case calls.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
