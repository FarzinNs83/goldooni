part of 'splash_bloc.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}
class SplashAccessSuccess extends SplashState {}
class SplashRefreshSuccess extends SplashState {}
class SplashAccessFailure extends SplashState {}
class SplashRefreshFailure extends SplashState {}
