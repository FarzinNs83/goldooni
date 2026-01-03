part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeAmazLoading extends HomeState {}

class HomeCatsLoading extends HomeState {}

class HomeNewLoading extends HomeState {}

class HomeTopLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeMoreAmazingSuccess extends HomeState {}

class HomeMoreAmazingLoading extends HomeState {}
class HomeSearchLoading extends HomeState {}

class HomeSearchSuccess extends HomeState {
  final List<SearchEntity> search;

  HomeSearchSuccess({required this.search});

}

class HomeSearchFailed extends HomeState {
  final Failure failure;

  HomeSearchFailed({required this.failure});
}

class HomeStartTimer extends HomeState {
  final String hours;
  final String minutes;
  final String seconds;

  HomeStartTimer({
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
}

class HomeMoreAmazingFailed extends HomeState {
  final Failure failure;
  HomeMoreAmazingFailed({required this.failure});
}

class HomeFailed extends HomeState {
  final Failure failure;
  HomeFailed({required this.failure});
}
