import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/feature/home/presentation/bloc/home_bloc.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../../../cats/presentation/bloc/cats_bloc.dart';
import '../screens/amazing_product_list_screen.dart';

class HomeScreenCats extends StatelessWidget {
  const HomeScreenCats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final bloc = context.read<HomeBloc>();
        final items = bloc.cats;
        if (items.isEmpty || state is HomeCatsLoading) {
          return HomeCatsShimmer();
        }
        return SizedBox(
          height: 0.14.sh,
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // context.read<CatsBloc>().cats.clear();
                  context.read<CatsBloc>().getCatsData(items[index].id);
                  context.navigateWNavBar(
                    AmazingProductListScreen(
                      cats: context.read<CatsBloc>().cats,
                    ),
                  );
                },
                child: FadeInLeft(
                  delay: Duration(milliseconds: index * 50),
                  duration: Duration(milliseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: NetWorkImage(
                            image: items[index].icon,
                            height: 72.r,
                            width: 72.r,
                          ),
                        ),
                        6.height,
                        SizedBox(
                          width: 72.r,
                          child: Text(
                            items[index].title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
