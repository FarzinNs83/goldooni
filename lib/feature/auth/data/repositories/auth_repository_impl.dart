import 'package:fpdart/fpdart.dart';
import 'package:goldooni/core/errors/failure.dart';
import 'package:goldooni/core/errors/server_exc.dart';
import 'package:goldooni/feature/auth/data/datasources/auth_data_source.dart';
import 'package:goldooni/feature/auth/data/models/register_form_model.dart';
import 'package:goldooni/feature/auth/data/models/send_sms_model.dart';
import 'package:goldooni/feature/auth/data/models/verify_otp_model.dart';

import 'package:goldooni/feature/auth/domain/entities/register_form_entity.dart';

import 'package:goldooni/feature/auth/domain/entities/send_sms_entity.dart';

import 'package:goldooni/feature/auth/domain/entities/verify_otp_entity.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthDataSource dataSource;
  AuthRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, RegisterFormEntity>> registerForm(
    RegisterFormEntity registerForm,
  ) async {
    try {
      final res = await dataSource.registerForm(
        RegisterFormModel.fromEntity(registerForm),
      );
      return Right(res);
    } on ServerExc catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SendSmsEntity>> sendSmsOtp(
    SendSmsEntity sendSms,
  ) async {
    try {
      final res = await dataSource.sendSmsOtp(SendSmsModel.fromEntity(sendSms));
      return Right(res);
    } on ServerExc catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpEntity>> verifyOtp(
    VerifyOtpEntity verifyOtp,
  ) async {
    try {
      final res = await dataSource.verifyOtp(
        VerifyOtpModel.fromEntity(verifyOtp),
      );
      return Right(res);
    } on ServerExc catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
