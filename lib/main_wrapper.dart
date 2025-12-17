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
  final List<GlobalKey<NavigatorState>> navKeys = List.generate(
    5,
    (index) => GlobalKey<NavigatorState>(),
  );

  int index = 0;

  void onPage(int i) => setState(() => index = i);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return DoubleTapToExit(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              _buildOffstageNavigator(0),
              _buildOffstageNavigator(1),
              _buildOffstageNavigator(2),
              _buildOffstageNavigator(3),
              _buildOffstageNavigator(4),
            ],
          ),
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

  Widget _buildOffstageNavigator(int tabIndex) {
    return Offstage(
      offstage: index != tabIndex,
      child: Navigator(
        key: navKeys[tabIndex],
        onGenerateRoute: (RouteSettings settings) {
          Widget page;

          switch (tabIndex) {
            case 0:
              page = HomeScreen();
              break;
            case 1:
              page = CatsScreen();
              break;
            case 2:
              page = CartScreen();
              break;
            case 3:
              page = BlogScreen();
              break;
            case 4:
            default:
              page = ProfileScreen();
          }

          return MaterialPageRoute(builder: (_) => page);
        },
      ),
    );
  }
}
