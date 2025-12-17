part of 'cats_bloc.dart';

abstract class CatsState {}

class CatsInitial extends CatsState {}

class CatsLoading extends CatsState {}

class CatsSuccess extends CatsState {}

class CatsFailed extends CatsState {
  final Failure failure;

  CatsFailed({required this.failure});
}
