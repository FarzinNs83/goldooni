class ProfileEntity {
  final int? id;
  final String address;
  final String birthdayDate;
  final String latitude;
  final String longitude;
  final String password;
  final String fullName;
  final String phoneNumber;
  final String nationalCode;
  final String lastLogin;

  ProfileEntity({
   required this.id,
   required this.address,
   required this.birthdayDate,
   required this.latitude,
   required this.longitude,
   required this.password,
   required this.fullName,
   required this.phoneNumber,
   required this.nationalCode,
   required this.lastLogin,
  });
}
