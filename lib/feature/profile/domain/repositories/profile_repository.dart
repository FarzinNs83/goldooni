import 'package:fpdart/fpdart.dart';
import 'package:goldooni/feature/profile/domain/entities/profile_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class ProfileRepository {
 Future<Either<Failure,List<ProfileEntity>>> getProfile();
}
