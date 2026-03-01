import 'package:fashion_shop/modules/home_module/data/model/category_model.dart';
import 'package:fashion_shop/modules/home_module/domain/entity/product_entity.dart';

class ProductModel {
  final int id;
  final String title;
  final String slug;
  final double price;
  final String description;
  final CategoryModel category;
  final List<String> images;

  const ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  static List<String> _cleanImages(List images) {
    final cleaned = <String>[];
    for (final img in images) {
      final str = img.toString().replaceAll(RegExp(r'[\[\]"]'), '').trim();
      for (final url in str.split(',')) {
        final trimmed = url.trim();
        if (trimmed.startsWith('http')) {
          cleaned.add(trimmed);
        }
      }
    }
    return cleaned;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: CategoryModel.fromJson(json['category']),
      images: _cleanImages(json['images'] as List),
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      slug: slug,
      price: price,
      description: description,
      category: category.toEntity(),
      images: images,
    );
  }
}
