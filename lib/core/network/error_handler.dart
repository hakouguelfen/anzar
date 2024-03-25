// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../resources/exceptions.dart';
import '../resources/failures.dart';

abstract class HTTPErrorHandler {
  Failure catchErrors(Exception exception);
}

class HTTPErrorHandlerImpl implements HTTPErrorHandler {
  @override
  Failure catchErrors(exception) {
    if (exception is AuthException) {
      Map<String, dynamic> authException = jsonDecode(exception.message);
      return Failure.authFailure(authException["message"]);
    }
    if (exception is CacheException) {
      return Failure.cacheFailure();
    }
    if (exception is HttpException) {
      return Failure.httpFailure();
    }
    if (exception is NetworkException) {
      return Failure.networkFailure();
    }
    if (exception is ImageException) {
      return Failure.imageFailure();
    }
    if (exception is NotFoundException) {
      return Failure.notFoundFailure();
    }
    if (exception is NotValidException) {
      return Failure.notValidFailure();
    }
    if (exception is TimeoutException) {
      return Failure.timeoutFailure();
    }

    return Failure.serverFailure();
  }
}
