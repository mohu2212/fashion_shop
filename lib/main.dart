import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion_shop/core/data/local/cache_helper.dart';
import 'package:fashion_shop/core/data/remote/dio_helper.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/resources/theme_manager.dart';
import 'package:fashion_shop/core/route/app_route.dart';
import 'package:fashion_shop/core/services/services_locator.dart';
import 'package:fashion_shop/modules/auth_module/presentation/screens/splash/splash_screen.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CartBloc>(),
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: getAppTheme(),
        onGenerateRoute: AppRoute.generateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
