import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/widgets/app_button.dart';
import 'package:goldooni/gen/assets.gen.dart';
import '../widgets/empty_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final textTheme = context.textTheme;
    final List test = ["s"];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colors.surface,
        elevation: 0,
        title: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.svg.logoMini,
              height: 40.r,
              colorFilter: ColorFilter.mode(
                colors.secondary,
                BlendMode.srcIn,
              ),
            ),
            Text(
              "سبد خرید",
              style: textTheme.headlineSmall?.copyWith(
                color: colors.secondary,
              ),
            ),
          ],
        ),
      ),
      body: test.isEmpty
          ? EmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Container(
                          height: 0.24.sh,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: colors.surface,
                            boxShadow: [
                              BoxShadow(
                                color: colors.shadow.withValues(alpha: .08),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  Assets.png.gol.path,
                                  width: 0.34.sw,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                8.width,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "فیلودندرون پرنسس شرابی",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.titleLarge?.copyWith(
                                          color: colors.secondary,
                                        ),
                                      ),
                                      Row(
                                        spacing: 6,
                                        children: [
                                          SvgPicture.asset(
                                            Assets.svg.discount,
                                            colorFilter: ColorFilter.mode(
                                              colors.error,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          Text(
                                            "850,000 تومان تخفیف",
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: colors.error,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "۱,۹۰۰,۰۰۰ تومان",
                                        style: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Divider(
                                        height: 16.h,
                                        color: colors.outlineVariant,
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: SvgPicture.asset(
                                              Assets.svg.addCircle,
                                            ),
                                          ),
                                          Text(
                                            "۱ عدد",
                                            style: textTheme.bodyLarge,
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: SvgPicture.asset(
                                              Assets.svg.minusCirlce,
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            onPressed: () {},
                                            icon: SvgPicture.asset(
                                              Assets.svg.trash,
                                              colorFilter: ColorFilter.mode(
                                                colors.error,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  height: 0.12.sh,
                  decoration: BoxDecoration(color: colors.surface),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton(title: "ادامه فرآیند خرید", onPressed: () {}),
                      Column(
                        spacing: 4,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "جمع سبد خرید",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colors.onSurface.withValues(alpha: .7),
                            ),
                          ),
                          Text(
                            "۱,۹۰۰,۰۰۰ تومان",
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
