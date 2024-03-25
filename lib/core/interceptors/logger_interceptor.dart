import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor implements InterceptorContract {
  final Logger logger;
  LoggerInterceptor({required this.logger});

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

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    String accessToken = request.headers["authorization"] ?? "";

    if (accessToken.isNotEmpty) {
      logger.d(
        request.url,
        error: "Headers has been added successfully to the request below ⬇",
      );
    }

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i("[${response.headers}] ${response.headers}",
          error: response.request);
    } else {
      logger.e("[${response.headers}] ${response.headers}",
          error: response.request);
    }

    String accessToken = response.headers["authorization"] ?? "";
    String refreshToken = response.headers["x-refresh-token"] ?? "";

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      logger.d(response.request,
          error: "Headers has been retrieved from response");
    }

    return response;
  }
}
