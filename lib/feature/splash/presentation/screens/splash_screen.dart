
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/utils/shared_pref_manager.dart' show SharedPref;
import 'package:goldooni/feature/auth/presentation/screens/send_sms_screen.dart';
import 'package:goldooni/feature/splash/presentation/bloc/splash_bloc.dart';
import 'package:goldooni/gen/assets.gen.dart';
import 'package:goldooni/main_wrapper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    final token = SharedPref.instance.getString('token');
    final ref = SharedPref.instance.getString('refresh');
    log(token.toString());
    log(ref.toString());

    if (token != null) {
      context.read<SplashBloc>().validateAccessToken();
    } else {
      Future.microtask(() {
        if (mounted) context.navigateR(SendSmsScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.primary,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAccessSuccess) {
            context.navigateR(MainWrapper());
          }

          if (state is SplashRefreshFailure) {
            context.navigateR(SendSmsScreen());
          }
        },
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset(
                Assets.svg.logo,
                height: 0.1.sh,
                colorFilter: ColorFilter.mode(
                  colors.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Positioned(
              bottom: 24.h,
              left: 0,
              right: 0,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: LoadingAnimationWidget.halfTriangleDot(
                  color: colors.onPrimary,
                  size: 0.06.sh,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
