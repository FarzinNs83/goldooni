class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://goldonisite12.pythonanywhere.com/api';
  static const String sendSms = '$baseUrl/account/send-otp-code/';
  static const String verifyOtp = '$baseUrl/account/verify_otp_code/';
  static const String register = '$baseUrl/account/register/';
  static const String profile = '$baseUrl/account/profile/';
  static const String access = '$baseUrl/account/api/check/access_token/';
  static const String cats = '$baseUrl/products/categories/';
  static const String slider = '$baseUrl/products/slider/';
  static const String amazing = '$baseUrl/products/amazing/?page=';
  static const String newProduct = '$baseUrl/products/new/?page=';
  static const String top = '$baseUrl/products/top/?page=';
  static const String singleProduct = '$baseUrl/products/retrieve/';
  static const String addToCart = '$baseUrl/cart/add_item/';
  static const String getCart = '$baseUrl/cart/list_items/?page=1';
  static const String patchCart = '$baseUrl/cart/rud_item/';
  static const String deleteCart = '$baseUrl/cart/rud_item/';
  static const String searchByName = '$baseUrl/products/search/?q=';
  static const String searchByCategory = '$baseUrl/products/search_category/?q=';
  static const String blog = '$baseUrl/blog/list_article/?page=1';

}
