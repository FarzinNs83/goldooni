import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.address,
    required super.birthdayDate,
    required super.latitude,
    required super.longitude,
    required super.password,
    required super.fullName,
    required super.phoneNumber,
    required super.nationalCode,
    required super.lastLogin,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      address: json['address'],
      birthdayDate: json['birthday_date'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      password: json['password'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      nationalCode: json['national_code'],
      lastLogin: json['last_login'],
    );
  }
   factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      address: entity.address,
      birthdayDate: entity.birthdayDate,
      latitude: entity.latitude,
      longitude: entity.longitude,
      password: entity.password,
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
      nationalCode: entity.nationalCode,
      lastLogin: entity.lastLogin,
    );
  }
}
