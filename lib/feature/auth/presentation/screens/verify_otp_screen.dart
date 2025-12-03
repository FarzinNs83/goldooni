import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldooni/core/resources/global_vars.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/utils/unfocus.dart';
import 'package:goldooni/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:goldooni/feature/auth/presentation/screens/register_form_screen.dart';
import 'package:goldooni/feature/auth/presentation/screens/send_sms_screen.dart';
import 'package:goldooni/feature/auth/presentation/widgets/otp_widget.dart';
import 'package:goldooni/gen/assets.gen.dart';
import 'package:goldooni/main_wrapper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/widgets/app_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phone;

  const VerifyOtpScreen({super.key, required this.phone});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String? otpCode;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(otp)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final textTheme = context.textTheme;
    return Unfocus(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.svg.logoSec, height: 0.1.sh),
                  32.height,
                  Text.rich(
                    TextSpan(
                      text: 'کد فعال سازی برای شماره',
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: " ${widget.phone.toPersianNumber()} ",
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colors.secondary,
                          ),
                        ),
                        TextSpan(
                          text: "ارسال شد.",
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  14.height,
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().cancelTimer();
                      context.navigateR(SendSmsScreen());
                    },
                    child: Text(
                      "شماره اشتباه است/ویرایش شماره",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colors.secondary,
                      ),
                    ),
                  ),
                  24.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "کد فعال سازی را وارد کنید",
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colors.primary,
                              ),
                            ),
                            BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state is AuthTimerFinished) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                    ),
                                  );
                                  context.navigateR(SendSmsScreen());
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthTimerTick) {
                                  return Text(
                                    context.read<AuthBloc>().formatTimer(
                                      state.time,
                                    ),
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colors.primary,
                                    ),
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          ],
                        ),

                        14.height,
                        OTPWidget(
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                        28.height,
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthVerifyOtp) {
                              if (isReg) {
                                context.navigateR(MainWrapper());
                              } else {
                                context.navigateR(
                                  RegisterFormScreen(phone: widget.phone),
                                );
                              }
                            }
                            if (state is AuthError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.failure.message)),
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
                                title: 'تایید',
                                onPressed: () {
                                  context.read<AuthBloc>().cancelTimer();
                                  context.read<AuthBloc>().verifyOtp(
                                    otp: otpCode!,
                                    phoneNum: widget.phone,
                                  );
                                },
                              ),
                            );
                          },
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
    );
  }
}
