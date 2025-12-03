import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/home/domain/repositories/home_repository.dart';

import '../../../../core/usecase/usecase_glob.dart';
import '../entities/cats_entity.dart';

class GetCatsUseCase implements UsecaseGlob<List<CatsEntity>, CatsParams> {
  final HomeRepository homeRepository;
  GetCatsUseCase(this.homeRepository);
  @override
  Future<Either<Failure, List<CatsEntity>>> call(CatsParams params) async {
    return await homeRepository.getCats(params.page);
  }
}

class CatsParams {
  final int page;
  CatsParams({ required this.page});
}
