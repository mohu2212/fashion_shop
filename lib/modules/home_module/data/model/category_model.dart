import 'package:fashion_shop/modules/home_module/domain/entity/category_entity.dart';

class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String image;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      slug: slug,
      image: image,
    );
  }
}
