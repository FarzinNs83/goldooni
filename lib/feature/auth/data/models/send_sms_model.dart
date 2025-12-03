import '../../domain/entities/send_sms_entity.dart';

class SendSmsModel extends SendSmsEntity {
  SendSmsModel({required super.phoneNumber});

  Map<String, dynamic> toJson() => {'phone_number': phoneNumber};
  factory SendSmsModel.fromJson(Map<String, dynamic> json) =>
      SendSmsModel(phoneNumber: json['phone_number'] ?? '');
  factory SendSmsModel.fromEntity(SendSmsEntity sendSms) =>
      SendSmsModel(phoneNumber: sendSms.phoneNumber);
}
