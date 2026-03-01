import 'package:flutter/material.dart';
import 'package:fashion_shop/core/route/route_const.dart';
import 'package:fashion_shop/modules/auth_module/presentation/screens/splash/splash_screen.dart';
import 'package:fashion_shop/modules/auth_module/presentation/screens/login/login_screen.dart';
import 'package:fashion_shop/modules/auth_module/presentation/screens/otp/otp_screen.dart';
import 'package:fashion_shop/modules/home_module/domain/entity/product_entity.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/main_navigation/main_navigation_screen.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/product_details/product_details_screen.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/view_all/view_all_screen.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConst.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteConst.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteConst.otp:
        return MaterialPageRoute(builder: (_) => const OtpScreen());
      case RouteConst.home:
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
      case RouteConst.productDetails:
        final product = settings.arguments as ProductEntity;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product),
        );
      case RouteConst.viewAll:
        final products = settings.arguments as List<ProductEntity>;
        return MaterialPageRoute(
          builder: (_) => ViewAllScreen(products: products),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
