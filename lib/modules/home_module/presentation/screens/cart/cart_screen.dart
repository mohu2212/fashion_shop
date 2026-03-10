import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fashion_shop/core/components/app_button.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/resources/color_manager.dart';
import 'package:fashion_shop/core/resources/image_assets.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';
import 'package:fashion_shop/core/resources/style_manager.dart';
import 'package:fashion_shop/modules/home_module/domain/entity/cart_item_entity.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_bloc.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_event.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: ColorManager.hint,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.cartEmpty,
                      style: getBukraBold(
                        fontSize: FontSize.s16,
                        color: ColorManager.darkText,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Cart (${state.totalItems})',
                    style: getBukraBold(
                      fontSize: FontSize.s18,
                      color: ColorManager.darkText,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: state.items.length,
                    separatorBuilder: (_, _) =>
                        const Divider(color: ColorManager.border, height: 24),
                    itemBuilder: (context, index) {
                      return _CartItemWidget(item: state.items[index]);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: ColorManager.border, width: 0.5),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.total,
                            style: getBukraBold(
                              fontSize: FontSize.s16,
                              color: ColorManager.darkText,
                            ),
                          ),
                          Text(
                            '\$${state.totalPrice.toStringAsFixed(0)}',
                            style: getBukraBold(
                              fontSize: FontSize.s18,
                              color: ColorManager.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppButton(text: AppStrings.checkout, onPressed: () {}),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CartItemWidget extends StatelessWidget {
  final CartItemEntity item;

  const _CartItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: item.product.images.isNotEmpty
                ? item.product.images.first
                : '',
            width: 90,
            height: 90,
            fit: BoxFit.cover,
            errorWidget: (_, _, _) =>
                SvgPicture.asset(ImageAssets.error, width: 30),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.title,
                style: getBukraBold(
                  fontSize: FontSize.s14,
                  color: ColorManager.darkText,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '\$${item.product.price.toStringAsFixed(0)}',
                style: getBukraBold(
                  fontSize: FontSize.s14,
                  color: ColorManager.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _QuantityButton(
                    icon: Icons.remove,
                    onTap: () {
                      context.read<CartBloc>().add(CartUpdateQuantity(
                        productId: item.product.id,
                        quantity: item.quantity - 1,
                      ));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '${item.quantity}',
                      style: getBukraBold(
                        fontSize: FontSize.s14,
                        color: ColorManager.darkText,
                      ),
                    ),
                  ),
                  _QuantityButton(
                    icon: Icons.add,
                    onTap: () {
                      context.read<CartBloc>().add(CartUpdateQuantity(
                        productId: item.product.id,
                        quantity: item.quantity + 1,
                      ));
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.read<CartBloc>().add(CartRemoveItem(item.product.id));
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      size: 22,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 18, color: ColorManager.darkText),
      ),
    );
  }
}
