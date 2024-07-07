part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  await _initHive();
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton<Box<dynamic>>(() => Hive.box('blogs'));
  serviceLocator.registerFactory(() => InternetConnection());
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  await Hive.openBox('blogs');
}

void _initAuth() {
  serviceLocator
    ..registerFactory<IAuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        serviceLocator(),
      ),
    )
    ..registerFactory<IConnectionChecker>(
      () => ConnectionChecker(
        serviceLocator(),
      ),
    )
    ..registerFactory<IAuthRepository>(
      () => AuthRepository(
        serviceLocator(),
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

void _initBlog() async {
  serviceLocator
    ..registerFactory<IBlogRemoteDataSource>(
      () => BlogRemoteDataSource(serviceLocator()),
    )
    ..registerFactory<IBlogLocalDataSource>(
      () => BlogLocalDataSource(serviceLocator()),
    )
    ..registerFactory<IBlogRepository>(
      () => BlogRepository(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadBlog(serviceLocator()),
    )
    ..registerFactory(
      () => GetAllBlogs(serviceLocator()),
    )
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
