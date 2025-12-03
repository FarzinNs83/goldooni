import 'dart:developer';

import 'package:goldooni/core/errors/server_exc.dart';
import 'package:goldooni/core/resources/api_constants.dart';
import 'package:goldooni/core/resources/global_vars.dart';

import '../../../../core/utils/shared_pref_manager.dart';
import '../models/register_form_model.dart';
import '../models/send_sms_model.dart';
import '../models/verify_otp_model.dart';
import 'package:dio/dio.dart';

abstract interface class AuthDataSource {
  Future<SendSmsModel> sendSmsOtp(SendSmsModel sendSms);
  Future<VerifyOtpModel> verifyOtp(VerifyOtpModel verifyOtp);
  Future<RegisterFormModel> registerForm(RegisterFormModel registerForm);
}

class AuthDataSourceImpl extends AuthDataSource {
  Dio dio;
  AuthDataSourceImpl(this.dio);
  @override
  Future<RegisterFormModel> registerForm(RegisterFormModel registerForm) async {
    try {
      final res = await dio.post(
        ApiConstants.register,
        data: registerForm.toJson(),
      );
      if (res.statusCode == 201) {
        SharedPref.instance.setString('token', res.data['token']["access"]);
        SharedPref.instance.setString('refresh', res.data['token']["refresh"]);
        return RegisterFormModel.fromJson(res.data);
      } else {
        throw ServerExc(message: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      throw ServerExc(
        message:
            "Error ${e.response?.statusCode}: ${e.response?.data} \n ${e.toString()}",
      );
    }
  }

  @override
  Future<SendSmsModel> sendSmsOtp(SendSmsModel sendSms) async {
    try {
      final res = await dio.post(ApiConstants.sendSms, data: sendSms.toJson());
      if (res.statusCode == 201) {
        otp = res.data["code"];
        return SendSmsModel.fromJson(res.data);
      } else {
        throw ServerExc(message: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      throw ServerExc(message: e.toString());
    }
  }

  @override
  Future<VerifyOtpModel> verifyOtp(VerifyOtpModel verifyOtp) async {
    try {
      final res = await dio.post(
        ApiConstants.verifyOtp,
        data: verifyOtp.toJson(),
      );
      if (res.statusCode == 200) {
        isReg = res.data['is_registered'];
        log("user state is : ${isReg.toString()}");
        if (isReg) {
          SharedPref.instance.setString('token', res.data["access"]);
          SharedPref.instance.setString('refresh', res.data["refresh"]);
        }
        return VerifyOtpModel.fromJson(res.data);
      } else {
        throw ServerExc(message: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      throw ServerExc(message: e.toString());
    }
  }
}
