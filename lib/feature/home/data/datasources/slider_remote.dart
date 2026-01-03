import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:goldooni/core/errors/server_exc.dart';

import '../../../../core/resources/api_constants.dart';
import '../models/slider_model.dart';

abstract class SliderRemote {
  Future<List<SliderModel>> getSlider();
}

class SliderRemoteImpl implements SliderRemote {
  final Dio _dio;
  SliderRemoteImpl(this._dio);
  @override
  Future<List<SliderModel>> getSlider() async {
    try {
      final res = await _dio.get(ApiConstants.slider);
      if (res.statusCode == 200) {
        return (res.data as List)
            .map((e) => SliderModel.fromJson(e))
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
