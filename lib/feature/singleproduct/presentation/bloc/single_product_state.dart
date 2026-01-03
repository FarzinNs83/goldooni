part of 'single_product_bloc.dart';

abstract class SingleProductState {}

class SingleProductInitial extends SingleProductState {}

class SingleProductLoading extends SingleProductState {}

class SingleProductError extends SingleProductState {
  final Failure failure;

  SingleProductError({required this.failure});
}

class SingleProductLoaded extends SingleProductState {
  final List<SingleProductEntity> favorites;
  SingleProductLoaded({this.favorites = const []});
}
