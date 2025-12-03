import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/core/utils/shared_pref_manager.dart';
import 'package:goldooni/feature/profile/domain/entities/profile_entity.dart';
import 'package:goldooni/feature/profile/domain/repositories/profile_repository.dart';

import '../../../../core/errors/failure.dart';

part 'profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    loadTheme();
  }
  final List<ProfileEntity> profile = [];
  Future<void> loadTheme() async {
    final isDark = SharedPref.instance.getBool("isDarkTheme") ?? false;

    emit(state.copyWith(isDark: isDark));
  }

  Future<void> toggleTheme() async {
    final newValue = !state.isDark;
    await SharedPref.instance.setBool("isDarkTheme", newValue);

    emit(state.copyWith(isDark: newValue));
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final res = await profileRepository.getProfile();
    res.fold((l) => emit(ProfileFailed(failure: l)), (r) {
      profile.addAll(r);
      emit(ProfileSuccess());
    });
  }
}
