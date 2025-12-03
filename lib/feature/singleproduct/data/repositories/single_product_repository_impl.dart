
import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/singleproduct/data/datasources/single_product_remote.dart';
import 'package:goldooni/feature/singleproduct/domain/entities/single_product_entity.dart';


import '../../domain/repositories/single_product_repository.dart';
class SingleproductRepositoryImpl implements SingleproductRepository {
  final SingleProductRemote singleProductRemote;
  SingleproductRepositoryImpl(this.singleProductRemote);
  @override
  Future<Either<Failure, List<SingleProductEntity>>> getSingleProduct(int id) {
    return singleProductRemote.getSingleProduct(id).then((value) => Right(value));
  }
}
