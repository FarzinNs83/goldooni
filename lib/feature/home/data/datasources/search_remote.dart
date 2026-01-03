import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:goldooni/core/errors/server_exc.dart';
import 'package:goldooni/core/resources/api_constants.dart';
import 'package:goldooni/feature/home/data/models/search_model.dart';

abstract class SearchRemote {
  Future<List<SearchModel>> searchByName(String name);
}

class SearchRemoteImpl implements SearchRemote {
  final Dio _dio;
  SearchRemoteImpl(this._dio);
  @override
  Future<List<SearchModel>> searchByName(String name) async {
    try {
      final res = await _dio.get("${ApiConstants.searchByName}$name");
      if (res.statusCode == 200) {
        return (res.data as List)
            .map((e) => SearchModel.fromJson(e))
            .toList();
      } else {
        throw ServerExc(message: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      log(
        'DioException with Response: ${e.response?.statusCode} - ${e.response?.data}',
      );
      throw ServerExc(message: e.message.toString());
    }
  }
}
