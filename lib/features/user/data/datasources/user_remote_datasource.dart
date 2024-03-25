import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/network/base_client.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getById(String userId);
  Future<UserModel> edit(UserModel userModel);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final CustomBaseClient baseClient;
  UserRemoteDataSourceImpl({required this.baseClient});

  @override
  Future<UserModel> getById(String userId) async {
    final http.Response response = await baseClient.getHttp(
      'user/$userId',
    );

    return parseData(response.body);
  }

  @override
  Future<UserModel> edit(UserModel userModel) async {
    final http.Response response = await baseClient.putHttp(
      url: 'user/${userModel.id}',
      body: userModel,
    );

    return parseData(response.body);
  }

  UserModel parseData(String response) {
    Map<String, dynamic> decodedResponse = jsonDecode(response);
    return UserModel.fromJson(decodedResponse);
  }
}
