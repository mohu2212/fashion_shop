import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fashion_shop/core/components/app_button.dart';
import 'package:fashion_shop/core/components/cart_alert.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/components/login_alert.dart';
import 'package:fashion_shop/core/data/local/app_data.dart';
import 'package:fashion_shop/core/resources/color_manager.dart';
import 'package:fashion_shop/core/resources/image_assets.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';
import 'package:fashion_shop/core/resources/style_manager.dart';
import 'package:fashion_shop/modules/home_module/domain/entity/product_entity.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_cubit.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/main_navigation/main_navigation_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  int _currentImageIndex = 0;
  final PageController _imageController = PageController();
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _animController.forward();
    });
  }

  @override
  void dispose() {
    _imageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section with back & favorite
                  Stack(
                    children: [
                      SizedBox(
                        height: 380,
                        child: PageView.builder(
                          controller: _imageController,
                          itemCount: product.images.length,
                          onPageChanged: (index) {
                            setState(() => _currentImageIndex = index);
                          },
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: product.images[index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: SvgPicture.asset(
                                  ImageAssets.error,
                                  width: 60,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Back button
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 8,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x40D1D8D7),
                                  offset: Offset(5, 10),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                              color: ColorManager.darkText,
                            ),
                          ),
                        ),
                      ),
                      // Favorite button
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 8,
                        right: 16,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x40D1D8D7),
                                  offset: Offset(5, 10),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.favorite_border,
                              size: 20,
                              color: ColorManager.secondary,
                            ),
                          ),
                        ),
                      ),
                      // Image indicators
                      if (product.images.length > 1)
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              product.images.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                width: _currentImageIndex == index ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentImageIndex == index
                                      ? ColorManager.primary
                                      : ColorManager.hint.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            product.category.name,
                            style: getBukraMedium(
                              fontSize: FontSize.s12,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Title
                        Text(
                          product.title,
                          style: getBukraBold(
                            fontSize: FontSize.s18,
                            color: ColorManager.darkText,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Stars
                        Row(
                          children: [
                            ...List.generate(5, (i) {
                              final rating = (product.id % 5) + 1;
                              return Icon(
                                i < rating ? Icons.star : Icons.star_border,
                                size: 18,
                                color: Colors.amber,
                              );
                            }),
                            const SizedBox(width: 8),
                            Text(
                              '(${(product.id % 50) + 10})',
                              style: getKaffRegular(
                                fontSize: FontSize.s12,
                                color: ColorManager.hint,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Price
                        Row(
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(0)}',
                              style: getBukraBold(
                                fontSize: FontSize.s22,
                                color: ColorManager.secondary,
                              ),
                            ),
                            if (product.id % 3 == 0) ...[
                              const SizedBox(width: 10),
                              Text(
                                '\$${(product.price * 1.3).toStringAsFixed(0)}',
                                style: getBukraRegular(
                                  fontSize: FontSize.s16,
                                  color: ColorManager.hint,
                                ).copyWith(
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Description title
                        Text(
                          AppStrings.description,
                          style: getBukraBold(
                            fontSize: FontSize.s16,
                            color: ColorManager.darkText,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Description
                        Text(
                          product.description,
                          style: getKaffRegular(
                            fontSize: FontSize.s14,
                            color: ColorManager.hint,
                          ),
                        ),
                      ],
                    ),
                  ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add to cart button
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(
                top: BorderSide(color: ColorManager.border, width: 0.5),
              ),
            ),
            child: AppButton(
              text: AppStrings.addToCart,
              onPressed: () {
                if (!AppData.isLoggedIn) {
                  LoginAlert.show(context);
                  return;
                }
                context.read<CartCubit>().addToCart(product);
                CartAlert.show(
                  context,
                  onGoToCart: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    MainNavigationScreen.navigationKey.currentState?.switchTab(1);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
