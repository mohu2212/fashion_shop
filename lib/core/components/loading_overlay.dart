import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:fashion_shop/core/resources/image_assets.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (_) => Container(
        color: Colors.white,
        child: Center(
          child: Lottie.asset(
            ImageAssets.loading,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
