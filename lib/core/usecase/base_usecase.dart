import 'package:dartz/dartz.dart';
import 'package:fashion_shop/core/error/failure.dart';

abstract class BaseUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
