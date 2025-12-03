class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://goldonisite12.pythonanywhere.com/api';
  static const String sendSms = '$baseUrl/account/send-otp-code/';
  static const String verifyOtp = '$baseUrl/account/verify_otp_code/';
  static const String register = '$baseUrl/account/register/';
  static const String profile = '$baseUrl/account/profile/';
  static const String access = '$baseUrl/account/api/check/access_token/';
  static const String cats = '$baseUrl/products/categories/?page=';
  static const String amazing = '$baseUrl/products/amazing/?page=';
  static const String newProduct = '$baseUrl/products/new/?page=';
  static const String top = '$baseUrl/products/top/?page=';
  static const String singleProduct = '$baseUrl/products/retrieve/';

}
