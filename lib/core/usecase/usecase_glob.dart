import 'package:fpdart/fpdart.dart';

import '../errors/failure.dart';

abstract interface class UsecaseGlob<ResType, Params> {
  Future<Either<Failure, ResType>> call(Params params);
}

class NoParams {}
