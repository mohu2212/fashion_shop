import 'package:fashion_shop/modules/home_module/domain/entity/category_entity.dart';

class ProductEntity {
  final int id;
  final String title;
  final String slug;
  final double price;
  final String description;
  final CategoryEntity category;
  final List<String> images;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });
}
