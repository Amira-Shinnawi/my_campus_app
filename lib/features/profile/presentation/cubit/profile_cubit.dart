import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/student_profile_entity.dart';
import '../../domain/usecases/get_profile.dart';
import 'profile_state.dart';

/// Cubit managing state for student profile screen.
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfile getProfile;

  ProfileCubit({required this.getProfile}) : super(const ProfileInitial());

  /// Fetches student profile details from repository.
  Future<void> fetchProfile() async {
    emit(const ProfileLoading());

    final result = await getProfile(NoParams());

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (StudentProfileEntity profile) {
        emit(ProfileLoaded(profile));
      },
    );
  }
}
