import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fashion_shop/core/components/tap_scale.dart';
import 'package:fashion_shop/core/data/local/app_data.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/resources/image_assets.dart';
import 'package:fashion_shop/core/resources/color_manager.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';
import 'package:fashion_shop/core/resources/style_manager.dart';
import 'package:fashion_shop/core/route/route_const.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_bloc.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_event.dart';

const _kCardShadow = Color(0xFFD1D8D7);

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray2,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  children: [
                    _buildRow([
                      _buildCard(icon: ImageAssets.wallet, label: AppStrings.wallet, onTap: () {}),
                      _buildCard(icon: ImageAssets.favorites, label: AppStrings.favorites, onTap: () {}),
                    ]),
                    const SizedBox(height: 16),
                    _buildRow([
                      _buildCard(icon: ImageAssets.settings, label: AppStrings.generalSettings, onTap: () {}),
                      _buildCard(icon: ImageAssets.addresses, label: AppStrings.savedAddresses, onTap: () {}),
                    ]),
                    const SizedBox(height: 16),
                    _buildRow([
                      _buildCard(icon: ImageAssets.contact, label: AppStrings.contactUs, onTap: () {}),
                      _buildCard(icon: ImageAssets.complaints, label: AppStrings.complaints, onTap: () {}),
                    ]),
                    const SizedBox(height: 16),
                    _buildRow([
                      _buildCard(icon: ImageAssets.store, label: AppStrings.registerAsStore, onTap: () {}),
                      _buildCard(icon: ImageAssets.delivery, label: AppStrings.registerAsDelivery, onTap: () {}),
                    ]),
                    const SizedBox(height: 20),
                    _buildTermsRow(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: Text(
                    AppStrings.logoutConfirmTitle,
                    style: getBukraBold(fontSize: FontSize.s16, color: ColorManager.darkText),
                  ),
                  content: Text(
                    AppStrings.logoutConfirmMessage,
                    style: getKaffRegular(fontSize: FontSize.s14, color: ColorManager.hint),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text(
                        AppStrings.cancel,
                        style: getBukraBold(fontSize: FontSize.s14, color: ColorManager.hint),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        context.read<CartBloc>().add(CartClear());
                        AppData.logout();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteConst.login,
                          (route) => false,
                        );
                      },
                      child: Text(
                        AppStrings.logout,
                        style: getBukraBold(fontSize: FontSize.s14, color: ColorManager.alert),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.logout,
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(ColorManager.alert, BlendMode.srcIn),
                ),
                const SizedBox(width: 4),
                Text(
                  AppStrings.logout,
                  style: getBukraBold(fontSize: FontSize.s12, color: ColorManager.alert),
                ),
              ],
            ),
          ),
          Text(
            AppStrings.more,
            style: getBukraBold(fontSize: FontSize.s16, color: ColorManager.darkText),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<Widget> children) {
    return Row(
      children: [
        children[0],
        const SizedBox(width: 16),
        children[1],
      ],
    );
  }

  Widget _buildCard({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: TapScale(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _kCardShadow.withValues(alpha: 0.25),
                blurRadius: 20,
                offset: const Offset(5, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                icon,
                width: 40,
                height: 40,
                colorFilter: const ColorFilter.mode(ColorManager.secondary, BlendMode.srcIn),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: getBukraBold(
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

  Widget _buildTermsRow(BuildContext context) {
    return TapScale(
      onTap: () => Navigator.pushNamed(context, RouteConst.terms),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: _kCardShadow.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(5, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.termsAndConditions,
              style: getBukraRegular(
                fontSize: FontSize.s12,
                color: ColorManager.darkText,
              ),
            ),
            Transform.flip(
              flipX: true,
              child: SvgPicture.asset(
                ImageAssets.arrowLeft,
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
