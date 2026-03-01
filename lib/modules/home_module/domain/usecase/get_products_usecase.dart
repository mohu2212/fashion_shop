import 'package:dartz/dartz.dart';
import 'package:fashion_shop/core/error/failure.dart';
import 'package:fashion_shop/core/usecase/base_usecase.dart';
import 'package:fashion_shop/modules/home_module/domain/entity/product_entity.dart';
import 'package:fashion_shop/modules/home_module/domain/repository/home_repository.dart';

class GetProductsUseCase extends BaseUseCase<List<ProductEntity>, NoParams> {
  final HomeRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
