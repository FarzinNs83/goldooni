import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:goldooni/core/resources/api_constants.dart';
import 'package:goldooni/feature/cart/data/models/cart_model.dart';

import '../../../../core/errors/server_exc.dart';
import '../../../../core/utils/shared_pref_manager.dart';

abstract class CartRemote {
  Future<void> postCart(int productId, int quantity);
  Future<List<CartModel>> getCart();
}

class CartRemoteImpl implements CartRemote {
  final Dio _dio;

  CartRemoteImpl(this._dio);
  @override
  Future<void> postCart(int productId, int quantity) async {
    try {
      final res = await _dio.post(
        ApiConstants.addToCart,
        data: {"product": productId, "quantity": quantity},
        options: Options(
          headers: {
            "Authorization": "Bearer ${SharedPref.instance.getString('token')}",
          },
        ),
      );

      if (res.statusCode == 200) {
        log(res.data['message']);
        return res.data;
      }
      throw ServerExc(message: res.statusMessage.toString());
    } on DioException catch (e) {
      log(
        'DioException with Response: ${e.response?.statusCode} - ${e.response?.data}',
      );
      throw ServerExc(message: e.message.toString());
    }
  }

  @override
  Future<List<CartModel>> getCart() async {
    try {
      final res = await _dio.get(
        ApiConstants.getCart,
        options: Options(
          headers: {
            "Authorization": "Bearer ${SharedPref.instance.getString('token')}",
          },
        ),
      );
      if (res.statusCode == 200) {
        log(res.data.toString());
        return (res.data['results'] as List)
            .map((e) => CartModel.fromJson(e))
            .toList();
      }
      throw ServerExc(message: res.statusMessage.toString());
    } on DioException catch (e) {
      log(
        'DioException with Response: ${e.response?.statusCode} - ${e.response?.data}',
      );
      throw ServerExc(message: e.message.toString());
    }
  }
}
