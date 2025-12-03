import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/utils/doubl_tap_to_exit.dart';
import 'package:goldooni/feature/blog/presentation/screens/blog_screen.dart';
import 'package:goldooni/feature/cart/presentation/screens/cart_screen.dart';
import 'package:goldooni/feature/cats/presentation/screens/cats_screen.dart';
import 'package:goldooni/feature/home/presentation/screens/home_screen.dart';
import 'package:goldooni/feature/profile/presentation/screens/profile_screen.dart';
import 'core/widgets/nav_item.dart';
import 'gen/assets.gen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final List<Widget> pages = [
    const HomeScreen(),
    const CatsScreen(),
    const CartScreen(),
    const BlogScreen(),
    const ProfileScreen(),
  ];

  int index = 0;

  void onPage(int i) => setState(() => index = i);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return DoubleTapToExit(
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(index: index, children: pages),
        ),
        bottomNavigationBar: AnimatedContainer(
          height: 0.1.sh,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavItem(
                title: "دسته‌بندی",
                icon: Assets.svg.category,
                onTap: () => onPage(1),
                isSelected: index == 1,
              ),
              NavItem(
                title: "سبد‌خرید",
                icon: Assets.svg.shoppingCart,
                onTap: () => onPage(2),
                isSelected: index == 2,
              ),
              NavItem(
                title: "گلُ‌دونی",
                icon: Assets.svg.home,
                onTap: () => onPage(0),
                isSelected: index == 0,
              ),
              NavItem(
                title: "بلاگ‌دونی",
                icon: Assets.svg.edit,
                onTap: () => onPage(3),
                isSelected: index == 3,
              ),
              NavItem(
                title: "حساب‌من",
                icon: Assets.svg.user,
                onTap: () => onPage(4),
                isSelected: index == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
