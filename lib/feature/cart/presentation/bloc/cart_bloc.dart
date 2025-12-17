import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/cart/domain/repositories/cart_repository.dart';

import '../../domain/entities/cart_entity.dart';
part 'cart_state.dart';

class CartBloc extends Cubit<CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartState.initial());
  final List<CartEntity> items = [];

  Future<void> loadCart() async {
    final result = await cartRepository.getCart();
    result.fold((l) => Failure(l.toString()), (r) => items.addAll(r));
  }

  Future<void> addItem(int productId, int quantity) async {
    await cartRepository.postProduct(productId, quantity);
    // await loadCart();
  }

  // Future<void> removeItem(int id) async {
  //   await removeFromCartUseCase(id);
  //   await loadCart();
  // }

  // Future<void> clear() async {
  //   await clearCartUseCase();
  //   emit(state.copyWith(items: []));
  // }
}
