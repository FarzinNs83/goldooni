import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/home/domain/entities/amazing_products_entity.dart';
import 'package:goldooni/feature/home/domain/entities/cats_entity.dart';
import 'package:goldooni/feature/home/domain/entities/top_products_entity.dart';

import '../entities/new_products_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure,List<CatsEntity>>> getCats(int page);
  Future<Either<Failure,List<AmazingProductsEntity>>> getAmazingProducts(int page);
  Future<Either<Failure,List<NewProductsEntity>>> getNewProducts(int page);
  Future<Either<Failure,List<TopProductsEntity>>> getTopProducts(int page);
}
