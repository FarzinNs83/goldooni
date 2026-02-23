part of 'cart_bloc.dart';

enum CartStatus { initial, loading, success, empty, failure }

class CartState {
  final CartStatus status;
  final List<CartEntity> carts;
  final Failure failure;
  final bool isMutating;
  final int? activeItemId;

  const CartState({
    required this.status,
    required this.carts,
    required this.failure,
    required this.isMutating,
    required this.activeItemId,
  });

  factory CartState.initial() {
    return CartState(
      status: CartStatus.initial,
      carts: const [],
      failure: Failure(""),
      isMutating: false,
      activeItemId: null,
    );
  }

  CartState copyWith({
    CartStatus? status,
    List<CartEntity>? carts,
    Failure? failure,
    bool? isMutating,
    int? activeItemId,
    bool clearActiveItemId = false,
  }) {
    return CartState(
      status: status ?? this.status,
      carts: carts ?? this.carts,
      failure: failure ?? this.failure,
      isMutating: isMutating ?? this.isMutating,
      activeItemId: clearActiveItemId
          ? null
          : (activeItemId ?? this.activeItemId),
    );
  }
}
