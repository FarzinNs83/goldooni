import 'package:fpdart/fpdart.dart';
import 'package:goldooni/feature/auth/domain/entities/register_form_entity.dart';
import 'package:goldooni/feature/auth/domain/entities/send_sms_entity.dart';
import 'package:goldooni/feature/auth/domain/entities/verify_otp_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure,SendSmsEntity>> sendSmsOtp(SendSmsEntity sendSms);
  Future<Either<Failure,VerifyOtpEntity>> verifyOtp(VerifyOtpEntity verifyOtp);
  Future<Either<Failure,RegisterFormEntity>> registerForm(RegisterFormEntity registerForm);
}
