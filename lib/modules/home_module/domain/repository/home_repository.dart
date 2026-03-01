import 'package:dartz/dartz.dart';
import 'package:fashion_shop/core/error/failure.dart';
import 'package:fashion_shop/modules/home_module/domain/entity/product_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
