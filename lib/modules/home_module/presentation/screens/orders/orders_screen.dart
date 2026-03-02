import 'package:flutter/material.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/resources/color_manager.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';
import 'package:fashion_shop/core/resources/style_manager.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.receipt_long_outlined,
              size: 80,
              color: ColorManager.hint,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.noOrdersYet,
              style: getBukraBold(
                fontSize: FontSize.s16,
                color: ColorManager.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
