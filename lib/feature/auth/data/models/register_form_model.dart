import '../../domain/entities/register_form_entity.dart';

class RegisterFormModel extends RegisterFormEntity {
  RegisterFormModel({
    required super.name,
    required super.address,
    required super.phoneNum,
    required super.codeMeli,
    required super.lat,
    required super.pw,
    required super.lon,
    required super.birthdate,
  });
  Map<String, dynamic> toJson() => {
    'birthday_date': birthdate,
    'full_name': name,
    'address': address,
    'phone_number': phoneNum,
    'national_code': codeMeli,
    'password': pw,
    'latitude': lat,
    'longitude': lon,
  };
  factory RegisterFormModel.fromJson(Map<String, dynamic> json) =>
      RegisterFormModel(
        name: json['full_name'] ?? '',
        pw: json['password'] ?? '',
        address: json['address']?? '',
        phoneNum: json['phone_number']?? '',
        codeMeli: json['national_code']?? '',
        lat: json['latitude']?? '',
        lon: json['longitude']?? '',
        birthdate: json['birthday_date']?? '',
      );
  factory RegisterFormModel.fromEntity(RegisterFormEntity entity) =>
      RegisterFormModel(
        name: entity.name,
        address: entity.address,
        phoneNum: entity.phoneNum,
        codeMeli: entity.codeMeli,
        lat: entity.lat,
        lon: entity.lon,
        birthdate: entity.birthdate, pw: entity.pw,
      );
}
