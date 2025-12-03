part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final Failure failure;
  AuthError(this.failure);
}

class AuthTimerTick extends AuthState {
  final int time;
  AuthTimerTick(this.time);
}

class AuthTimerFinished extends AuthState {
  final String message;
  AuthTimerFinished(this.message);
}

class AuthSendSms extends AuthState {
  final SendSmsEntity sendSmsEntity;

  AuthSendSms({required this.sendSmsEntity});
}

class AuthVerifyOtp extends AuthState {
  final VerifyOtpEntity verifyOtpEntity;
  AuthVerifyOtp({required this.verifyOtpEntity});
}

class AuthRegister extends AuthState {
  final RegisterFormEntity registerFormEntity;
  AuthRegister({required this.registerFormEntity});
}

class AuthIsRegistered extends AuthState {}

class AuthIsNotRegistered extends AuthState {}
