import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? familyName;
  final String? phoneNumber;
  final String? email;
  final String? password;
  final String? refreshToken;

  const UserEntity({
    this.id,
    this.firstName,
    this.familyName,
    this.phoneNumber,
    this.email,
    this.password,
    this.refreshToken,
  });

  UserEntity copyWith({
    String? id,
    String? firstName,
    String? familyName,
    String? phoneNumber,
    String? email,
    String? password,
    String? refreshToken,
  }) {
    return UserEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      familyName: familyName ?? this.familyName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      familyName,
      phoneNumber,
      email,
      password,
      refreshToken,
    ];
  }

  toUserModel() {
    return UserModel(
      id: id,
      firstName: firstName,
      familyName: familyName,
      phoneNumber: phoneNumber,
      email: email,
      password: password,
      refreshToken: refreshToken,
    );
  }
}
