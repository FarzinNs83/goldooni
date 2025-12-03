part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeAmazLoading extends HomeState {}
class HomeCatsLoading extends HomeState {}
class HomeNewLoading extends HomeState {}
class HomeTopLoading extends HomeState {}


class HomeSuccess extends HomeState {}

class HomeFailed extends HomeState {
  final Failure failure;
  HomeFailed({required this.failure});
}
