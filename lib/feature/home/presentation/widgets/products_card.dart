import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/feature/home/domain/entities/new_products_entity.dart';
import 'package:goldooni/feature/home/domain/entities/top_products_entity.dart';
import 'package:goldooni/feature/home/presentation/bloc/home_bloc.dart';
import 'package:goldooni/feature/singleproduct/presentation/screens/single_product_screen.dart';
import 'package:goldooni/gen/assets.gen.dart';

class ProductsCard extends StatelessWidget {
  final String title;
  final List<NewProductsEntity>? newProducts;
  final List<TopProductsEntity>? topProducts;
  const ProductsCard({
    super.key,
    required this.title,
    this.newProducts,
    this.topProducts,
  });

  @override
  Widget build(BuildContext context) {
    final List items = newProducts ?? topProducts ?? [];
    final colors = context.theme.colorScheme;
    final textTheme = context.textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      width: double.infinity,
      decoration: BoxDecoration(color: colors.surface),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(Assets.svg.logoMini, height: 36.r, width: 36.r),
              8.width,
              Text(
                title,
                style: textTheme.headlineSmall?.copyWith(
                  color: colors.secondary,
                ),
              ),
              Spacer(),
              TextButton.icon(
                icon: Icon(Icons.keyboard_arrow_left, color: colors.secondary),
                iconAlignment: IconAlignment.end,
                onPressed: () {},
                label: Text(
                  'مشاهده همه',
                  style: textTheme.bodySmall?.copyWith(color: colors.secondary),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 0.35.sh,
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeNewLoading || state is HomeTopLoading) {
                  CircularProgressIndicator();
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return FadeInLeft(
                      delay: Duration(milliseconds: index * 50),
                      duration: Duration(milliseconds: 400),
                      child: GestureDetector(
                        onTap: () => context.navigate(SingleProductScreen(id: items[index].id)),
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Container(
                            width: 0.45.sw,
                            decoration: BoxDecoration(
                              color: colors.surface,
                              border: Border.all(color: colors.outlineVariant),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(0.02.sw),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.network(
                                        items[index].image,
                                        width: 0.8.sw,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  8.height,
                                  Text(
                                    items[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: colors.secondary,
                                    ),
                                  ),
                        
                                  24.height,
                                  Text(
                                    "${(items[index].price as num).comma} تومان".toPersianNumber(),
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
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
