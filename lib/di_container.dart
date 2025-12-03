import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:goldooni/core/utils/shared_pref_manager.dart';
import 'package:goldooni/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:goldooni/feature/auth/domain/repositories/auth_repository.dart';
import 'package:goldooni/feature/auth/domain/usecases/register_form_usecase.dart';
import 'package:goldooni/feature/auth/domain/usecases/send_sms_usecase.dart';
import 'package:goldooni/feature/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:goldooni/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:goldooni/feature/home/data/datasources/amazing_products_remote.dart';
import 'package:goldooni/feature/home/data/datasources/cats_remote.dart';
import 'package:goldooni/feature/home/data/datasources/new_products_remote.dart';
import 'package:goldooni/feature/home/data/datasources/top_products_remote.dart';
import 'package:goldooni/feature/home/data/repositories/home_repository_impl.dart';
import 'package:goldooni/feature/home/domain/repositories/home_repository.dart';
import 'package:goldooni/feature/home/domain/usecases/get_amaz_products.dart';
import 'package:goldooni/feature/home/domain/usecases/get_cats.dart';
import 'package:goldooni/feature/home/presentation/bloc/home_bloc.dart';
import 'package:goldooni/feature/profile/data/datasources/profile_remote.dart';
import 'package:goldooni/feature/profile/data/repositories/profile_repository_impl.dart';
import 'package:goldooni/feature/profile/domain/repositories/profile_repository.dart';
import 'package:goldooni/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:goldooni/feature/singleproduct/data/datasources/single_product_remote.dart';
import 'package:goldooni/feature/singleproduct/data/repositories/single_product_repository_impl.dart';
import 'package:goldooni/feature/singleproduct/domain/repositories/single_product_repository.dart';
import 'package:goldooni/feature/singleproduct/presentation/bloc/single_product_bloc.dart';
import 'package:goldooni/feature/splash/presentation/bloc/splash_bloc.dart';

import 'feature/auth/data/datasources/auth_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await SharedPref.instance.init();
  sl.registerSingleton(SharedPref.instance);
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        sendTimeout: Duration(seconds: 7),
        receiveTimeout: Duration(seconds: 7),
        connectTimeout: Duration(seconds: 7),
      ),
    ),
  );
  //For Remote
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(sl<Dio>()));
  sl.registerLazySingleton<CatsRemote>(() => CatsRemoteImpl(sl<Dio>()));
  sl.registerLazySingleton<AmazingProductsRemote>(
    () => AmazingProductsRemoteImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<NewProductsRemote>(
    () => NewProductsRemoteImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<TopProductsRemote>(
    () => TopProductsRemoteImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<ProfileRemote>(() => ProfileRemoteImpl(sl<Dio>()));
  sl.registerLazySingleton<SingleProductRemote>(
    () => SingleProductRemoteImpl(sl<Dio>()),
  );
  //For repo
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<SingleproductRepository>(
    () => SingleproductRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl(), sl(), sl(), sl()),
  );
  //For usecase
  sl.registerLazySingleton(() => SendSmsUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => RegisterFormUseCase(sl()));
  sl.registerLazySingleton(() => GetCatsUseCase(sl()));
  sl.registerLazySingleton(() => GetAmazProducts(sl()));
  //For bloc
  sl.registerFactory(
    () => AuthBloc(
      sl<SendSmsUseCase>(),
      sl<VerifyOtpUseCase>(),
      sl<RegisterFormUseCase>(),
    ),
  );
  sl.registerFactory(() => HomeBloc(sl()));
  sl.registerFactory(() => ProfileBloc(sl()));
  sl.registerFactory(() => SplashBloc());
  sl.registerFactory(() => SingleProductBloc(sl()));
}
