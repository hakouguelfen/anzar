import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/base_client_provider.dart';
import '../../data/datasources/user_local_datasource.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';
import 'user_notifier.dart';
import 'user_state.dart';

final initUserWrapperProvider = FutureProvider<Unit>((ref) async {
  final userNotifier = ref.read(userNotifierProvider.notifier);
  Future.microtask(() => userNotifier.getFromCache());

  return unit;
});

final userLocalDataSourceProvider = Provider<UserLocalDataSourceImpl>(
  (ref) =>
      UserLocalDataSourceImpl(localStorage: ref.watch(localStorageProvider)),
);

final userNotifierProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) => UserNotifier(ref.watch(userRepositoryProvider)),
);

final userRemoteDataSourceProvider = Provider<UserRemoteDataSourceImpl>(
  (ref) => UserRemoteDataSourceImpl(baseClient: ref.watch(baseClientProvider)),
);

final userRepositoryProvider = Provider<UserRepositoryImpl>(
  (ref) => UserRepositoryImpl(
    userLocalDataSource: ref.watch(userLocalDataSourceProvider),
    userRemoteDataSource: ref.watch(userRemoteDataSourceProvider),
    httpErrorHandler: ref.watch(httpErrorProvider),
  ),
);
