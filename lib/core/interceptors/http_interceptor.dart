// ignore_for_file: constant_identifier_names
import 'package:http_interceptor/http_interceptor.dart';

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/models/tokens_model.dart';
import '../../main/env.dart';
import '../resources/exceptions.dart';

class HttpInterceptor implements InterceptorContract {
  static const int HTTP_OK = 200;
  static const int HTTP_CREATED = 201;
  static const int HTTP_UNAUTHORIZED = 401;
  static const int HTTP_NOT_FOUND = 404;
  static const int HTTP_NOT_ACCEPTABLE = 406;

  final AuthLocalDataSource authLocalDataSource;
  HttpInterceptor({required this.authLocalDataSource});

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final Tokens tokens = await authLocalDataSource.getTokens();

    final String refreshTokenUrl =
        "${AppEnvironment.apiUrl}/auth/refreshToken/customer";

    if (tokens.accessToken.isNotEmpty &&
        request.url.toString() != refreshTokenUrl) {
      request.headers["authorization"] = "Bearer ${tokens.accessToken}";
      request.headers["Content-Type"] = "application/json";
    }

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    String accessToken = response.headers["authorization"] ?? "";
    String refreshToken = response.headers["x-refresh-token"] ?? "";

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      accessToken = accessToken.split(" ").last;
      await authLocalDataSource.cacheTokens(Tokens(accessToken, refreshToken));
    }

    switch (response.statusCode) {
      case HTTP_OK || HTTP_CREATED:
        return response;

      case HTTP_UNAUTHORIZED:
        throw AuthException(response.request.toString());

      case HTTP_NOT_FOUND:
        throw NotFoundException();

      case HTTP_NOT_ACCEPTABLE:
        throw ServerException();

      default:
        throw ServerException();
    }
  }

  @override
  Future<bool> shouldInterceptRequest() {
    // TODO: implement shouldInterceptRequest
    throw UnimplementedError();
  }

  @override
  Future<bool> shouldInterceptResponse() {
    // TODO: implement shouldInterceptResponse
    throw UnimplementedError();
  }
}
