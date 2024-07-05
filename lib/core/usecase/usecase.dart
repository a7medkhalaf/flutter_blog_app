import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
