import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

import '../../features/auth/presentation/state/providers.dart';
import '../interceptors/interceptors.dart';
import 'base_client.dart';
import 'error_handler.dart';
import 'network_checker.dart';

final baseClientProvider = Provider<CustomBaseClientImpl>(
  (ref) => CustomBaseClientImpl(
    httpClient: ref.watch(httpProvider),
    networkChecker: ref.watch(networkCheckerProvider),
    httpErrorHandler: ref.watch(httpErrorProvider),
    httpInterceptor: ref.watch(httpInterceptorProvider),
    loggerInterceptor: ref.watch(loggerInterceptorProvider),
    expiredTokenRetryPolicy: ref.watch(expiredTokenRetryPolicyProvider),
  ),
);

final localStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final httpErrorProvider = Provider<HTTPErrorHandlerImpl>(
  (ref) => HTTPErrorHandlerImpl(),
);

final expiredTokenRetryPolicyProvider = Provider<ExpiredTokenRetryPolicy>(
  (ref) => ExpiredTokenRetryPolicy(
    authLocalDataSource: ref.watch(authLocalDataSourceProvider),
    httpClient: ref.watch(httpProvider),
    httpErrorHandler: ref.watch(httpErrorProvider),
  ),
);

final httpInterceptorProvider = Provider<HttpInterceptor>(
  (ref) => HttpInterceptor(
    authLocalDataSource: ref.watch(authLocalDataSourceProvider),
  ),
);

final loggerInterceptorProvider = Provider<LoggerInterceptor>(
  (ref) => LoggerInterceptor(
    logger: ref.watch(loggerProvider),
  ),
);

final httpProvider = Provider<http.Client>((ref) => http.Client());
final loggerProvider = Provider<Logger>((ref) => Logger());

final networkCheckerProvider = Provider<NetworkCheckerImpl>(
  (ref) => NetworkCheckerImpl(
    connectionChecker: InternetConnectionChecker(),
  ),
);
