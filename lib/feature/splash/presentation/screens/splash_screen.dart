import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/gen/assets.gen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/resources/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              Assets.svg.logo,
              height: context.screenHeight * .1,
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: LoadingAnimationWidget.dotsTriangle(
              color: AppColors.white,
              size: context.screenHeight * .06,
            ),
          ),
        ],
      ),
    );
  }
}
