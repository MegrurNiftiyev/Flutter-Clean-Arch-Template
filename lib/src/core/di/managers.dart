import '../managers/cache_manager.dart';
import '../managers/encrypted_cache_manager.dart';
import 'dependency_injection.dart';

Future<void> initializeManagers() async {
  await CacheManager.init();
  sl.registerLazySingleton<CacheManager>(() => CacheManager());
  sl.registerLazySingleton<EncryptedCacheManager>(
    () => EncryptedCacheManager(),
  );
}
