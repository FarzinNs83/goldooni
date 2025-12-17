import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';

import '../entities/cats_entity.dart';


abstract class CatsRepository {
  Future<Either<Failure, List<CatsEntity>>> getCatData(int id, int page);
}
