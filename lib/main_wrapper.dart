import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/utils/user_scroll_tracking.dart';
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
  bool showNavBar = true;
  void onPage(int i) => setState(() => index = i);
  double navBarHeight = 0.1.sh;
  void changeNavBarHeight(double height) {
    setState(() {
      navBarHeight = height;
    });
  }

  void setNavBarVisibility(bool visible) {
    if (showNavBar != visible) {
      setState(() => showNavBar = visible);
    }
  }

  Future<bool> _onWillPop() async {
    final currentNav = navKeys[index].currentState;
    if (currentNav!.canPop()) {
      currentNav.pop();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: UserScrollTracking(
        funcR: () => changeNavBarHeight(0),
        funcF: () => changeNavBarHeight(0.1.sh),
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
          bottomNavigationBar: showNavBar
              ? AnimatedContainer(
                  height: navBarHeight,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  decoration: BoxDecoration(color: colorScheme.secondary),
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
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(int tabIndex) {
    return Offstage(
      offstage: index != tabIndex,
      child: Navigator(
        key: navKeys[tabIndex],
        observers: [
          NavBarVisibilityObserver(onVisibilityChanged: setNavBarVisibility),
        ],
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

class NavBarVisibilityObserver extends NavigatorObserver {
  final Function(bool) onVisibilityChanged;

  NavBarVisibilityObserver({required this.onVisibilityChanged});

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _updateVisibility(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _updateVisibility(previousRoute);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _updateVisibility(newRoute);
    }
  }

  void _updateVisibility(Route route) {
    final settings = route.settings;
    final arguments = settings.arguments;
    bool hideNavBar = false;
    if (arguments is Map) {
      hideNavBar = arguments['hideNavBar'] ?? false;
    }
    onVisibilityChanged(!hideNavBar);
  }
}
