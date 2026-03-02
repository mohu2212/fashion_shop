import 'package:flutter/material.dart';
import 'package:fashion_shop/core/components/custom_app_bar.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/route/route_const.dart';
import 'package:fashion_shop/modules/home_module/domain/entity/product_entity.dart';
import 'package:fashion_shop/modules/home_module/presentation/screens/home/widgets/product_card.dart';

class ViewAllScreen extends StatelessWidget {
  final List<ProductEntity> products;

  const ViewAllScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.allProducts),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteConst.productDetails,
                arguments: products[index],
              );
            },
          );
        },
      ),
    );
  }
}
