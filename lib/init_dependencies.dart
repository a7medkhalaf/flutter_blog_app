import 'package:flutter_blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_blog_app/core/secrets/app_secrets.dart';
import 'package:flutter_blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_blog_app/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_blog_app/features/auth/domain/repository/usecases/current_user.dart';
import 'package:flutter_blog_app/features/auth/domain/repository/usecases/user_login.dart';
import 'package:flutter_blog_app/features/auth/domain/repository/usecases/user_singup.dart';
import 'package:flutter_blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<IAuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        serviceLocator(),
      ),
    )
    ..registerFactory<IAuthRepository>(
      () => AuthRepository(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
