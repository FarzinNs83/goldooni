import 'package:goldooni/export_pkg.dart';
import 'package:goldooni/feature/blog/data/remote/blog_remote.dart';
import 'package:goldooni/feature/blog/data/repositories/blog_repository_impl.dart';
import 'package:goldooni/feature/blog/domain/repositories/blog_repository.dart';
import 'package:goldooni/feature/blog/presentation/bloc/blog_bloc.dart';

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
  sl.registerLazySingleton<BlogRemote>(() => BlogRemoteImpl(sl<Dio>()));
  sl.registerLazySingleton<SingleProductRemote>(
    () => SingleProductRemoteImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<CatsDataRemote>(() => CatsDataRemoteImpl(sl<Dio>()));
  sl.registerLazySingleton<CartRemote>(() => CartRemoteImpl(sl<Dio>()));
  sl.registerLazySingleton<SliderRemote>(() => SliderRemoteImpl(sl<Dio>()));
  sl.registerLazySingleton<SearchRemote>(() => SearchRemoteImpl(sl<Dio>()));
  //For repo
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<BlogRepository>(
    () => BlogRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<SingleproductRepository>(
    () => SingleproductRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl(), sl(), sl(), sl(),sl(),sl()),
  );
  sl.registerLazySingleton<CatsRepository>(() => CatsRepositoryImpl(sl()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
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
  sl.registerFactory(() => CatsBloc(sl()));
  sl.registerFactory(() => CartBloc(sl()));
  sl.registerFactory(() => BlogBloc(sl()));
}
