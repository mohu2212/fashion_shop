import 'package:flutter/material.dart';
import 'package:fashion_shop/core/resources/color_manager.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';
import 'package:fashion_shop/core/resources/style_manager.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.more_horiz,
              size: 80,
              color: ColorManager.hint,
            ),
            const SizedBox(height: 16),
            Text(
              'More',
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
