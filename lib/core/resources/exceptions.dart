class ServerException implements Exception {}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class NotValidException implements Exception {}

class NotFoundException implements Exception {}

class CacheException implements Exception {}

class SessionExpiredException implements Exception {}

class InvalidVerificationCodeException implements Exception {}

class NetworkException implements Exception {}

class ImageException implements Exception {}
