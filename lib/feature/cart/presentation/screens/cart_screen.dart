import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/widgets/app_button.dart';
import 'package:goldooni/core/widgets/show_toast.dart';
import 'package:goldooni/gen/assets.gen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/widgets/network_image.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/empty_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colors.surface,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.svg.logoMini,
              height: 40.r,
              colorFilter: ColorFilter.mode(colors.secondary, BlendMode.srcIn),
            ),
            8.width,
            Text(
              "سبد خرید",
              style: textTheme.headlineSmall?.copyWith(color: colors.secondary),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: LoadingAnimationWidget.halfTriangleDot(
                  color: colors.primary,
                  size: 0.06.sh,
                ),
              ),
            );
          }

          if (state is CartFailed) {
            return Center(
              child: Text(
                "خطا در بارگذاری سبد خرید:\n${state.failure.message}",
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is CartEmpty) {
            return EmptyCart();
          }
          final cartItems = context.read<CartBloc>().items;
          if (cartItems.isEmpty || cartItems.first.items.isEmpty) {
            return EmptyCart();
          }
          final cart = cartItems.first;
          final items = cart.items;

          if (state is CartSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final cartItem = items[index];
                      final product = cartItem.product;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Container(
                          height: 0.24.sh,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: colors.surface,
                            boxShadow: [
                              BoxShadow(
                                color: colors.shadow.withValues(alpha: .08),
                                offset: const Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NetWorkImage(
                                  image: product.mainImage,
                                  width: 0.34.sw,
                                  height: double.infinity,
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
                                        product.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.titleLarge?.copyWith(
                                          color: colors.secondary,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.svg.discount,
                                            colorFilter: ColorFilter.mode(
                                              colors.error,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          6.width,
                                          Text(
                                            "${(product.price - product.finalPrice).comma} تومان تخفیف"
                                                .toPersianNumber(),
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                  color: colors.error,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${product.finalPrice.comma} تومان"
                                            .toPersianNumber(),
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
                                            onPressed: () {
                                              context
                                                  .read<CartBloc>()
                                                  .updateItem(
                                                    cartItem.id,
                                                    cartItem.quantity + 1,
                                                  );
                                            },
                                            icon: SvgPicture.asset(
                                              Assets.svg.addCircle,
                                            ),
                                          ),
                                          Text(
                                            "${cartItem.quantity} عدد"
                                                .toPersianNumber(),
                                            style: textTheme.bodyLarge,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              context
                                                  .read<CartBloc>()
                                                  .updateItem(
                                                    cartItem.id,
                                                    cartItem.quantity - 1,
                                                  );
                                            },
                                            icon: SvgPicture.asset(
                                              Assets.svg.minusCirlce,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              context
                                                  .read<CartBloc>()
                                                  .deleteItem(cartItem.id);
                                              ShowToast().show(
                                                "محصول از سبد خرید حذف شد",
                                                context,
                                              );
                                            },
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
                  height: 0.12.sh,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  color: colors.surface,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton(title: "ادامه فرآیند خرید", onPressed: () {}),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "جمع سبد خرید",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colors.onSurface.withValues(alpha: .7),
                            ),
                          ),
                          4.height,
                          Text(
                            "${cart.totalPrice.comma} تومان".toPersianNumber(),
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
            );
          } else {
            return const EmptyCart();
          }
        },
      ),
    );
  }
}
