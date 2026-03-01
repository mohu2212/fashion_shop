import 'package:fashion_shop/modules/home_module/domain/entity/product_entity.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState {
  final HomeStatus status;
  final List<ProductEntity> products;
  final String? error;

  const HomeState({
    this.status = HomeStatus.initial,
    this.products = const [],
    this.error,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<ProductEntity>? products,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: error,
    );
  }
}
