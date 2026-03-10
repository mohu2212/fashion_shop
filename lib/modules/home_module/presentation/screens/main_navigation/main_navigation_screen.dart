import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/resources/color_manager.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';
import 'package:fashion_shop/core/resources/image_assets.dart';
import 'package:fashion_shop/core/resources/style_manager.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_bloc.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_state.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/home/home_screen.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/cart/cart_screen.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/orders/orders_screen.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/more/more_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static final navigationKey = GlobalKey<MainNavigationScreenState>();

  MainNavigationScreen({Key? key}) : super(key: key ?? navigationKey);

  @override
  State<MainNavigationScreen> createState() => MainNavigationScreenState();
}

class MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void switchTab(int index) {
    setState(() => _currentIndex = index);
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    CartScreen(),
    OrdersScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: KeyedSubtree(
          key: ValueKey(_currentIndex),
          child: _screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          return Container(
            color: ColorManager.white,
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: 76,
                child: Row(
                  children: [
                    _buildNavItem(index: 0, iconPath: ImageAssets.navHome, label: AppStrings.home),
                    _buildNavItem(index: 1, iconPath: ImageAssets.navCart, label: AppStrings.cart, badge: cartState.totalItems),
                    _buildNavItem(index: 2, iconPath: ImageAssets.navOrders, label: AppStrings.myOrders),
                    _buildNavItem(index: 3, iconPath: ImageAssets.navMore, label: AppStrings.more),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconPath,
    required String label,
    int badge = 0,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? ColorManager.primary : ColorManager.darkText;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top indicator line
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: isSelected ? 48 : 0,
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon with optional badge
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset(
                        iconPath,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                      ),
                      if (badge > 0)
                        Positioned(
                          top: -4,
                          right: -8,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: ColorManager.alert,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                badge > 9 ? '9+' : '$badge',
                                style: const TextStyle(
                                  color: ColorManager.white,
                                  fontSize: 6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: isSelected
                        ? getBukraBold(fontSize: FontSize.s10, color: ColorManager.primary)
                        : getBukraRegular(fontSize: FontSize.s10, color: ColorManager.darkText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
