import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:goldooni/feature/home/data/models/amazing_products_model.dart';

import '../../../../core/errors/server_exc.dart';
import '../../../../core/resources/api_constants.dart';

abstract class AmazingProductsRemote {
  Future<List<AmazingProductsModel>> getAmazingData(int page);
}

class AmazingProductsRemoteImpl implements AmazingProductsRemote {
  final Dio dio;
  AmazingProductsRemoteImpl(this.dio);
  @override
  Future<List<AmazingProductsModel>> getAmazingData(int page) async {
    try {
      final res = await dio.get('${ApiConstants.amazing}$page');
      if (res.statusCode == 200) {
        return (res.data['results'] as List)
            .map((e) => AmazingProductsModel.fromJson(e))
            .toList();
      }
      throw ServerExc(message: res.statusMessage.toString());
    } on DioException catch (e) {
      log(e.toString());
      log("No more data found");
      return [];
    }
  }
}
