import 'package:dartz/dartz.dart';

import '../../../../core/resources/failures.dart';
import '../../../../core/resources/success.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../data/models/tokens_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, Success>> login(UserEntity user);
  Future<Either<Failure, Success>> logout();
  Future<Either<Failure, Success>> register(UserEntity user);
  Future<Either<Failure, Tokens>> getTokens();
}
