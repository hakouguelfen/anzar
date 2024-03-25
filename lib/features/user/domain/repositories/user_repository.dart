import 'package:dartz/dartz.dart';

import '../../../../core/resources/failures.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> edit(UserEntity userEntity);
  Future<Either<Failure, UserEntity>> getById(String userId);

  Future<Either<Failure, UserEntity>> getFromCache();
  Future<Either<Failure, UserEntity>> getUser();
}
