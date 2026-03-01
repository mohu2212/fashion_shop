import 'package:fashion_shop/core/data/remote/dio_helper.dart';
import 'package:fashion_shop/core/error/exceptions.dart';
import 'package:fashion_shop/core/network/api_constance.dart';
import 'package:fashion_shop/modules/home_module/data/model/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await DioHelper.getData(url: ApiConstance.products);
      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
