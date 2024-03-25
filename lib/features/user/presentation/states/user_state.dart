import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/resources/error_object.dart';
import '../../domain/entities/user_entity.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  factory UserState.failure(ErrorObject failure) = _Failure;
  factory UserState.initial() = _Initial;
  factory UserState.loaded() = _Loaded;
  factory UserState.loading() = _Loading;
  factory UserState.noUser() = _NoUser;
  factory UserState.userLoaded(UserEntity shopOwnerEntity) = _UserLoaded;
}
