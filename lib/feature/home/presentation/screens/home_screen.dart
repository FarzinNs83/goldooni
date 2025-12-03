
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/feature/home/presentation/bloc/home_bloc.dart';
import 'package:goldooni/feature/home/presentation/widgets/app_search_bar.dart';
import 'package:goldooni/feature/home/presentation/widgets/auth_icon_button.dart';
import 'package:goldooni/feature/home/presentation/widgets/products_card.dart';
import 'package:goldooni/gen/assets.gen.dart';

import '../widgets/discount_offer_card.dart';
import '../widgets/home_screen_cats.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().getCats(1);
      context.read<HomeBloc>().getAmazProducts(1);
      context.read<HomeBloc>().getNewProducts(1);
      context.read<HomeBloc>().getTopProducts(1);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final safeTop = MediaQuery.paddingOf(context).top;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: safeTop + 16.h),
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 0.07.sh,
                        width: 0.73.sw,
                        child: AppSearchBar(),
                      ),
                      AuthIconButton(),
                    ],
                  ),
                ),
                16.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(Assets.png.golCar.path),
                  ),
                ),
                16.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: HomeScreenCats(),
                ),
                8.height,
                DiscountOfferCard(),
                16.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(Assets.png.golCar.path),
                  ),
                ),
                16.height,
                ProductsCard(
                  title: "محصولات برتر",
                  topProducts: context.read<HomeBloc>().topProducts,
                ),
                16.height,
                ProductsCard(
                  title: "جدیدترین محصولات",
                  newProducts: context.read<HomeBloc>().newProducts,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
