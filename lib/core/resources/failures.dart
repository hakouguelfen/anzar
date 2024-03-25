import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  factory Failure.serverFailure() = _ServerFailure;
  factory Failure.httpFailure() = _HttpFailure;
  factory Failure.authFailure(String message) = _AuthFailure;
  factory Failure.notValidFailure() = _NotValidFailure;
  factory Failure.notFoundFailure() = _NotFoundFailure;
  factory Failure.cacheFailure() = _CacheFailure;
  factory Failure.sessionExpiredFailure() = _SessionExpiredFailure;
  factory Failure.networkFailure() = _NetworkFailure;
  factory Failure.invalidVerificationCodeFailure() =
      _InvalidVerificationCodeFailure;
  factory Failure.imageFailure() = _ImageFailure;
  factory Failure.timeoutFailure() = _TimeoutFailure;
}
