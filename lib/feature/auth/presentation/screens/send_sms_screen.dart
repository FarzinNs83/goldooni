import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldooni/core/resources/app_colors.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/utils/unfocus.dart';
import 'package:goldooni/core/widgets/app_text_field.dart';
import 'package:goldooni/feature/auth/presentation/widgets/auth_button.dart';
import 'package:goldooni/gen/assets.gen.dart';
import 'package:goldooni/gen/fonts.gen.dart';

class SendSmsScreen extends StatelessWidget {
  SendSmsScreen({super.key});

  final phoneNumber = TextEditingController();
  final phoneFn = FocusNode();
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
              60.height,
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "ورود | ثبت نام",
                        style: context.textTheme.titleLarge!.copyWith(
                          fontFamily: FontFamily.vazirmatn,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    16.height,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "لطفا شماره تلفن یا ایمیل خود را وارد کنید.",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontFamily.vazirmatn,
                          fontWeight: FontWeight.w400,
                          color: AppColors.neturalColor,
                        ),
                      ),
                    ),
                    26.height,
                    AppTextField(
                      hintText: "۰۹۰۲۷۵۸۵۵۴۲",
                      ctrl: phoneNumber,
                      txtDir: TextDirection.rtl,
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
                      focusNode: phoneFn,
                    ),
                    24.height,
                    SizedBox(
                      width: double.infinity,
                      child: AuthButton(title: 'ورود', onPressed: () {}),
                    ),
                    24.height,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text.rich(
                        TextSpan(
                          text: "ورود شما به معنای پذیرش",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.vazirmatn,
                            color: AppColors.neturalColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: " شرایط گلُ‌دونی",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.vazirmatn,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: " و ",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.vazirmatn,
                                color: AppColors.neturalColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "قوانین حریم‌خصوصی",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.vazirmatn,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: " است.",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.vazirmatn,
                                color: AppColors.neturalColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
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
