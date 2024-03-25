import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/resources/exceptions.dart';
import '../models/tokens_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheTokens(Tokens tokens);
  Future<Tokens> getTokens();
  Future<void> cacheUserId(String userId);
  Future<void> clear();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage localStorage;
  AuthLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> cacheTokens(Tokens tokens) async {
    localStorage.write(key: 'accessToken', value: tokens.accessToken);
    localStorage.write(key: 'refreshToken', value: tokens.refreshToken);
  }

  @override
  Future<Tokens> getTokens() async {
    final String? accessToken = await localStorage.read(key: 'accessToken');
    final String? refreshToken = await localStorage.read(key: 'refreshToken');

    if (accessToken == null || refreshToken == null) {
      throw CacheException();
    }

    return Tokens(accessToken, refreshToken);
  }

  @override
  Future<void> cacheUserId(String userId) async {
    localStorage.write(key: 'userId', value: userId);
  }

  @override
  Future<void> clear() async {
    localStorage.deleteAll();
  }
}
