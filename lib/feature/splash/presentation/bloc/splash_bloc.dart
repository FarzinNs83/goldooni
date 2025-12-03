import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/core/resources/api_constants.dart';
import 'package:goldooni/core/utils/json_log.dart';

import '../../../../core/utils/shared_pref_manager.dart';

part 'splash_state.dart';

class SplashBloc extends Cubit<SplashState> {
  SplashBloc() : super(SplashInitial());
  final Dio _dio = Dio();
  Future<void> validateAccessToken() async {
    try {
      final res = await _dio.get(
        ApiConstants.access,
        options: Options(
          headers: {
            "Authorization": "Bearer ${SharedPref.instance.getString('token')}",
          },
        ),
      );
      if (res.statusCode == 200) {
        emit(SplashAccessSuccess());
        jsonLog(res.data);
      }
    } on DioException catch (e) {
      log(e.response!.statusCode.toString());
      log("${e.response?.data}");
      emit(SplashAccessFailure());
      _validateRefreshToken();
      validateAccessToken();
    }
  }

  Future<void> _validateRefreshToken() async {
    SharedPref.instance.remove('token');
    try {
      final res = await _dio.get(
        ApiConstants.access,
        queryParameters: {'refresh': SharedPref.instance.getString('refresh')},
        options: Options(
          headers: {
            "Authorization":
                "Bearer ${SharedPref.instance.getString('refresh')}",
          },
        ),
      );
      if (res.statusCode == 201) {
        emit(SplashRefreshSuccess());
        jsonLog(res.data);
        SharedPref.instance.remove('refresh');
        SharedPref.instance.setString('token', res.data["access"]);
        SharedPref.instance.setString('refresh', res.data["refresh"]);
      } else if (res.statusCode == 401) {
        emit(SplashRefreshFailure());
        jsonLog(res.data);
      }
    } on DioException catch (e) {
      log("${e.response?.data}");
    }
  }
}
