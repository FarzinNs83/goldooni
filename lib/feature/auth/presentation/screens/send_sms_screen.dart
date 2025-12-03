import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldooni/core/resources/app_animation.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/utils/unfocus.dart';
import 'package:goldooni/core/widgets/app_text_field.dart';
import 'package:goldooni/feature/auth/presentation/screens/verify_otp_screen.dart';
import 'package:goldooni/core/widgets/app_button.dart';
import 'package:goldooni/gen/assets.gen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../bloc/auth_bloc.dart';

class SendSmsScreen extends StatefulWidget {
  const SendSmsScreen({super.key});

  @override
  State<SendSmsScreen> createState() => _SendSmsScreenState();
}

class _SendSmsScreenState extends State<SendSmsScreen> {
  final phoneNumber = TextEditingController();

  final phoneFn = FocusNode();

  @override
  void dispose() {
    phoneNumber.dispose();
    phoneFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final textTheme = context.textTheme;
    return Unfocus(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: FadeSlideAnimation(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.svg.logoSec, height: 0.1.sh),
                    60.height,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "ورود | ثبت نام",
                              style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          16.height,
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "لطفا شماره تلفن یا ایمیل خود را وارد کنید.",
                              style: textTheme.bodyLarge?.copyWith(
                                color: colors.onSurface.withValues(alpha: .8),
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
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthSendSms) {
                                context.navigate(
                                  VerifyOtpScreen(phone: phoneNumber.text),
                                );
                              }
                              if (state is AuthError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.failure.message),
                                  ),
                                );
                                log(state.failure.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: LoadingAnimationWidget.halfTriangleDot(
                                    color: colors.primary,
                                    size: 0.06.sh,
                                  ),
                                );
                              }
                              return SizedBox(
                                width: double.infinity,
                                child: AppButton(
                                  title: 'ورود',
                                  onPressed: () {
                                    context.read<AuthBloc>().sendSms(
                                      phoneNum: phoneNumber.text,
                                    );
                                    context.read<AuthBloc>().startTimer();
                                  },
                                ),
                              );
                            },
                          ),
                          24.height,
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text.rich(
                              TextSpan(
                                text: "ورود شما به معنای پذیرش",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colors.onSurface.withValues(alpha: .8),
                                ),
                                children: [
                                  TextSpan(
                                    text: " شرایط گلُ‌دونی",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " و ",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colors.onSurface.withValues(
                                        alpha: .8,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "قوانین حریم‌خصوصی",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " است.",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colors.onSurface.withValues(
                                        alpha: .8,
                                      ),
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
          ),
        ),
      ),
    );
  }
}
