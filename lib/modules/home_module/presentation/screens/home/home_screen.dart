import 'dart:async';

import 'package:fashion_shop/core/route/route_const.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/resources/color_manager.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';
import 'package:fashion_shop/core/resources/image_assets.dart';
import 'package:fashion_shop/core/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion_shop/core/services/services_locator.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/home/home_bloc.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/home/home_event.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/home/home_state.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/home/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(HomeGetProducts()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage % 5,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildIconButton({
    required IconData icon,
    bool hasBadge = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40D1D8D7),
              offset: Offset(5, 10),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 20, color: ColorManager.darkText),
            if (hasBadge)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.welcome,
                    style: getBukraBold(
                      fontSize: FontSize.s16,
                      color: ColorManager.primary,
                    ),
                  ),
                  Row(
                    children: [
                      _buildIconButton(
                        icon: Icons.search,
                        onTap: () {},
                      ),
                      const SizedBox(width: 12),
                      _buildIconButton(
                        icon: Icons.notifications_outlined,
                        hasBadge: true,
                        onTap: () {},
                      ),


                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => _currentPage = index,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        ImageAssets.ads, // index % 5 for different ads
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.newArrivals,
                    style: getBukraBold(
                      fontSize: FontSize.s14,
                      color: ColorManager.darkText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final products = context.read<HomeBloc>().state.products;
                      Navigator.pushNamed(
                        context,
                        RouteConst.viewAll,
                        arguments: products,
                      );
                    },
                    child: Text(
                      AppStrings.viewAll,
                      style: getKaffRegular(
                        fontSize: FontSize.s14,
                        color: ColorManager.hint,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  switch (state.status) {
                    case HomeStatus.initial:
                    case HomeStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                    case HomeStatus.error:
                      return Center(
                        child: SvgPicture.asset(
                          ImageAssets.error,
                          width: 200,
                        ),
                      );
                    case HomeStatus.loaded:
                      final displayProducts = state.products.take(6).toList();
                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: displayProducts.length,
                        itemBuilder: (context, index) {
                          return _StaggeredItem(
                            index: index,
                            child: ProductCard(
                              product: displayProducts[index],
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteConst.productDetails,
                                  arguments: displayProducts[index],
                                );
                              },
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StaggeredItem extends StatefulWidget {
  final int index;
  final Widget child;

  const _StaggeredItem({required this.index, required this.child});

  @override
  State<_StaggeredItem> createState() => _StaggeredItemState();
}

class _StaggeredItemState extends State<_StaggeredItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(Duration(milliseconds: 100 * widget.index), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
