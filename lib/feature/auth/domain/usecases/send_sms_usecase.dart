import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/feature/auth/domain/entities/send_sms_entity.dart';
import 'package:goldooni/feature/auth/domain/repositories/auth_repository.dart';

import '../../../../core/usecase/usecase_glob.dart';

class SendSmsUseCase implements UsecaseGlob<SendSmsEntity, SendSmsParams> {
  final AuthRepository authRepository;
  SendSmsUseCase(this.authRepository);
  @override
  Future<Either<Failure, SendSmsEntity>> call(SendSmsParams params) async {
    return await authRepository.sendSmsOtp(
      SendSmsEntity(phoneNumber: params.phoneNum),
    );
  }
}

class SendSmsParams {
  final String phoneNum;
  SendSmsParams({required this.phoneNum});
}
