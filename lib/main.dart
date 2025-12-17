import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/resources/app_theme.dart';
import 'package:goldooni/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:goldooni/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:goldooni/feature/cats/presentation/bloc/cats_bloc.dart';
import 'package:goldooni/feature/home/presentation/bloc/home_bloc.dart';
import 'package:goldooni/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:goldooni/feature/singleproduct/presentation/bloc/single_product_bloc.dart';
import 'package:goldooni/feature/splash/presentation/bloc/splash_bloc.dart';
import 'package:goldooni/feature/splash/presentation/screens/splash_screen.dart';
import 'di_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(AppTheme.lightOverlay);
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => di.sl<AuthBloc>()),
          BlocProvider<HomeBloc>(create: (context) => di.sl<HomeBloc>()),
          BlocProvider<ProfileBloc>(create: (context) => di.sl<ProfileBloc>()),
          BlocProvider<SplashBloc>(create: (context) => di.sl<SplashBloc>()),
          BlocProvider<CatsBloc>(create: (context) => di.sl<CatsBloc>()),
          BlocProvider<CartBloc>(create: (context) => di.sl<CartBloc>()),
          BlocProvider<SingleProductBloc>(create: (context) => di.sl<SingleProductBloc>()),
        ],
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return MaterialApp(
              builder: (context, child) {
                final mediaQuery = MediaQuery.of(context);
                return MediaQuery(
                  data: mediaQuery.copyWith(
                    textScaler: TextScaler.noScaling,
                    boldText: false,
                  ),
                  child: child!,
                );
              },
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [Locale('fa', 'IR')],
              locale: Locale('fa', 'IR'),
              debugShowCheckedModeBanner: false,
              theme: state.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
              home: SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
