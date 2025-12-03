import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/profile/data/datasources/profile_remote.dart';

import 'package:goldooni/feature/profile/domain/entities/profile_entity.dart';

import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemote profileRemote;

  ProfileRepositoryImpl(this.profileRemote);
  @override
  Future<Either<Failure, List<ProfileEntity>>> getProfile() {
    return profileRemote.getProfile().then((value) => Right(value));
  }
}
