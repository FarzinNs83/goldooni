import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldooni/core/resources/app_colors.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/utils/unfocus.dart';
import 'package:goldooni/feature/auth/presentation/screens/register_form_screen.dart';
import 'package:goldooni/feature/auth/presentation/widgets/otp_widget.dart';
import 'package:goldooni/gen/assets.gen.dart';
import 'package:goldooni/gen/fonts.gen.dart';

import '../widgets/auth_button.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Unfocus(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.svg.logoSec,
                height: context.screenHeight * .1,
              ),
              32.height,
              Text.rich(
                TextSpan(
                  text: 'کد فعال سازی برای شماره',
                  style: TextStyle(
                    fontFamily: FontFamily.vazirmatn,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: " ۰۹۰۲۷۵۸۵۵۴۲ ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.vazirmatn,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    TextSpan(
                      text: "ارسال شد.",
                      style: TextStyle(
                        fontFamily: FontFamily.vazirmatn,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              14.height,
              TextButton(
                onPressed: () {},
                child: Text(
                  "شماره اشتباه است/ویرایش شماره",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.vazirmatn,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
              24.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "کد فعال سازی را وارد کنید",
                          style: TextStyle(
                            fontFamily: FontFamily.vazirmatn,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(
                          "۲:۵۹",
                          style: TextStyle(
                            fontFamily: FontFamily.vazirmatn,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    14.height,
                    OTPWidget(),
                    28.height,
                    SizedBox(
                      width: double.infinity,
                      child: AuthButton(
                        title: 'تایید',
                        onPressed: () {
                          context.navigateR(RegisterFormScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
