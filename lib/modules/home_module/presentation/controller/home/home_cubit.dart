import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion_shop/core/usecase/base_usecase.dart';
import 'package:fashion_shop/modules/home_module/domain/usecase/get_products_usecase.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase getProductsUseCase;

  HomeCubit(this.getProductsUseCase) : super(const HomeState());

  Future<void> getProducts() async {
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await getProductsUseCase(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.error,
        error: failure.message,
      )),
      (products) => emit(state.copyWith(
        status: HomeStatus.loaded,
        products: products,
      )),
    );
  }
}
