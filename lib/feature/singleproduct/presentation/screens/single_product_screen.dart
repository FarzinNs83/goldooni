
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/widgets/network_image.dart';
import 'package:goldooni/core/widgets/shimmer_widget.dart';
import 'package:goldooni/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:goldooni/feature/singleproduct/presentation/bloc/single_product_bloc.dart';
import 'package:goldooni/feature/singleproduct/presentation/widgets/zoom_in_image.dart';
import 'package:goldooni/gen/assets.gen.dart';
import '../../../../core/widgets/app_button.dart';

class SingleProductScreen extends StatefulWidget {
  final int id;
  const SingleProductScreen({super.key, required this.id});
  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  @override
  void initState() {
    context.read<SingleProductBloc>().getSingleProduct(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final textTheme = context.textTheme;
    return BlocBuilder<SingleProductBloc, SingleProductState>(
      builder: (context, state) {
        if (state is SingleProductLoading) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ShimmerWidget(height: 270.h, width: double.infinity),
                        16.height,
                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: 16.w,
                          ),
                          child: ShimmerWidget(
                            height: 24.h,
                            width: double.infinity,
                          ),
                        ),
                        16.height,
                        Column(
                          children: List.generate(8, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 4.h,
                                horizontal: 16.w,
                              ),
                              child: ShimmerWidget(
                                height: 16.h,
                                width: double.infinity,
                                borderRadius: 12.r,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      ShimmerWidget(
                        height: 48.h,
                        width: .3.sw,
                        borderRadius: 12.r,
                      ),
                      Column(
                        spacing: 4.h,
                        children: [
                          ShimmerWidget(
                            height: 16.h,
                            width: .1.sw,
                            borderRadius: 12.r,
                          ),
                          ShimmerWidget(
                            height: 16.h,
                            width: .1.sw,
                            borderRadius: 12.r,
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
        if (state is SingleProductLoaded) {
          final item = context.read<SingleProductBloc>().singleProduct.first;
          return Scaffold(
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              height: 0.12.sh,
              decoration: BoxDecoration(color: colors.surface),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      final isInCart = context.read<CartBloc>().items.any(
                        (element) => element.id == item.id,
                      );
                      return AppButton(
                        title:
                            isInCart
                            ? 'حذف از سبد خرید'
                            : "افزودن به سبد خرید",
                        onPressed: () {
                          context.read<CartBloc>().addItem(item.id, 1);
                          context.read<CartBloc>().loadCart();
                        },
                      );
                    },
                  ),
                  Column(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ("${item.finalPrice.comma} تومان").toPersianNumber(),
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Visibility(
                        visible: item.discount != 0 ? true : false,
                        child: Text(
                          ("${item.price.comma} تومان").toPersianNumber(),
                          style: textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: colors.onSurface.withValues(alpha: .6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            appBar: AppBar(surfaceTintColor: Colors.transparent, elevation: 0),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Hero(
                tag: "singlehero",
                child: Column(
                  children: [
                    Stack(
                      children: [
                        NetWorkImage(
                          image: item.mainImage,
                          height: 270.h,
                          width: double.infinity,
                        ),
                        Positioned(
                          bottom: 16.h,
                          right: 16.w,
                          child: GestureDetector(
                            onTap: () => context.navigate(
                              ZoomInImage(image: item.mainImage),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: .5),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.zoom_in_map_rounded,
                                size: 24.r,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: colors.surface,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.title,
                                  style: textTheme.headlineMedium?.copyWith(
                                    color: colors.secondary,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<SingleProductBloc>()
                                        .toggleFavorite(item);
                                  },
                                  icon: state.favorites.contains(item)
                                      ? Icon(Icons.favorite, color: Colors.red)
                                      : SvgPicture.asset(
                                          Assets.svg.mynauiHeart,
                                          colorFilter: ColorFilter.mode(
                                            colors.primary,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            16.height,
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                item.description,
                                style: textTheme.bodyLarge?.copyWith(
                                  height: 1.8,
                                  color: colors.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    16.height,
                    Container(
                      color: colors.surface,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "دیدگاه کاربران",
                                  style: textTheme.titleMedium,
                                ),
                                TextButton.icon(
                                  iconAlignment: IconAlignment.end,
                                  icon: Icon(
                                    Icons.keyboard_arrow_left_outlined,
                                    color: colors.primary,
                                  ),
                                  onPressed: () {},
                                  label: Text(
                                    "مشاهده ${item.countComments} دیدگاه",
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  item.averageStars
                                      .toString()
                                      .toPersianNumber(),
                                  style: textTheme.headlineSmall?.copyWith(
                                    color: colors.secondary,
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 32.r,
                                ),
                                8.width,
                                Text(
                                  "(بر‌اساس نظر ${item.countComments} کاربر)",
                                  style: textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 0.3.sh,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 0.75.sw,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.surface,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: colors.outlineVariant,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: colors.shadow.withValues(
                                            alpha: .06,
                                          ),
                                          offset: Offset(0, 2),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 10.h,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "کاربر گلدونی",
                                                style: textTheme.titleMedium
                                                    ?.copyWith(
                                                      color: colors.secondary,
                                                    ),
                                              ),
                                              SizedBox(width: 8.w),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 4.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: colors.tertiary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        16.r,
                                                      ),
                                                ),
                                                child: Text(
                                                  "خریدار",
                                                  style: textTheme.labelSmall
                                                      ?.copyWith(
                                                        color: colors.primary,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.h),
                                          Row(
                                            children: List.generate(
                                              5,
                                              (i) => Padding(
                                                padding: EdgeInsets.only(
                                                  right: 2.w,
                                                ),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 18.r,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Expanded(
                                            child: Text(
                                              """لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطر آنچنان که لازم است.""",
                                              style: textTheme.bodyMedium
                                                  ?.copyWith(
                                                    height: 1.6,
                                                    color: colors.onSurface,
                                                  ),
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Row(
                                            children: [
                                              Text(
                                                "۲۳ مهر ۱۴۰۳",
                                                style: textTheme.bodySmall
                                                    ?.copyWith(
                                                      color: colors.onSurface
                                                          .withValues(
                                                            alpha: .7,
                                                          ),
                                                    ),
                                              ),
                                              Spacer(),
                                              TextButton.icon(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  minimumSize: Size(40.w, 32.h),
                                                ),
                                                iconAlignment:
                                                    IconAlignment.end,
                                                icon: SvgPicture.asset(
                                                  Assets.svg.like,
                                                  height: 20.r,
                                                  width: 20.r,
                                                  colorFilter: ColorFilter.mode(
                                                    colors.primary,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                                onPressed: () {},
                                                label: Text(
                                                  "۰",
                                                  style: textTheme.bodyMedium
                                                      ?.copyWith(
                                                        color: colors.onSurface,
                                                      ),
                                                ),
                                              ),
                                              TextButton.icon(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  minimumSize: Size(40.w, 32.h),
                                                ),
                                                iconAlignment:
                                                    IconAlignment.end,
                                                icon: SvgPicture.asset(
                                                  Assets.svg.dislike,
                                                  height: 20.r,
                                                  width: 20.r,
                                                  colorFilter: ColorFilter.mode(
                                                    colors.error,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                                onPressed: () {},
                                                label: Text(
                                                  "۰",
                                                  style: textTheme.bodyMedium
                                                      ?.copyWith(
                                                        color: colors.onSurface,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is SingleProductError) {
          return Center(child: Text(state.failure.message));
        } else {
          return Container();
        }
      },
    );
  }
}
