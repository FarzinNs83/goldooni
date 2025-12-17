import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/widgets/network_image.dart';
import 'package:goldooni/feature/home/domain/entities/new_products_entity.dart';
import 'package:goldooni/feature/home/domain/entities/top_products_entity.dart';
import 'package:goldooni/feature/singleproduct/presentation/screens/single_product_screen.dart';

import '../../../../core/utils/app_ext.dart';
import '../../../../gen/assets.gen.dart';
import '../bloc/home_bloc.dart';

class ProductsListScreen extends StatefulWidget {
  final List <NewProductsEntity>? newProducts;
  final List <TopProductsEntity>? topProducts;
  const ProductsListScreen(this.newProducts, this.topProducts, {super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<HomeBloc>();
    scrollController = ScrollController()
      ..addListener(() {
        if (!context.read<HomeBloc>().isLoadingMore &&
            scrollController.position.pixels >=
                scrollController.position.maxScrollExtent - 200) {
          if (bloc.isNew) {
            bloc.getMoreNewProducts();
          } else if (bloc.isTop) {
            bloc.getMoreTopProducts();
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final List items = widget.newProducts ?? widget.topProducts ?? [];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: BackButton(color: context.colors.primary),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Assets.svg.logoMini,
                  height: 28.r,
                  width: 28.r,
                  colorFilter: ColorFilter.mode(
                    context.colors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                8.width,
                Text(
                  "محصولات",
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: context.colors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),

      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return ListView.builder(
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index == items.length) {
                if (state is HomeNewLoading || state is HomeTopLoading) {
                  return Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return SizedBox.shrink();
              }

              final product = items[index];

              return GestureDetector(
                onTap: () =>
                    context.navigate(SingleProductScreen(id: product.id)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: NetWorkImage(
                            image: product.image,
                            height: 120.h,
                            width: 120.w,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: context.textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                12.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "4.6".toPersianNumber(),
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: context.colors.onSurface,
                                          ),
                                    ),
                                    4.width,
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16.r,
                                    ),
                                  ],
                                ),
                                6.height,
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Container(
                                //       padding: EdgeInsets.symmetric(
                                //         horizontal: 8.w,
                                //         vertical: 2.h,
                                //       ),
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(
                                //           16.r,
                                //         ),
                                //         color: context.colors.error.withValues(
                                //           alpha: .85,
                                //         ),
                                //       ),
                                //       child: Text(
                                //         "${product.discount}%"
                                //             .toPersianNumber(),
                                //         style: context.textTheme.labelMedium
                                //             ?.copyWith(
                                //               color: context.colors.onError,
                                //             ),
                                //       ),
                                //     ),
                                    
                                //   ],
                                // ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                        "${(product.price as num).comma } تومان"
                                            .toPersianNumber(),
                                        style: context.textTheme.titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: context.colors.onSurface,
                                            ),
                                      ),
                                ),
                                // Align(
                                //   alignment: Alignment.centerLeft,
                                //   child: Text(
                                //     "${product.price.comma} تومان"
                                //         .toPersianNumber(),
                                //     style: context.textTheme.bodySmall
                                //         ?.copyWith(
                                //           decoration:
                                //               TextDecoration.lineThrough,
                                //           color: context.colors.outline,
                                //         ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
