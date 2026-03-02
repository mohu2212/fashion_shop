import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion_shop/core/components/tap_scale.dart';
import 'package:fashion_shop/core/data/local/app_data.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/resources/color_manager.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';
import 'package:fashion_shop/core/resources/style_manager.dart';
import 'package:fashion_shop/core/route/route_const.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_cubit.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Text(
                            AppStrings.logoutConfirmTitle,
                            style: getBukraBold(
                              fontSize: FontSize.s16,
                              color: ColorManager.darkText,
                            ),
                          ),
                          content: Text(
                            AppStrings.logoutConfirmMessage,
                            style: getKaffRegular(
                              fontSize: FontSize.s14,
                              color: ColorManager.hint,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: Text(
                                AppStrings.cancel,
                                style: getBukraBold(
                                  fontSize: FontSize.s14,
                                  color: ColorManager.hint,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                context.read<CartCubit>().clearCart();
                                AppData.logout();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteConst.login,
                                  (route) => false,
                                );
                              },
                              child: Text(
                                AppStrings.logout,
                                style: getBukraBold(
                                  fontSize: FontSize.s14,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          size: 18,
                          color: ColorManager.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          AppStrings.logout,
                          style: getBukraBold(
                            fontSize: FontSize.s12,
                            color: ColorManager.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    AppStrings.more,
                    style: getBukraBold(
                      fontSize: FontSize.s16,
                      color: ColorManager.darkText,
                    ),
                  ),
                ],
              ),
            ),

            // Grid options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildOptionCard(
                          icon: Icons.favorite_outlined,
                          label: AppStrings.favorites,
                          color: ColorManager.secondary,
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        _buildOptionCard(
                          icon: Icons.account_balance_wallet_outlined,
                          label: AppStrings.wallet,
                          color: ColorManager.secondary,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildOptionCard(
                          icon: Icons.location_on_outlined,
                          label: AppStrings.savedAddresses,
                          color: ColorManager.secondary,
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        _buildOptionCard(
                          icon: Icons.settings_outlined,
                          label: AppStrings.generalSettings,
                          color: ColorManager.secondary,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildOptionCard(
                          icon: Icons.phone_outlined,
                          label: AppStrings.contactUs,
                          color: ColorManager.secondary,
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        _buildOptionCard(
                          icon: Icons.feedback_outlined,
                          label: AppStrings.complaints,
                          color: ColorManager.secondary,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildOptionCard(
                          icon: Icons.store_outlined,
                          label: AppStrings.registerAsStore,
                          color: ColorManager.secondary,
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        _buildOptionCard(
                          icon: Icons.delivery_dining_outlined,
                          label: AppStrings.registerAsDelivery,
                          color: ColorManager.secondary,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Terms & Conditions
                    TapScale(
                      onTap: () {
                        Navigator.pushNamed(context, RouteConst.terms);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManager.border, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.termsAndConditions,
                              style: getKaffRegular(
                                fontSize: FontSize.s14,
                                color: ColorManager.darkText,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: ColorManager.hint,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: TapScale(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.border, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 24, color: color),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: getKaffRegular(
                  fontSize: FontSize.s12,
                  color: ColorManager.darkText,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
