import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  void cacheUser(UserModel userModel);
  Future<UserModel> getFromCache();
  Future<String> getUserId();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final FlutterSecureStorage localStorage;
  UserLocalDataSourceImpl({required this.localStorage});

  @override
  void cacheUser(UserModel userModel) {
    localStorage.write(key: 'user', value: jsonEncode(userModel));
  }

  @override
  Future<UserModel> getFromCache() async {
    String? user = await localStorage.read(key: 'user');

    if (user == null) {
      return const UserModel(
        email: '',
        familyName: '',
        firstName: '',
        id: '',
        password: '',
        phoneNumber: '',
        refreshToken: '',
      );
    }

    return UserModel.fromJson(jsonDecode(user));
  }

  @override
  Future<String> getUserId() async {
    return await localStorage.read(key: 'userId') ?? "";
  }
}
