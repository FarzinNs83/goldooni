import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/cats/data/datasources/cats_remote.dart';


import '../../domain/entities/cats_entity.dart';
import '../../domain/repositories/cats_repository.dart';

class CatsRepositoryImpl implements CatsRepository {
  final CatsDataRemote _catsRemote;

  CatsRepositoryImpl(this._catsRemote);
  @override

  Future<Either<Failure, List<CatsEntity>>> getCatData(int id, int page) {
    return _catsRemote.getCatsData(page, id).then((value) => Right(value));
  }
}
