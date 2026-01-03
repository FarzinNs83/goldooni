import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/feature/cats/presentation/bloc/cats_bloc.dart';
import 'package:goldooni/feature/home/presentation/screens/amazing_product_list_screen.dart';
import 'package:goldooni/feature/home/presentation/widgets/app_search_bar.dart';

import '../../../home/presentation/bloc/home_bloc.dart';

class CatsScreen extends StatelessWidget {
  const CatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final safeTop = MediaQuery.paddingOf(context).top;
    final colors = context.theme.colorScheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: safeTop + 16.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              AppSearchBar(),
              8.height,
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    final items = context.read<HomeBloc>().cats;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.read<CatsBloc>().cats.clear();
                            context.read<CatsBloc>().getCatsData(
                              items[index].id,
                            );
                            context.navigateWNavBar(
                              AmazingProductListScreen(
                                cats: context.read<CatsBloc>().cats,
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      items[index].title,
                                      style: context.textTheme.bodyLarge,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_left,
                                      color: colors.onSurface,
                                    ),
                                  ],
                                ),
                                8.height,
                                Visibility(
                                  visible: index == items.length - 1
                                      ? false
                                      : true,
                                  child: Divider(color: colors.outlineVariant),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
