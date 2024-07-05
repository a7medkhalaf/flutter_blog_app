import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';
import 'package:flutter_blog_app/core/common/entities/user.dart';
import 'package:flutter_blog_app/features/auth/domain/repository/usecases/current_user.dart';
import 'package:flutter_blog_app/features/auth/domain/repository/usecases/user_login.dart';
import 'package:flutter_blog_app/features/auth/domain/repository/usecases/user_singup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsLoggedIn>(_isUserLoggedIn);
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userSignUp.call(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userLogin.call(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _isUserLoggedIn(
    AuthIsLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _currentUser.call(NoParams());

    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
