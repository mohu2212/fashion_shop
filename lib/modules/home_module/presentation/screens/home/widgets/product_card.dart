import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fashion_shop/core/components/cart_alert.dart';
import 'package:fashion_shop/core/components/login_alert.dart';
import 'package:fashion_shop/core/data/local/app_data.dart';
import 'package:fashion_shop/core/resources/color_manager.dart';
import 'package:fashion_shop/core/resources/image_assets.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';
import 'package:fashion_shop/core/resources/style_manager.dart';
import 'package:fashion_shop/modules/home_module/domain/entity/product_entity.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_bloc.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_event.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/main_navigation/main_navigation_screen.dart';

class ProductCard extends StatefulWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ProductEntity get product => widget.product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorManager.border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.images.isNotEmpty
                          ? product.images.first
                          : '',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: SvgPicture.asset(
                          ImageAssets.error,
                          width: 40,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(6),
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
                          size: 18,
                          color: ColorManager.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: getBukraBold(
                      fontSize: FontSize.s12,
                      color: ColorManager.darkText,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(0)}',
                              style: getBukraBold(
                                fontSize: FontSize.s14,
                                color: ColorManager.secondary,
                              ),
                            ),
                            if (product.id % 3 == 0)
                              Text(
                                '\$${(product.price * 1.3).toStringAsFixed(0)}',
                                style:
                                    getBukraRegular(
                                      fontSize: FontSize.s12,
                                      color: ColorManager.hint,
                                    ).copyWith(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!AppData.isLoggedIn) {
                            LoginAlert.show(context);
                            return;
                          }
                          context.read<CartBloc>().add(CartAddItem(product));
                          CartAlert.show(
                            context,
                            onGoToCart: () {
                              Navigator.popUntil(context, (route) => route.isFirst);
                              MainNavigationScreen.navigationKey.currentState?.switchTab(1);
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorManager.secondary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      ...List.generate(5, (i) {
                        final rating = (product.id % 5) + 1;
                        return Icon(
                          i < rating ? Icons.star : Icons.star_border,
                          size: 14,
                          color: Colors.amber,
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
