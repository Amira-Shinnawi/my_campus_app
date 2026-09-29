import 'package:equatable/equatable.dart';

import '../../domain/entities/student_profile_entity.dart';

/// Base state class for ProfileCubit.
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => <Object?>[];
}

/// Initial state before fetching student profile.
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Loading state while fetching profile.
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// Loaded state containing student profile entity.
class ProfileLoaded extends ProfileState {
  final StudentProfileEntity profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => <Object?>[profile];
}

/// Error state containing error message.
class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
