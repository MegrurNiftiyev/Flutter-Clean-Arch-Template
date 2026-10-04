import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../managers/encrypted_cache_manager.dart';
import 'dependency_injection.dart';

void initializeRepositories() {
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(
      remoteDataSource: sl(),
      encryptedCacheManager: sl<EncryptedCacheManager>(),
    ),
  );

  sl.registerLazySingleton<IUserRepository>(
    () => UserRepository(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<ISettingsRepository>(
    () => SettingsRepository(localDataSource: sl()),
  );
}
