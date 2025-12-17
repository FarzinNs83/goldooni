import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/cart_entity.dart';

abstract class CartRepository {
  Future<void> postProduct(int productId, int quantity);
  Future<Either<Failure,List<CartEntity>>> getCart();
}
