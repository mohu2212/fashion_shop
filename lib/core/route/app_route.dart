import 'package:flutter/material.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/route/route_const.dart';
import 'package:fashion_shop/modules/auth_module/presentation/screens/splash/splash_screen.dart';
import 'package:fashion_shop/modules/auth_module/presentation/screens/login/login_screen.dart';
import 'package:fashion_shop/modules/auth_module/presentation/screens/otp/otp_screen.dart';
import 'package:fashion_shop/modules/home_module/domain/entity/product_entity.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/main_navigation/main_navigation_screen.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/product_details/product_details_screen.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/terms/terms_screen.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/view_all/view_all_screen.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConst.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteConst.login:
        return _fadeRoute(const LoginScreen(), settings);
      case RouteConst.otp:
        return _slideRoute(const OtpScreen(), settings);
      case RouteConst.home:
        return _fadeRoute(MainNavigationScreen(), settings);
      case RouteConst.productDetails:
        final product = settings.arguments as ProductEntity;
        return _slideRoute(
          ProductDetailsScreen(product: product),
          settings,
        );
      case RouteConst.terms:
        return _slideRoute(const TermsScreen(), settings);
      case RouteConst.viewAll:
        final products = settings.arguments as List<ProductEntity>;
        return _slideRoute(
          ViewAllScreen(products: products),
          settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(AppStrings.pageNotFound),
            ),
          ),
        );
    }
  }

  static Route<dynamic> _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Route<dynamic> _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ));
        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
