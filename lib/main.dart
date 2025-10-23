import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:goldooni/core/resources/app_colors.dart';
import 'package:goldooni/core/resources/app_theme.dart';
import 'package:goldooni/feature/auth/presentation/screens/register_form_screen.dart';
import 'package:goldooni/feature/auth/presentation/screens/send_sms_screen.dart';
import 'package:goldooni/feature/auth/presentation/screens/verify_otp_screen.dart';
import 'package:goldooni/feature/splash/presentation/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('fa', 'IR')],
      locale: Locale('fa', 'IR'),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: RegisterFormScreen(),
    );
  }
}
