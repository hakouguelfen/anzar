import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/network/base_client.dart';
import '../../../user/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(UserModel user);
  Future<UserModel> register(UserModel user);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final CustomBaseClient baseClient;
  AuthRemoteDataSourceImpl({required this.baseClient});

  @override
  Future<UserModel> login(UserModel shopOwnerModel) async {
    final http.Response response = await baseClient.postHttp(
      url: 'auth/login',
      body: shopOwnerModel,
    );
    return parseData(response.body);
  }

  @override
  Future<UserModel> register(UserModel shopOwnerModel) async {
    final http.Response response = await baseClient.postHttp(
      url: 'auth/register',
      body: shopOwnerModel,
    );

    return parseData(response.body);
  }

  UserModel parseData(String response) {
    Map<String, dynamic> decodedResponse = jsonDecode(response);
    return UserModel.fromJson(decodedResponse);
  }
}
