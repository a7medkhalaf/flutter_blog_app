import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/error/failure.dart';
import 'package:flutter_blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_blog_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource authRemoteDataSource;
  const AuthRepository(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) return left(const Failure('User not logged in!'));
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signupWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }
}

Future<Either<Failure, User>> _getUser(
  Future<User> Function() fn,
) async {
  try {
    final user = await fn();
    return right(user);
  } on ServerException catch (e) {
    return left(Failure(e.message));
  }
}