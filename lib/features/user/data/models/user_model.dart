import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_entity.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.familyName,
    required super.phoneNumber,
    required super.email,
    required super.password,
    required super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
