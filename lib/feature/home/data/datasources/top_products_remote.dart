import 'package:dio/dio.dart';
import 'package:goldooni/feature/home/data/models/top_prodcuts_mode.dart';

import '../../../../core/errors/server_exc.dart';
import '../../../../core/resources/api_constants.dart';

abstract class TopProductsRemote {
  Future<List<TopProductsModel>> getTopData(int page);
}

class TopProductsRemoteImpl implements TopProductsRemote {
  final Dio dio;
  TopProductsRemoteImpl(this.dio);

  @override
  Future<List<TopProductsModel>> getTopData(int page) async {
    page = 1;

    try {
      final res = await dio.get('${ApiConstants.top}$page');

      if (res.statusCode == 200) {
        final results = res.data['results'] as List?;

        if (results == null || results.isEmpty) {
          return [];
        }

        return results.map((e) => TopProductsModel.fromJson(e)).toList();
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
