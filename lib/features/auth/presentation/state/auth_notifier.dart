import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/error_object.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../../user/domain/repositories/user_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthNotifier(this._authRepository, this._userRepository)
      : super(AuthState.initial());

  Future<void> isLoggedIn() async {
    state = AuthState.authenticating();
    final tokensResult = await _authRepository.getTokens();

    tokensResult.fold(
      (failure) => state = AuthState.unauthenticated(),
      (tokens) async {
        final userResult = await _userRepository.getUser();
        state = userResult.fold(
          (failure) => AuthState.unauthenticated(),
          (user) => user.refreshToken == null
              ? AuthState.unauthenticated()
              : AuthState.authenticated(),
        );
      },
    );
  }

  Future<void> login(UserEntity userEntity) async {
    state = AuthState.authenticating();
    final loginResult = await _authRepository.login(userEntity);

    state = loginResult.fold(
      (failure) => AuthState.failure(
        ErrorObject.mapFailureToErrorObject(failure: failure),
      ),
      (success) => AuthState.authenticated(),
    );

    await Future.delayed(const Duration(seconds: 5));
    state = AuthState.initial();
  }

  Future<void> logout() async {
    final logoutResult = await _authRepository.logout();

    state = logoutResult.fold(
      (failure) => AuthState.failure(
        ErrorObject.mapFailureToErrorObject(failure: failure),
      ),
      (success) => AuthState.signedOut(),
    );

    state = AuthState.initial();
  }

  Future<void> register(UserEntity userEntity) async {
    state = AuthState.authenticating();
    final registerResult = await _authRepository.register(userEntity);

    state = registerResult.fold(
      (failure) => AuthState.failure(
        ErrorObject.mapFailureToErrorObject(failure: failure),
      ),
      (success) => AuthState.authenticated(),
    );

    await Future.delayed(const Duration(seconds: 3));
    state = AuthState.initial();
  }
}
