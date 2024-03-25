import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/models/tokens_model.dart';
import '../../main/env.dart';
import '../network/error_handler.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {
  final http.Client httpClient;
  final AuthLocalDataSource authLocalDataSource;
  final HTTPErrorHandler httpErrorHandler;

  ExpiredTokenRetryPolicy({
    required this.httpClient,
    required this.authLocalDataSource,
    required this.httpErrorHandler,
  });

  @override
  int get maxRetryAttempts => 3;

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == 401 && responseIsNotAuthException(response)) {
      http.Response response = await refreshToken();

      if (responseIsSuccess(response)) {
        await cacheToken(response);
        return true;
      }

      return false;
    }

    return false;
  }

  Future<(Map<String, String>, bool)> generateHeaders() async {
    final Tokens tokens = await authLocalDataSource.getTokens();
    final headers = {
      "authorization": "Bearer ${tokens.refreshToken}",
      "Content-Type": "application/json"
    };

    return (headers, tokens.refreshToken.isEmpty);
  }

  Future<http.Response> refreshToken() async {
    const int requestDurationInSeconds = 30;
    final Uri endPoint =
        Uri.parse("${AppEnvironment.apiUrl}/auth/refreshToken");

    final (headers, tokenIsEmpty) = await generateHeaders();
    if (tokenIsEmpty) return http.Response("", 404);

    http.Response response = await httpClient
        .post(endPoint, headers: headers)
        .timeout(const Duration(seconds: requestDurationInSeconds));

    return response;
  }

  Future<void> cacheToken(http.Response response) async {
    final Tokens tokens = Tokens.fromJson(jsonDecode(response.body));
    await authLocalDataSource.cacheTokens(tokens);
  }

  bool responseIsNotAuthException(BaseResponse response) {
    final Map<String, dynamic> msgResponse =
        jsonDecode(response.request.toString());
    if (msgResponse.isEmpty) return false;

    return msgResponse["message"] != "invalid email or password";
  }

  bool responseIsSuccess(http.Response response) {
    return response.statusCode == 201 || response.statusCode == 200;
  }
}
