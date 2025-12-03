
import 'package:dio/dio.dart';
import 'package:goldooni/core/errors/server_exc.dart';
import 'package:goldooni/feature/profile/data/models/profile_model.dart';

import '../../../../core/resources/api_constants.dart';
import '../../../../core/utils/shared_pref_manager.dart';

abstract class ProfileRemote {
  Future<List<ProfileModel>> getProfile();
}

class ProfileRemoteImpl extends ProfileRemote {
  final Dio dio;

  ProfileRemoteImpl(this.dio);
  @override
  Future<List<ProfileModel>> getProfile() async{
       try {
      final res = await Dio().get(
      ApiConstants.profile,
      options: Options(
        headers: {
        "Authorization": "Bearer ${SharedPref.instance.getString('token')}"
      })
    );
    if (res.statusCode == 200) {
      return [ProfileModel.fromJson(res.data)];
    } else {
      throw ServerExc(message: res.statusMessage.toString());
    }
    } on DioException catch (e) {
      throw ServerExc(message: e.response?.data);
    }
  }
}
