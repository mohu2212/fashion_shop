import 'package:get_it/get_it.dart';
import 'package:fashion_shop/modules/auth_module/presentation/controller/login/login_cubit.dart';
import 'package:fashion_shop/modules/auth_module/presentation/controller/otp/otp_cubit.dart';
import 'package:fashion_shop/modules/home_module/data/datasource/home_remote_datasource.dart';
import 'package:fashion_shop/modules/home_module/data/repository/home_repository_impl.dart';
import 'package:fashion_shop/modules/home_module/domain/repository/home_repository.dart';
import 'package:fashion_shop/modules/home_module/domain/usecase/get_products_usecase.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_cubit.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/home/home_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // Auth
    sl.registerFactory(() => LoginCubit());
    sl.registerFactoryParam<OtpCubit, String, void>(
      (phoneNumber, _) => OtpCubit(phoneNumber: phoneNumber),
    );

    // Home
    sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(),
    );
    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl()),
    );
    sl.registerLazySingleton(() => GetProductsUseCase(sl()));
    sl.registerFactory(() => HomeCubit(sl()));

    // Cart
    sl.registerLazySingleton(() => CartCubit());
  }
}
