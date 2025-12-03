
import 'package:dio/dio.dart';
import '../../../../core/errors/server_exc.dart';
import '../../../../core/resources/api_constants.dart';
import '../models/cats_model.dart';

abstract class CatsRemote {
  Future<List<CatsModel>> getHomeData(int page);
}

class CatsRemoteImpl implements CatsRemote {
  final Dio dio;
  CatsRemoteImpl(this.dio);
  @override
  Future<List<CatsModel>> getHomeData(int page) async {
    page = 1;
    try {
      final res = await dio.get('${ApiConstants.cats}$page');
      if (res.data['next'] != null) {
        if (res.statusCode == 200) {
          
          return (res.data['results'] as List)
    .map((e) => CatsModel.fromJson(e))
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
