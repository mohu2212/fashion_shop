import 'package:get_it/get_it.dart';
import 'package:fashion_shop/modules/auth_module/presentation/controller/login/login_bloc.dart';
import 'package:fashion_shop/modules/auth_module/presentation/controller/otp/otp_bloc.dart';
import 'package:fashion_shop/modules/home_module/data/datasource/home_remote_datasource.dart';
import 'package:fashion_shop/modules/home_module/data/repository/home_repository_impl.dart';
import 'package:fashion_shop/modules/home_module/domain/repository/home_repository.dart';
import 'package:fashion_shop/modules/home_module/domain/usecase/get_products_usecase.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_bloc.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/home/home_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // Auth
    sl.registerFactory(() => LoginBloc());
    sl.registerFactoryParam<OtpBloc, String, void>(
      (phoneNumber, _) => OtpBloc(phoneNumber: phoneNumber),
    );

    // Home
    sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(),
    );
    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl()),
    );
    sl.registerLazySingleton(() => GetProductsUseCase(sl()));
    sl.registerFactory(() => HomeBloc(sl()));

    // Cart
    sl.registerLazySingleton(() => CartBloc());
  }
}
