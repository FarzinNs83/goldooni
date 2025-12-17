import 'package:dio/dio.dart';
import 'package:goldooni/core/resources/api_constants.dart';
import '../../../../core/errors/server_exc.dart';
import '../models/single_product_model.dart';

abstract class SingleProductRemote {
  Future<List<SingleProductModel>> getSingleProduct(int id);
}

class SingleProductRemoteImpl implements SingleProductRemote {
  final Dio _dio;

  SingleProductRemoteImpl(this._dio);
  @override
  Future<List<SingleProductModel>> getSingleProduct(int id) async {
    try {
      final res = await _dio.get("${ApiConstants.singleProduct}$id/");
      if (res.statusCode == 200) {
        return [SingleProductModel.fromJson(res.data)];
      } else {
        throw ServerExc(message: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      throw ServerExc(
        message:
            "Error ${e.response?.statusCode}: ${e.response?.data} \n ${e.toString()}",
      );
    }
  }
}
