import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/database/secure_storage_helper.dart';
import 'package:flutter_base/network/api_client.dart';

import '../models/entities/token_entity.dart';

abstract class AuthRepository {
  Future<TokenEntity?> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<TokenEntity?> signIn(String username, String password);

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<TokenEntity?> signUp(String email,String password);
}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient apiClient;

  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<TokenEntity?> getToken() async {
    return await SecureStorageHelper.instance.getToken();
  }

  @override
  Future<void> removeToken() async {
    return SecureStorageHelper.instance.removeToken();
  }

  @override
  Future<void> saveToken(TokenEntity token) async {
    return SecureStorageHelper.instance.saveToken(token);
  }

  @override
  Future<TokenEntity?> signIn(String username, String password) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: username, password: password);
    return TokenEntity(
      accessToken: userCredential.credential?.accessToken ?? "",
      refreshToken: 'app_refresh_token',
    );
  }

  @override
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Future<TokenEntity?> signUp(String email, String password) async {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return TokenEntity(
      accessToken: userCredential.credential?.accessToken ?? "",
      refreshToken: 'app_refresh_token',
    );
  }
}
