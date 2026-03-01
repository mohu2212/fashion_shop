import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fashion_shop/core/data/local/app_data.dart';
import 'package:fashion_shop/core/resources/image_assets.dart';
import 'package:fashion_shop/core/route/route_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    await AppData.loadFromStorage();

    if (!mounted) return;

    if (AppData.isLoggedIn) {
      Navigator.pushReplacementNamed(context, RouteConst.home);
    } else {
      Navigator.pushReplacementNamed(context, RouteConst.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Center(
          child: SvgPicture.asset(
            ImageAssets.iconSvg,
            width: 220,
            height: 220,
          ),
        ),
      ),
    );
  }
}
