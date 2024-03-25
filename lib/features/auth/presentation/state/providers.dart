import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/base_client_provider.dart';
import '../../../user/presentation/states/providers.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSourceImpl>(
  (ref) =>
      AuthLocalDataSourceImpl(localStorage: ref.watch(localStorageProvider)),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    ref.watch(authRepositoryProvider),
    ref.watch(userRepositoryProvider),
  ),
);
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSourceImpl>(
  (ref) => AuthRemoteDataSourceImpl(
    baseClient: ref.watch(baseClientProvider),
  ),
);

final authRepositoryProvider = Provider<AuthRepositoryImpl>(
  (ref) => AuthRepositoryImpl(
    authLocalDataSource: ref.watch(authLocalDataSourceProvider),
    authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
    httpErrorHandler: ref.watch(httpErrorProvider),
  ),
);

final formProvider = StateProvider((ref) => GlobalKey<FormState>());
