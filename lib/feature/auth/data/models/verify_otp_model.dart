import 'package:goldooni/feature/auth/domain/entities/verify_otp_entity.dart';

class VerifyOtpModel extends VerifyOtpEntity {
  VerifyOtpModel({required super.phoneNumber, required super.otp});
  Map<String, dynamic> toJson() => {'phone_number': phoneNumber, 'code': otp};
  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
    phoneNumber: json['phone_number'] ?? '',
    otp: json['code'] ?? '',
  );
  factory VerifyOtpModel.fromEntity(VerifyOtpEntity entity) =>
      VerifyOtpModel(phoneNumber: entity.phoneNumber, otp: entity.otp);
}
