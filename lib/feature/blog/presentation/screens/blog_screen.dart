import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/widgets/network_image.dart';
import 'package:goldooni/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:goldooni/feature/blog_single/presentation/screens/blog_detail_screen.dart';

import '../../../../core/utils/app_ext.dart';
import '../../../../gen/assets.gen.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.colors.surface,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.svg.logoMini,
              height: 40.r,
              colorFilter: ColorFilter.mode(
                context.colors.secondary,
                BlendMode.srcIn,
              ),
            ),
            8.width,
            Text(
              "بلاگدونی",
              style: context.textTheme.headlineSmall?.copyWith(
                color: context.colors.secondary,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is BlogLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.blog.length,
                    itemBuilder: (context, index) {
                      final blog = state.blog[index];
                      return GestureDetector(
                        onTap: () => context.navigate(
                          BlogDetailScreen(id: state.blog[index].id),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 8.h,
                          ),
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
                                    image: blog.image,
                                    height: 100.h,
                                    width: 100.w,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          blog.title,
                                          style: context.textTheme.titleMedium,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        12.height,
                                        Text(
                                          blog.author,
                                          style: context.textTheme.titleSmall,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
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
                    },
                  ),
                ),
              ],
            );
          }
          if (state is BlogFailed) {
            return Center(child: Text(state.failure.message));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
