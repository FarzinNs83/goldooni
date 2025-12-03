import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/auth/domain/entities/register_form_entity.dart';
import 'package:goldooni/feature/auth/domain/repositories/auth_repository.dart';

import '../../../../core/usecase/usecase_glob.dart';

class RegisterFormUseCase implements UsecaseGlob<RegisterFormEntity, RegisterParams> {
  final AuthRepository authRepository;
  RegisterFormUseCase(this.authRepository);
  @override
  Future<Either<Failure, RegisterFormEntity>> call(RegisterParams params) async {
    return await authRepository.registerForm(
      RegisterFormEntity(
        name: params.name,
        address: params.address,
        birthdate: params.birthdate,
        phoneNum: params.phoneNum,
        codeMeli: params.codeMeli,
        lat: params.lat,
        lon: params.lon, pw: params.pw,
      ),
    );
  }
}

class RegisterParams {
  final String name;
  final String address;
  final String birthdate;
  final String phoneNum;
  final String codeMeli;
  final String pw;
  final String lat;
  final String lon;

  RegisterParams({
    required this.name,
    required this.pw,
    required this.address,
    required this.birthdate,
    required this.phoneNum,
    required this.codeMeli,
    required this.lat,
    required this.lon,
  });
}
