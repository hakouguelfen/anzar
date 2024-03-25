import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler.dart';
import '../../../../core/resources/exceptions.dart';
import '../../../../core/resources/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final HTTPErrorHandler httpErrorHandler;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.userLocalDataSource,
    required this.httpErrorHandler,
  });

  @override
  Future<Either<Failure, UserEntity>> edit(UserEntity userEntity) async {
    try {
      final UserEntity user =
          await userRemoteDataSource.edit(userEntity.toUserModel());
      userLocalDataSource.cacheUser(user.toUserModel());

      return Right(user);
    } on Exception catch (err) {
      return Left(httpErrorHandler.catchErrors(err));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getById(String id) async {
    try {
      final UserEntity user = await userRemoteDataSource.getById(id);
      userLocalDataSource.cacheUser(user.toUserModel());
      return Right(user);
    } on Exception catch (err) {
      return Left(httpErrorHandler.catchErrors(err));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getFromCache() async {
    try {
      final UserEntity user = await userLocalDataSource.getFromCache();

      if (user.id?.isEmpty ?? true) {
        final String userId = await userLocalDataSource.getUserId();

        if (userId.isEmpty) {
          throw CacheException();
        }
        return getById(userId);
      }

      return Right(user);
    } on Exception catch (err) {
      return Left(httpErrorHandler.catchErrors(err));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      final String userId = await userLocalDataSource.getUserId();
      final UserEntity user = await userRemoteDataSource.getById(userId);

      userLocalDataSource.cacheUser(user.toUserModel());
      return Right(user);
    } on Exception catch (err) {
      return Left(httpErrorHandler.catchErrors(err));
    }
  }
}
