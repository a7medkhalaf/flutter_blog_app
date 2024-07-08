import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class IAuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  const AuthRemoteDataSource(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUserSession!.user.id);
      return UserModel.fromJson(userData.first).copyWith(
        email: currentUserSession!.user.email,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUserModel(
      () async => await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<UserModel> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUserModel(
      () async => await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      ),
    );
  }

  Future<UserModel> _getUserModel(
    Future<AuthResponse> Function() fn,
  ) async {
    try {
      final response = await fn();
      if (response.user == null) throw const ServerException('User is null!');
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
