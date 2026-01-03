import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/widgets/network_image.dart';
import 'package:goldooni/feature/blog/presentation/bloc/blog_bloc.dart';

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

                      return ListTile(
                        leading: NetWorkImage(
                          image: blog.image,
                          height: 120.h,
                          width: 120.w,
                        ),
                        title: Text(
                          blog.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        subtitle: Text(
                          "فرزین نصیری",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('👍 ${blog.like}'),
                            Text('👎 ${blog.dislike}'),
                          ],
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
