import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/widgets/network_image.dart';
import 'package:goldooni/core/widgets/shimmer_widget.dart';
import 'package:goldooni/feature/home/presentation/widgets/offer_timer.dart';
import 'package:goldooni/feature/singleproduct/presentation/screens/single_product_screen.dart';
import 'package:goldooni/gen/assets.gen.dart';

import '../bloc/home_bloc.dart';

class DiscountOfferCard extends StatelessWidget {
  const DiscountOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final textTheme = context.textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.secondary.withValues(alpha: .9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                Assets.svg.discount,
                height: 28.r,
                width: 28.r,
                colorFilter: ColorFilter.mode(
                  colors.onSecondary,
                  BlendMode.srcIn,
                ),
              ),
              8.width,
              Text(
                "شگفت‌انگیز",
                style: textTheme.headlineSmall?.copyWith(
                  color: colors.onSecondary,
                ),
              ),
              16.width,
              Row(
                spacing: 4,
                children: [
                  OfferTimer(time: '۳۴'),
                  Text(
                    ":",
                    style: textTheme.headlineSmall?.copyWith(
                      color: colors.onSecondary,
                    ),
                  ),
                  OfferTimer(time: '۳۶'),
                  Text(
                    ":",
                    style: textTheme.headlineSmall?.copyWith(
                      color: colors.onSecondary,
                    ),
                  ),
                  OfferTimer(time: '۱۲'),
                ],
              ),
              Spacer(),
              TextButton.icon(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: colors.onSecondary,
                ),
                iconAlignment: IconAlignment.end,
                onPressed: () {},
                label: Text(
                  'همه',
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onSecondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
  height: 0.35.sh,
  child: BlocBuilder<HomeBloc, HomeState>(
    builder: (context, state) {
      final items = context.read<HomeBloc>().amazProducts;
      if (items.isEmpty || state is HomeAmazLoading) {
        return ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    width: 0.45.sw,
                    height: 180.h,
                    borderRadius: 12.r,
                  ),
                  8.height,
                  ShimmerWidget(
                    width: 0.3.sw,
                    height: 20.h,
                    borderRadius: 8.r,
                  ),
                  6.height,
                  Row(
                    children: [
                      ShimmerWidget(
                        width: 50.w,
                        height: 20.h,
                        borderRadius: 12.r,
                      ),
                      6.width,
                      ShimmerWidget(
                        width: 50.w,
                        height: 20.h,
                        borderRadius: 12.r,
                      ),
                    ],
                  ),
                  6.height,
                  ShimmerWidget(
                    width: 0.2.sw,
                    height: 20.h,
                    borderRadius: 12.r,
                  ),
                ],
              ),
            );
          },
        );
      }
      return ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = items[index];
          return FadeInLeft(
            delay: Duration(milliseconds: index * 50),
            duration: Duration(milliseconds: 400),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => context.navigate(
                  SingleProductScreen(id: item.id),
                ),
                child: Hero(
                  tag: "singlehero$index",
                  child: Container(
                    width: 0.45.sw,
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(0.02.sw),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: NetWorkImage(image: item.image, height: .7.sh, width: 0.8.sw)
                            ),
                          ),
                          8.height,
                          Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colors.secondary,
                            ),
                          ),
                          6.height,
                          Row(
                            spacing: 6,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: colors.error.withValues(alpha: .85),
                                ),
                                child: Text(
                                  ("${item.discount}٪").toPersianNumber(),
                                  style: textTheme.labelMedium?.copyWith(
                                    color: colors.onError,
                                  ),
                                ),
                              ),
                              Text(
                                "${(item.price.comma)} تومان".toPersianNumber(),
                                style: textTheme.bodySmall?.copyWith(
                                  color: colors.onSurface.withValues(alpha: .6),
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          6.height,
                          Text(
                            "${(item.discountedPrice.comma)} تومان".toPersianNumber(),
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colors.onSurface,
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
        },
      );
    },
  ),
)

        ],
      ),
    );
  }
}
