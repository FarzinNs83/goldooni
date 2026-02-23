import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_ext.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entities/blog_entity.dart';
import '../bloc/blog_bloc.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({super.key, required this.id});

  final int id;

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  void initState() {
    context.read<BlogDetailBloc>().getBlogDetails(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.surface,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
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
      body: BlocBuilder<BlogDetailBloc, BlogDetailState>(
        builder: (context, state) {
          if (state is BlogDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BlogDetailFailed) {
            return Center(
              child: Text(
                state.failure.message,
                style: context.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is BlogDetailLoaded) {
            final BlogDetailEntity blog = state.blog;

            return ListView(
              padding: EdgeInsets.all(16.r),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: NetWorkImage(
                    image: blog.image,
                    height: 220.h,
                    width: double.infinity,
                  ),
                ),
                16.height,

                Text(
                  blog.title,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                ),
                10.height,

                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 18.r,
                      color: context.colors.secondary,
                    ),
                    6.width,
                    Expanded(
                      child: Text(
                        blog.author,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.secondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                16.height,

                Row(
                  children: [
                    _RateChip(
                      icon: Icons.thumb_up_alt_outlined,
                      label: blog.like.toString(),
                    ),
                    10.width,
                    _RateChip(
                      icon: Icons.thumb_down_alt_outlined,
                      label: blog.dislike.toString(),
                    ),
                  ],
                ),
                20.height,

                Text(
                  blog.body,
                  style: context.textTheme.bodyLarge?.copyWith(
                    height: 1.8,
                    color: context.colors.onSurface,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _RateChip extends StatelessWidget {
  const _RateChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: context.colors.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.r, color: context.colors.secondary),
          6.width,
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
