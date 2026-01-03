import 'dart:developer';

import 'package:goldooni/core/errors/server_exc.dart';
import 'package:goldooni/core/resources/api_constants.dart';
import 'package:goldooni/export_pkg.dart';
import 'package:goldooni/feature/blog/data/models/blog_model.dart';

import '../../../../core/utils/json_log.dart';

abstract class BlogRemote {
  Future<List<BlogModel>> getBlogs();
}

class BlogRemoteImpl implements BlogRemote {
  final Dio _dio;

  BlogRemoteImpl(this._dio);
  @override
  Future<List<BlogModel>> getBlogs() async {
    try {
      final res = await _dio.get(ApiConstants.blog);
      if (res.statusCode == 200) {
        return (res.data['results'] as List)
            .map((e) => BlogModel.fromJson(e))
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
