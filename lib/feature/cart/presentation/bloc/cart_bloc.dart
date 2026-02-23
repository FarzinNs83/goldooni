import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/cart/domain/repositories/cart_repository.dart';

import '../../domain/entities/cart_entity.dart';
part 'cart_state.dart';

class CartBloc extends Cubit<CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartState.initial());

  List<CartEntity> get items => state.carts;

  Future<void> loadCart({bool showLoading = true}) async {
    if (showLoading) {
      emit(
        state.copyWith(
          status: CartStatus.loading,
          clearActiveItemId: true,
          clearFeedback: true,
        ),
      );
    }
    final result = await cartRepository.getCart();
    result.fold(
      (l) => emit(
        state.copyWith(
          status: CartStatus.failure,
          failure: Failure(l.toString()),
          isMutating: false,
          clearActiveItemId: true,
          feedbackStatus: CartFeedbackStatus.error,
          feedbackMessage: 'Failed to refresh cart',
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: r.isEmpty ? CartStatus.empty : CartStatus.success,
          carts: r,
          isMutating: false,
          clearActiveItemId: true,
        ),
      ),
    );
  }

  Future<void> addItem(int productId, int quantity) async {
    emit(
      state.copyWith(
        isMutating: true,
        clearActiveItemId: true,
        clearFeedback: true,
      ),
    );
    try {
      await cartRepository.postProduct(productId, quantity);
      await loadCart(showLoading: false);
      emit(
        state.copyWith(
          feedbackStatus: CartFeedbackStatus.success,
          feedbackMessage: 'Item added to cart',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CartStatus.failure,
          failure: Failure(e.toString()),
          isMutating: false,
          clearActiveItemId: true,
          feedbackStatus: CartFeedbackStatus.error,
          feedbackMessage: 'Could not add item to cart',
        ),
      );
    }
  }

  Future<void> updateItem(int productId, int quantity) async {
    if (quantity <= 0) {
      await deleteItem(productId);
      return;
    }
    emit(
      state.copyWith(
        isMutating: true,
        activeItemId: productId,
        clearFeedback: true,
      ),
    );
    try {
      await cartRepository.updateProduct(productId, quantity);
      final updatedCart = _updateLocalItemQuantity(productId, quantity);
      emit(
        state.copyWith(
          status: updatedCart.items.isEmpty
              ? CartStatus.empty
              : CartStatus.success,
          carts: [updatedCart],
          isMutating: false,
          clearActiveItemId: true,
          feedbackStatus: CartFeedbackStatus.success,
          feedbackMessage: 'Cart updated',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CartStatus.failure,
          failure: Failure(e.toString()),
          isMutating: false,
          clearActiveItemId: true,
          feedbackStatus: CartFeedbackStatus.error,
          feedbackMessage: 'Could not update cart item',
        ),
      );
    }
  }

  Future<void> deleteItem(int productId) async {
    emit(
      state.copyWith(
        isMutating: true,
        activeItemId: productId,
        clearFeedback: true,
      ),
    );
    try {
      await cartRepository.deleteProduct(productId);
      final updatedCart = _deleteLocalItem(productId);
      emit(
        state.copyWith(
          status: updatedCart.items.isEmpty
              ? CartStatus.empty
              : CartStatus.success,
          carts: [updatedCart],
          isMutating: false,
          clearActiveItemId: true,
          feedbackStatus: CartFeedbackStatus.success,
          feedbackMessage: 'Item removed from cart',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CartStatus.failure,
          failure: Failure(e.toString()),
          isMutating: false,
          clearActiveItemId: true,
          feedbackStatus: CartFeedbackStatus.error,
          feedbackMessage: 'Could not remove item from cart',
        ),
      );
    }
  }

  void clearFeedback() {
    if (state.feedbackStatus == CartFeedbackStatus.none) return;
    emit(state.copyWith(clearFeedback: true));
  }

  CartEntity _updateLocalItemQuantity(int cartItemId, int quantity) {
    final cart = state.carts.first;
    final updatedItems = cart.items.map((item) {
      if (item.id != cartItemId) {
        return item;
      }
      return CartItemEntity(
        id: item.id,
        product: item.product,
        totalPrice: item.product.finalPrice * quantity,
        quantity: quantity,
      );
    }).toList();
    return _copyCartWithItems(cart, updatedItems);
  }

  CartEntity _deleteLocalItem(int cartItemId) {
    final cart = state.carts.first;
    final updatedItems = cart.items
        .where((item) => item.id != cartItemId)
        .toList();
    return _copyCartWithItems(cart, updatedItems);
  }

  CartEntity _copyCartWithItems(CartEntity cart, List<CartItemEntity> items) {
    final totalPrice = items.fold<int>(0, (sum, item) => sum + item.totalPrice);
    return CartEntity(
      id: cart.id,
      totalPrice: totalPrice,
      items: items,
      createdAt: cart.createdAt,
      user: cart.user,
    );
  }
}
