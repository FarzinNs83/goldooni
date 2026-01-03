
import 'package:dio/dio.dart';
import '../../../../core/errors/server_exc.dart';
import '../../../../core/resources/api_constants.dart';
import '../models/cats_model.dart';

abstract class CatsRemote {
  Future<List<CatsModel>> getHomeData();
}

class CatsRemoteImpl implements CatsRemote {
  final Dio dio;
  CatsRemoteImpl(this.dio);
  @override
  Future<List<CatsModel>> getHomeData() async {
    try {
      final res = await dio.get(ApiConstants.cats);   
        if (res.statusCode == 200) {
          return (res.data as List)
    .map((e) => CatsModel.fromJson(e))
    .toList();

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
