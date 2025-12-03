import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/widgets/horizontal_divider.dart';
import '../../../../gen/assets.gen.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/profile_items.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final textTheme = context.textTheme;
    final profileItems = [
      {"title": "مورد‌علاقه من", "icon": Assets.svg.mynauiHeart},
      {"title": "آدرس‌ها", "icon": Assets.svg.iconsaxLocation},
      {"title": "پیام‌ها", "icon": Assets.svg.iconamoonNotificationLight},
      {"title": "اطلاعات حساب کاربری", "icon": Assets.svg.user1},
      {"title": "پرسش‌های متداول", "icon": Assets.svg.messageQuestion},
      {"title": "حریم خصوصی", "icon": Assets.svg.lock},
      {"title": "شرایط استفاده", "icon": Assets.svg.cilListRich},
      {"title": "تماس با ما", "icon": Assets.svg.callCalling},
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colors.surface,
        elevation: 0,
        title: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.svg.logoMini,
              height: 40.r,
              colorFilter: ColorFilter.mode(colors.secondary, BlendMode.srcIn),
            ),
            Text(
              "گُل‌دونــــی",
              style: textTheme.headlineSmall?.copyWith(color: colors.secondary),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return LoadingAnimationWidget.flickr(
                      leftDotColor: context.colors.primary,
                      rightDotColor: context.colors.secondary,
                      size: 42.sh,
                    );
                  }
                  if (state is ProfileSuccess) {
                    final item = context.read<ProfileBloc>().profile.first;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.fullName,
                              style: textTheme.titleLarge?.copyWith(
                                color: colors.secondary,
                              ),
                            ),
                            Text(
                              item.phoneNumber.toPersianNumber(),
                              style: textTheme.bodyMedium?.copyWith(
                                color: colors.onSurface.withValues(alpha: .7),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            Assets.svg.edit,
                            height: 32.r,
                            width: 32.r,
                            colorFilter: ColorFilter.mode(
                              colors.secondary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              32.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "سفارش‌های من",
                    style: textTheme.titleLarge?.copyWith(
                      color: colors.secondary,
                    ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: colors.secondary,
                      size: 24.r,
                    ),
                    iconAlignment: IconAlignment.end,
                    onPressed: () {},
                    label: Text(
                      'مشاهده همه',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              32.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    Assets.svg.statusProcessing,
                    height: 0.1.sh,
                    width: 0.1.sw,
                  ),
                  SizedBox(
                    height: 0.12.sh,
                    child: VerticalDivider(color: colors.outlineVariant),
                  ),
                  SvgPicture.asset(
                    Assets.svg.statusDelivered,
                    height: 0.1.sh,
                    width: 0.1.sw,
                  ),
                  SizedBox(
                    height: 0.12.sh,
                    child: VerticalDivider(color: colors.outlineVariant),
                  ),
                  SvgPicture.asset(
                    Assets.svg.statusReturned,
                    height: 0.1.sh,
                    width: 0.1.sw,
                  ),
                ],
              ),
              32.height,
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Icon(
                        color: colors.primary,
                        context.watch<ProfileBloc>().state.isDark
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                      ),
                      8.width,
                      Text(
                        "تم برنامه",
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: colors.onSurface,
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: context.watch<ProfileBloc>().state.isDark,
                        onChanged: (value) {
                          context.read<ProfileBloc>().toggleTheme();
                        },
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: HorizDivider(),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: profileItems.length,
                separatorBuilder: (_, _) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: HorizDivider(),
                ),
                itemBuilder: (context, i) => ProfileItems(
                  title: profileItems[i]["title"]!,
                  icon: profileItems[i]["icon"]!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
