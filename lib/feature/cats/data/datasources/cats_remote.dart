import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:goldooni/core/resources/api_constants.dart';

import '../../../../core/errors/server_exc.dart';
import '../models/cats_model.dart';

abstract class CatsDataRemote {
  Future<List<CatsModel>> getCatsData(int page, int id);
}

class CatsDataRemoteImpl implements CatsDataRemote {
  final Dio _dio;
  CatsDataRemoteImpl(this._dio);
  @override
  Future<List<CatsModel>> getCatsData(int page, int id) async {
    try {
      final res = await _dio.get(
        "${ApiConstants.baseUrl}/products/categories/$id/?page=$page",
      );
      if (res.statusCode == 200) {
        return (res.data['results'] as List)
            .map((e) => CatsModel.fromJson(e))
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
