import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/widgets/show_toast.dart';
import 'package:goldooni/export_pkg.dart';
import 'package:goldooni/feature/home/presentation/widgets/app_search_bar.dart';
import 'package:goldooni/feature/home/presentation/widgets/auth_icon_button.dart';
import 'package:goldooni/feature/home/presentation/widgets/image_slider.dart';
import 'package:goldooni/feature/home/presentation/widgets/products_card.dart';
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
      context.read<HomeBloc>().getCats();
      context.read<HomeBloc>().getAmazProducts();
      context.read<HomeBloc>().getNewProducts();
      context.read<HomeBloc>().getTopProducts();
      context.read<HomeBloc>().getSlider();
      context.read<HomeBloc>().startTimer();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final safeTop = MediaQuery.paddingOf(context).top;
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 30.w),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () => ShowToast().show(
                "برای پشتیبانی با شماره 09123456789 تماس بگیرید", context),
            backgroundColor: context.colors.primary,
            shape: CircleBorder(),
            child: Icon(Icons.support_agent, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: safeTop + 16.h),
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child:AppSearchBar(),
                ),
                16.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ImageSlider(),
                ),
                16.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: HomeScreenCats(),
                ),
                8.height,
                DiscountOfferCard(),
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
