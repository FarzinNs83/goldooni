part of 'profile_bloc.dart';

class ProfileState {
  final bool isDark;

  ProfileState({this.isDark = false});

  ProfileState copyWith({bool? isDark}) {
    return ProfileState(isDark: isDark ?? this.isDark);
  }
}

class ProfileInitial extends ProfileState {
  ProfileInitial() : super(isDark: false);
}

class ProfileSuccess extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileFailed extends ProfileState {
  final Failure failure;
  ProfileFailed({required this.failure});
}
