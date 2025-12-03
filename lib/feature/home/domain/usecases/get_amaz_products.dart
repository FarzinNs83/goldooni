import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/home/domain/entities/amazing_products_entity.dart';
import 'package:goldooni/feature/home/domain/repositories/home_repository.dart';

import '../../../../core/usecase/usecase_glob.dart';

class GetAmazProducts implements UsecaseGlob<List<AmazingProductsEntity>, AmazProductsParams> {
  final HomeRepository homeRepository;
  GetAmazProducts(this.homeRepository);
  @override
  Future<Either<Failure, List<AmazingProductsEntity>>> call(AmazProductsParams params) async {
    return await homeRepository.getAmazingProducts(params.page);
  }
}

class AmazProductsParams {
  final int page;
  AmazProductsParams({ required this.page});
}
