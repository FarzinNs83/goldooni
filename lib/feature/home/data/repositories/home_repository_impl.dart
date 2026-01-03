import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/home/data/datasources/amazing_products_remote.dart';
import 'package:goldooni/feature/home/data/datasources/cats_remote.dart';
import 'package:goldooni/feature/home/data/datasources/new_products_remote.dart';
import 'package:goldooni/feature/home/data/datasources/search_remote.dart';
import 'package:goldooni/feature/home/data/datasources/top_products_remote.dart';
import 'package:goldooni/feature/home/domain/entities/amazing_products_entity.dart';

import 'package:goldooni/feature/home/domain/entities/cats_entity.dart';
import 'package:goldooni/feature/home/domain/entities/new_products_entity.dart';
import 'package:goldooni/feature/home/domain/entities/search_entity.dart';
import 'package:goldooni/feature/home/domain/entities/slider_entity.dart';
import 'package:goldooni/feature/home/domain/entities/top_products_entity.dart';

import '../../domain/repositories/home_repository.dart';
import '../datasources/slider_remote.dart';

class HomeRepositoryImpl implements HomeRepository {
  final CatsRemote catsRemote;
  final AmazingProductsRemote amazingProductsRemote;
  final NewProductsRemote newProductsRemote;
  final TopProductsRemote topProductsRemote;
  final SliderRemote sliderRemote;
  final SearchRemote searchRemote;
  HomeRepositoryImpl(this.catsRemote, this.amazingProductsRemote, this.newProductsRemote, this.topProductsRemote, this.sliderRemote, this.searchRemote);
  @override
  Future<Either<Failure, List<CatsEntity>>> getCats() {
    return catsRemote.getHomeData().then((value) => Right(value));
  }

  @override
  Future<Either<Failure, List<AmazingProductsEntity>>> getAmazingProducts(
    int page,
  ) {
    return amazingProductsRemote.getAmazingData(page).then((value) => Right(value));
  }

  @override
  Future<Either<Failure, List<NewProductsEntity>>> getNewProducts(int page) {
    return newProductsRemote.getNewData(page).then((value) => Right(value));
  }

  @override
  Future<Either<Failure, List<TopProductsEntity>>> getTopProducts(int page) {
     return topProductsRemote.getTopData(page).then((value) => Right(value));
  }

  @override
  Future<Either<Failure, List<SliderEntity>>> getSlider() {
    return sliderRemote.getSlider().then((value) => Right(value));
  }

  @override
  Future<Either<Failure, List<SearchEntity>>> searchByName(String name) {
    return searchRemote.searchByName(name).then((value) => Right(value));
  }
  
  @override
  Future<Either<Failure, List<SearchEntity>>> searchByCategory(String category) {
    // TODO: implement searchByCategory
    throw UnimplementedError();
  }
}
