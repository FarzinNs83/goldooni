
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
    page = 1;
    try {
      final res = await dio.get('${ApiConstants.amazing}$page');
      if (res.data['next'] != null) {
        if (res.statusCode == 200) {
          return (res.data['results'] as List)
    .map((e) => AmazingProductsModel.fromJson(e))
    .toList();

        } else {
          throw ServerExc(message: res.statusMessage.toString());
        }
      } else {
        throw ServerExc(message: "No more data");
      }
    } on DioException catch (e) {
      throw ServerExc(
        message:
            "Error ${e.response?.statusCode}: ${e.response?.data} \n ${e.toString()}",
      );
    }
  }
}
