import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_blog_app/core/theme/theme.dart';
import 'package:flutter_blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter_blog_app/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.dartThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const Scaffold(
              body: Center(
                child: Text('User is logged in'),
              ),
            );
          }
          return const SignInPage();
        },
      ),
    );
  }
}
