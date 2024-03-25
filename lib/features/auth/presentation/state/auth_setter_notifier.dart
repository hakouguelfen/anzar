import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../user/domain/entities/user_entity.dart';

final authSetterProvider =
    StateNotifierProvider<AuthSetterNotifier, UserEntity>((ref) {
  return AuthSetterNotifier();
});

class AuthSetterNotifier extends StateNotifier<UserEntity> {
  AuthSetterNotifier() : super(const UserEntity());

  void setFirstName(String firstName) {
    state = state.copyWith(firstName: firstName);
  }

  void setFamilyName(String familyName) {
    state = state.copyWith(familyName: familyName);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  String getEmail() {
    return state.email ?? "";
  }

  String getPassword() {
    return state.password ?? "";
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setPhoneNumber(String phoneNumber) {
    state = state.copyWith(phoneNumber: phoneNumber);
  }
}
