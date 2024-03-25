import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

import '../../main/env.dart';
import '../interceptors/interceptors.dart';
import '../resources/exceptions.dart';
import 'error_handler.dart';
import 'network_checker.dart';

abstract class CustomBaseClient {
  Future<http.Response> postHttp({required String url, required dynamic body});
  Future<http.StreamedResponse> multiPartPost({
    required String url,
    required String body,
  });
  Future<http.Response> putHttp({required String url, required dynamic body});
  Future<http.Response> getHttp(String url);
}

class CustomBaseClientImpl implements CustomBaseClient {
  static const int requestDuration = 30;

  http.Client httpClient;
  final NetworkChecker networkChecker;
  final HTTPErrorHandler httpErrorHandler;
  final HttpInterceptor httpInterceptor;
  final LoggerInterceptor loggerInterceptor;
  final ExpiredTokenRetryPolicy expiredTokenRetryPolicy;

  CustomBaseClientImpl({
    required this.httpClient,
    required this.networkChecker,
    required this.httpErrorHandler,
    required this.httpInterceptor,
    required this.loggerInterceptor,
    required this.expiredTokenRetryPolicy,
  }) {
    httpClient = InterceptedClient.build(
      interceptors: [loggerInterceptor, httpInterceptor],
      retryPolicy: expiredTokenRetryPolicy,
      requestTimeout: const Duration(seconds: requestDuration),
    );
  }

  Uri generateURI(String url) {
    final String apiUrl = AppEnvironment.apiUrl;

    return Uri.parse("$apiUrl/$url");
  }

  Map<String, String> generateHeaders() {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

  @override
  Future<http.Response> getHttp(String url) async {
    final Uri endPoint = generateURI(url);
    final headers = generateHeaders();

    if (!await networkChecker.hasConnection) throw NetworkException();

    http.Response response = await httpClient.get(endPoint, headers: headers);
    return response;
  }

  @override
  Future<http.Response> postHttp({required String url, required body}) async {
    final Uri endPoint = generateURI(url);
    final headers = generateHeaders();

    if (!await networkChecker.hasConnection) throw NetworkException();

    http.Response response = await httpClient.post(
      endPoint,
      headers: headers,
      body: jsonEncode(body),
    );
    return response;
  }

  @override
  Future<http.Response> putHttp({required String url, required body}) async {
    final Uri endPoint = generateURI(url);
    final headers = generateHeaders();

    if (!await networkChecker.hasConnection) throw NetworkException();

    http.Response response = await httpClient.put(
      endPoint,
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  @override
  Future<http.StreamedResponse> multiPartPost(
      {required String url, required String body}) async {
    final Uri endPoint = generateURI(url);

    var request = http.MultipartRequest('POST', endPoint);
    request.files.add(await http.MultipartFile.fromPath('image', body));

    if (!await networkChecker.hasConnection) throw NetworkException();

    http.StreamedResponse response = await request.send();
    return response;
  }
}
