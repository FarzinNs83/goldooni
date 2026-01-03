import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldooni/feature/auth/domain/entities/send_sms_entity.dart';
import 'package:goldooni/feature/auth/domain/usecases/register_form_usecase.dart';
import 'package:goldooni/feature/auth/domain/usecases/send_sms_usecase.dart';
import 'package:goldooni/feature/auth/domain/usecases/verify_otp_usecase.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/app_ext.dart';
import '../../domain/entities/register_form_entity.dart';
import '../../domain/entities/verify_otp_entity.dart';

part 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  final SendSmsUseCase sendSmsUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final RegisterFormUseCase registerFormUseCase;
  Timer? _timer;
  int _start = 120;
  AuthBloc(this.sendSmsUseCase, this.verifyOtpUseCase, this.registerFormUseCase)
    : super(AuthInitial());

  Future<void> sendSms({required String phoneNum}) async {
    emit(AuthLoading());
    final res = await sendSmsUseCase(SendSmsParams(phoneNum: phoneNum));
    res.fold((l) => emit(AuthError(l)), (r) {
      emit(AuthSendSms(sendSmsEntity: r));
    });
  }

  Future<void> verifyOtp({
    required String otp,
    required String phoneNum,
  }) async {
    emit(AuthLoading());
    final res = await verifyOtpUseCase(
      VerifyOtpParams(otp: otp, phoneNum: phoneNum),
    );
    res.fold(
      (l) => emit(AuthError(l)),
      (r) => emit(AuthVerifyOtp(verifyOtpEntity: r)),
    );
  }

  Future<void> register({
    required String name,
    required String address,
    required String birthdate,
    required String phoneNum,
    required String codeMeli,
    required String lat,
    required String lon,
    required String pw,
  }) async {
    emit(AuthLoading());
    final res = await registerFormUseCase(
      RegisterParams(
        name: name,
        address: address,
        birthdate: birthdate,
        phoneNum: phoneNum,
        codeMeli: codeMeli,
        lat: lat,
        lon: lon,
        pw: pw,
      ),
    );
    res.fold(
      (l) => emit(AuthError(l)),
      (r) => emit(AuthRegister(registerFormEntity: r)),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start > 0) {
        _start--;
        emit(AuthTimerTick(_start));
      } else {
        timer.cancel();
        emit(AuthTimerFinished("زمان اعتبار کد به پایان رسید."));
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    _start = 120;
  }

  String formatTimer(int time) {
    var duration = Duration(seconds: time);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(
      duration.inMinutes.remainder(60),
    ).toPersianNumber();
    String twoDigitSeconds = twoDigits(
      duration.inSeconds.remainder(60),
    ).toPersianNumber();
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  ({String hours, String minutes, String seconds}) formatTimerParts(int time) {
    final duration = Duration(seconds: time);

    String twoDigits(int n) => n.toString().padLeft(2, "0");

    return (
      hours: twoDigits(duration.inHours.remainder(60)).toPersianNumber(),
      minutes: twoDigits(duration.inMinutes.remainder(60)).toPersianNumber(),
      seconds: twoDigits(duration.inSeconds.remainder(60)).toPersianNumber(),
    );
  }
}
