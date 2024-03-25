import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/error_object.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository _userRepository;

  UserNotifier(this._userRepository) : super(UserState.initial());

  Future<void> edit(UserEntity userEntity) async {
    state = UserState.loading();

    final userResult = await _userRepository.edit(userEntity);

    state = userResult.fold(
      (failure) => UserState.failure(
        ErrorObject.mapFailureToErrorObject(failure: failure),
      ),
      (user) => UserState.userLoaded(user),
    );
  }

  Future<void> getFromCache() async {
    state = UserState.loading();
    final userResult = await _userRepository.getFromCache();

    state = userResult.fold(
      (failure) => UserState.failure(
        ErrorObject.mapFailureToErrorObject(failure: failure),
      ),
      (user) => UserState.userLoaded(user),
    );
  }
}
