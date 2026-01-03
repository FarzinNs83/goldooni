
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/cart/domain/repositories/cart_repository.dart';

import '../../domain/entities/cart_entity.dart';
part 'cart_state.dart';

class CartBloc extends Cubit<CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartInitial());
  final List<CartEntity> items = [];

Future<void> loadCart() async {
  emit(CartLoading());
  final result = await cartRepository.getCart();
  result.fold(
    (l) => emit(CartFailed(failure: Failure(l.toString()))),
    (r) {
      items.clear();
      items.addAll(r);
            if (items.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartSuccess());
      }
    },
  );
}

  Future<void> addItem(int productId, int quantity) async {
    await cartRepository.postProduct(productId, quantity);
    await loadCart();
  }

  Future<void> updateItem(int productId, int quantity) async {
    emit(CartLoading());
    await cartRepository.updateProduct(productId, quantity);
    await loadCart();
    emit(CartSuccess());
  }

  Future<void> deleteItem(int productId) async {
    emit(CartLoading());
    await cartRepository.deleteProduct(productId);
    await loadCart();
    emit(CartSuccess());
  }
}
