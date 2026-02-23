import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/auth/domain/entities/verify_otp_entity.dart';
import 'package:goldooni/feature/auth/domain/repositories/auth_repository.dart';

import '../../../../core/usecase/usecase_glob.dart';

class VerifyOtpUseCase implements UsecaseGlob<VerifyOtpEntity, VerifyOtpParams> {
  final AuthRepository authRepository;
  VerifyOtpUseCase(this.authRepository);
  @override
  Future<Either<Failure, VerifyOtpEntity>> call(VerifyOtpParams params) async {
    return authRepository.verifyOtp(
      VerifyOtpEntity(phoneNumber: params.phoneNum, otp: params.otp),
    );
  }
}

class VerifyOtpParams {
  final String phoneNum;
  final String otp;
  VerifyOtpParams({required this.phoneNum, required this.otp});
}
