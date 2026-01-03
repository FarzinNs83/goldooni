import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/utils/unfocus.dart';
import 'package:goldooni/core/widgets/app_text_field.dart';
import 'package:goldooni/core/widgets/app_button.dart';
import 'package:goldooni/feature/auth/presentation/widgets/drop_down_form.dart';
import 'package:goldooni/feature/home/presentation/bloc/home_bloc.dart';
import 'package:goldooni/main_wrapper.dart';

import '../../../../gen/assets.gen.dart';
import '../bloc/auth_bloc.dart';

class RegisterFormScreen extends StatefulWidget {
  final String phone;
  const RegisterFormScreen({super.key, required this.phone});

  @override
  State<RegisterFormScreen> createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  String? day;
  String? month;
  String? year;
  final nameCtrl = TextEditingController();

  final nameFn = FocusNode();

  final addressCtrl = TextEditingController();

  final addressFn = FocusNode();

  late TextEditingController phoneNumCtrl;

  final phoneNumFn = FocusNode();

  final codeMeliCtrl = TextEditingController();

  final codeMeliFn = FocusNode();

  final pwCtrl = TextEditingController();

  final pwFn = FocusNode();

  final latCtrl = TextEditingController();

  final latFn = FocusNode();

  final lonCtrl = TextEditingController();

  final lonFn = FocusNode();
  @override
  void initState() {
    context.read<HomeBloc>().determinePosition();
    phoneNumCtrl = TextEditingController(text: widget.phone);
    super.initState();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    nameFn.dispose();
    addressCtrl.dispose();
    addressFn.dispose();
    phoneNumCtrl.dispose();
    phoneNumFn.dispose();
    codeMeliCtrl.dispose();
    codeMeliFn.dispose();
    pwCtrl.dispose();
    pwFn.dispose();
    latCtrl.dispose();
    latFn.dispose();
    lonCtrl.dispose();
    lonFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Unfocus(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  40.height,
                  SvgPicture.asset(Assets.svg.logoSec, height: 0.1.sh),
                  40.height,
                  TextFieldLable(title: "نام و نام‌خانوادگی"),
                  8.height,
                  AppTextField(
                    hintText: "مثال: محمد رضایی",
                    ctrl: nameCtrl,
                    focusNode: nameFn,
                    nextFocus: addressFn,
                  ),
                  16.height,
                  TextFieldLable(title: "آدرس"),
                  8.height,
                  AppTextField(
                    hintText: "مثال: تهران، زعفرانیه، کوچه مهر",
                    ctrl: addressCtrl,
                    focusNode: addressFn,
                    nextFocus: phoneNumFn,
                  ),
                  16.height,
                  TextFieldLable(title: "شماره همراه"),
                  8.height,
                  AppTextField(
                    readOnly: true,
                    hintText: "۰۹۰۲۷۵۸۵۵۱۱",
                    ctrl: phoneNumCtrl,
                    focusNode: phoneNumFn,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.left,
                    nextFocus: codeMeliFn,
                  ),
                  16.height,
                  TextFieldLable(title: "کد‌ملی"),
                  8.height,
                  AppTextField(
                    hintText: "بدون خط تیره: 221569873",
                    ctrl: codeMeliCtrl,
                    focusNode: codeMeliFn,
                    nextFocus: pwFn,
                  ),
                  16.height,
                  TextFieldLable(title: "رمز عبور"),
                  8.height,
                  AppTextField(
                    hintText: "رمز عبور",
                    ctrl: pwCtrl,
                    isObsecure: true,
                    focusNode: pwFn,
                  ),
                  16.height,
                  TextFieldLable(title: "تاریخ تولد"),
                  8.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 0.3.sw,
                        child: DropDownForm(
                          value: '',
                          items: List.generate(30, (index) => "${index + 1}"),
                          hint: '۱۴',
                          onChanged: (String? value) {
                            setState(() {
                              day = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 0.3.sw,
                        child: DropDownForm(
                          onChanged: (String? value) {
                            setState(() {
                              month = value?.toNum();
                            });
                          },
                          value: '',
                          items: [
                            "فروردین",
                            "اردیبهشت",
                            "خرداد",
                            "تیر",
                            "مرداد",
                            "شهریور",
                            "مهر",
                            "آبان",
                            "آذر",
                            "دی",
                            "بهمن",
                            "اسفند",
                          ],
                          hint: 'مهر',
                        ),
                      ),
                      SizedBox(
                        width: 0.3.sw,
                        child: DropDownForm(
                          onChanged: (String? value) {
                            setState(() {
                              year = value;
                            });
                          },
                          value: '',
                          items: List.generate(
                            105,
                            (index) => "${1300 + index}",
                          ),
                          hint: '۱۳۷۰',
                        ),
                      ),
                    ],
                  ),
                  16.height,
                  TextFieldLable(title: "موقعیت مکانی"),
                  8.height,
                  AppTextField(
                    hintText: "برای انتخاب موقعیت مکانی کلیک کنید",
                    ctrl: TextEditingController.fromValue(
                      TextEditingValue(
                        text:
                            "${latCtrl.text}, ${lonCtrl.text}",
                      ),
                    ),
                    focusNode: latFn,
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        await showSimplePickerLocation(
                          contentPadding: EdgeInsets.all(8),
                          context: context,
                          isDismissible: true,
                          title: "انتخاب موقعیت مکانی",
                          textCancelPicker: "لغو",
                          textConfirmPicker: "انتخاب",
                          zoomOption: const ZoomOption(
                            initZoom: 14,
                            minZoomLevel: 6,
                            maxZoomLevel: 19,
                          ),
                          initPosition: GeoPoint(
                            latitude: context.read<HomeBloc>().lat,
                            longitude: context.read<HomeBloc>().lon,
                          ),
                          radius: 8.0,
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              latCtrl.text = value.latitude.toString();
                            lonCtrl.text = value.longitude.toString();
                            });
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SvgPicture.asset(Assets.svg.location),
                      ),
                    ),
                  ),
                  38.height,
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthRegister) {
                        context.navigateR(MainWrapper());
                      }
                      if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.failure.message)),
                        );
                        log(state.failure.message);
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          title: "ثبت‌نام",
                          onPressed: () => context.read<AuthBloc>().register(
                            name: nameCtrl.text,
                            address: addressCtrl.text,
                            birthdate:
                                "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}",
                            phoneNum: phoneNumCtrl.text,
                            codeMeli: codeMeliCtrl.text,
                            lat: latCtrl.text,
                            lon: lonCtrl.text,
                            pw: pwCtrl.text,
                          ),
                        ),
                      );
                    },
                  ),
                  24.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldLable extends StatelessWidget {
  const TextFieldLable({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: context.textTheme.titleMedium?.copyWith(
          color: context.theme.colorScheme.onSurface.withValues(alpha: .9),
        ),
      ),
    );
  }
}
