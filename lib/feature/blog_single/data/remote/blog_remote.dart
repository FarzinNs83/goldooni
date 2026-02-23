import 'dart:developer';

import 'package:goldooni/core/errors/server_exc.dart';
import 'package:goldooni/core/resources/api_constants.dart';
import 'package:goldooni/export_pkg.dart';

import '../models/blog_model.dart';

abstract class BlogDetailRemote {
  Future<BlogDetailModel> getBlogDetail(int id);
}

class BlogDetailRemoteImpl implements BlogDetailRemote {
  final Dio _dio;

  BlogDetailRemoteImpl(this._dio);
  @override
  Future<BlogDetailModel> getBlogDetail(int id) async {
    try {
      final res = await _dio.get("${ApiConstants.blogDetails}$id/");
      if (res.statusCode == 200) {
        return BlogDetailModel.fromJson(res.data);
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
