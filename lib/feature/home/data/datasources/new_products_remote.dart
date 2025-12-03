import 'package:dio/dio.dart';
import 'package:goldooni/feature/home/data/models/new_products_model.dart';

import '../../../../core/errors/server_exc.dart';
import '../../../../core/resources/api_constants.dart';

abstract class NewProductsRemote {
  Future<List<NewProductsModel>> getNewData(int page);
}

class NewProductsRemoteImpl implements NewProductsRemote {
  final Dio dio;
  NewProductsRemoteImpl(this.dio);

  @override
  Future<List<NewProductsModel>> getNewData(int page) async {
    page = 1;
    try {
      final res = await dio.get('${ApiConstants.newProduct}$page');
      if (res.data['next'] != null) {
        if (res.statusCode == 200) {
          return (res.data['results'] as List)
              .map((e) => NewProductsModel.fromJson(e))
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
