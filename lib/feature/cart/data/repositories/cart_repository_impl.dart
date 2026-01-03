import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/cart/data/datasources/cart_remote.dart';
import 'package:goldooni/feature/cart/domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemote cartRemote;

  CartRepositoryImpl(this.cartRemote);

  @override
  Future<void> postProduct(int productId, int quantity) {
    return cartRemote.postCart(productId, quantity);
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCart() {
    return cartRemote.getCart().then((value) => Right(value));
  }
  
  @override
  Future<void> deleteProduct(int productId) {
    return cartRemote.deleteCart(productId);
  }
  
  @override
  Future<void> updateProduct(int productId, int quantity) {
    return cartRemote.updateCart(productId, quantity);
  }
}
