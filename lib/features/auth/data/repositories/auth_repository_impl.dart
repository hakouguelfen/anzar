import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler.dart';
import '../../../../core/resources/failures.dart';
import '../../../../core/resources/success.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/tokens_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final HTTPErrorHandler httpErrorHandler;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.httpErrorHandler,
  });

  @override
  Future<Either<Failure, Tokens>> getTokens() async {
    try {
      final Tokens tokens = await authLocalDataSource.getTokens();

      return Right(tokens);
    } on Exception catch (err) {
      return Left(httpErrorHandler.catchErrors(err));
    }
  }

  @override
  Future<Either<Failure, Success>> login(UserEntity user) async {
    try {
      final UserEntity userResponse =
          await authRemoteDataSource.login(user.toUserModel());

      await authLocalDataSource.cacheUserId(userResponse.id ?? "");
      return Right(GoodResponse('good'));
    } on Exception catch (err) {
      return Left(httpErrorHandler.catchErrors(err));
    }
  }

  @override
  Future<Either<Failure, Success>> logout() async {
    try {
      await authLocalDataSource.clear();

      return Right(GoodResponse('good'));
    } on Exception catch (err) {
      return Left(httpErrorHandler.catchErrors(err));
    }
  }

  @override
  Future<Either<Failure, Success>> register(UserEntity user) async {
    try {
      final UserEntity userResponse =
          await authRemoteDataSource.register(user.toUserModel());

      await authLocalDataSource.cacheUserId(userResponse.id ?? "");
      return Right(GoodResponse('good'));
    } on Exception catch (err) {
      return Left(httpErrorHandler.catchErrors(err));
    }
  }
}
