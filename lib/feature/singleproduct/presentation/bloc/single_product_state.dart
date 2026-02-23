part of 'single_product_bloc.dart';

abstract class SingleProductState {
  final Set<int> favoriteIds;

  const SingleProductState({this.favoriteIds = const {}});
}

class SingleProductInitial extends SingleProductState {
  const SingleProductInitial({super.favoriteIds});
}

class SingleProductLoading extends SingleProductState {
  const SingleProductLoading({super.favoriteIds});
}

class SingleProductError extends SingleProductState {
  final Failure failure;

  const SingleProductError({required this.failure, super.favoriteIds});
}

class SingleProductLoaded extends SingleProductState {
  final SingleProductEntity product;

  const SingleProductLoaded({required this.product, super.favoriteIds});

  SingleProductLoaded copyWith({
    SingleProductEntity? product,
    Set<int>? favoriteIds,
  }) {
    return SingleProductLoaded(
      product: product ?? this.product,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}
