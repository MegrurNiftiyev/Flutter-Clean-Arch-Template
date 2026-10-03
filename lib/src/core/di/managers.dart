import '../managers/cache_manager.dart';
import '../managers/encrypted_cache_manager.dart';
import 'dependency_injection.dart';

void initializeManagers() {
  sl.registerLazySingleton<CacheManager>(() => CacheManager());
  sl.registerLazySingleton<EncryptedCacheManager>(
    () => EncryptedCacheManager(),
  );
}
