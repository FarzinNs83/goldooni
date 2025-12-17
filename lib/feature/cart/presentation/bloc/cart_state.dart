part of 'cart_bloc.dart';


class CartState {
  final List<CartItemEntity> items;

  CartState({required this.items});

  factory CartState.initial() => CartState(items: []);

  CartState copyWith({List<CartItemEntity>? items}) {
    return CartState(
      items: items ?? this.items,
    );
  }
}

