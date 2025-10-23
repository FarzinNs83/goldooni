import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/resources/app_colors.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/utils/unfocus.dart';
import 'package:goldooni/core/widgets/app_text_field.dart';
import 'package:goldooni/feature/auth/presentation/widgets/auth_button.dart';
import 'package:goldooni/feature/auth/presentation/widgets/drop_down_form.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';

class RegisterFormScreen extends StatelessWidget {
  RegisterFormScreen({super.key});
  final nameCtrl = TextEditingController();
  final nameFn = FocusNode();
  final addressCtrl = TextEditingController();
  final addressFn = FocusNode();
  final phoneNumCtrl = TextEditingController();
  final phoneNumFn = FocusNode();
  final codeMeliCtrl = TextEditingController();
  final codeMeliFn = FocusNode();
  final latLonCtrl = TextEditingController();
  final latLonFn = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Unfocus(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  40.height,
                  SvgPicture.asset(
                    Assets.svg.logoSec,
                    height: context.screenHeight * .1,
                  ),
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
                  ),
                  16.height,
                  TextFieldLable(title: "تاریخ تولد"),
                  8.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: context.screenWidth * .3,
                        child: DropDownForm(
                          value: '',
                          items: List.generate(30, (index) => "${index + 1}"),
                          hint: '۱۴',
                        ),
                      ),
                      SizedBox(
                        width: context.screenWidth * .3,
                        child: DropDownForm(
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
                        width: context.screenWidth * .3,
                        child: DropDownForm(
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
                    ctrl: latLonCtrl,
                    focusNode: latLonFn,
                    suffixIcon: GestureDetector(
                      onTap: () {
                       
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SvgPicture.asset(Assets.svg.location),
                      ),
                    ),
                  ),
                  38.height,
                  SizedBox(
                    width: double.infinity,
                    child: AuthButton(title: "ثبت‌نام", onPressed: () {}),
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
        style: TextStyle(
          fontFamily: FontFamily.vazirmatn,
          fontSize: 16,
          color: AppColors.neturalColor8,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
