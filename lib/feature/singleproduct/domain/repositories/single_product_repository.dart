import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../entities/single_product_entity.dart';

abstract class SingleproductRepository {
  Future<Either<Failure, List<SingleProductEntity>>> getSingleProduct(int id);
}
