part of 'cart_bloc.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {}
class CartEmpty extends CartState {}
class CartFailed extends CartState {
  final Failure failure;
  CartFailed({required this.failure});
}