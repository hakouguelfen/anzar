import 'package:equatable/equatable.dart';

import 'failures.dart';

class ErrorObject extends Equatable {
  const ErrorObject({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  List<Object?> get props => [title, message];

  static ErrorObject mapFailureToErrorObject({required Failure failure}) {
    return failure.when(
      serverFailure: () => const ErrorObject(
        title: 'Error Code: INTERNAL_SERVER_FAILURE',
        message: 'Something went wrong, please try again later',
      ),
      authFailure: (String message) => ErrorObject(
        title: 'Error Code: AUTHENTICATION_FAILURE',
        message: message,
      ),
      notValidFailure: () => const ErrorObject(
        title: 'Error Code: NOT_VALID_FAILURE',
        message: 'Not valid, try again',
      ),
      cacheFailure: () => const ErrorObject(
        title: 'Error Code: INTERNAL_CACHE_FAILURE',
        message: 'an error with internal storage',
      ),
      sessionExpiredFailure: () => const ErrorObject(
        title: 'Error Code: Session_Expired_Failure',
        message: 'your session has expired, please click on resend code',
      ),
      invalidVerificationCodeFailure: () => const ErrorObject(
        title: 'Error Code: Invalid_Verification_Code_Failure',
        message: 'an invalid code, please insert a valid code',
      ),
      notFoundFailure: () => const ErrorObject(
        title: 'Error Code: NOT_FOUND_Failure',
        message: 'not found',
      ),
      networkFailure: () => const ErrorObject(
        title: 'Error Code: NETWORK_FAILURE',
        message: 'No internet, Please try again later',
      ),
      httpFailure: () => const ErrorObject(
        title: 'Error Code: HTTP_FAILURE',
        message: 'No Connection, try again later',
      ),
      timeoutFailure: () => const ErrorObject(
        title: 'Error Code: TIMEOUT_FAILURE',
        message: 'يبدو أن هناك خلل, يرجى المحاولة مرة أخرى',
      ),
      imageFailure: () => const ErrorObject(
        title: 'Error Code: IMAGE_FAILURE',
        message: 'الرجاء إدخال صورة صالحة',
      ),
    );
  }
}
