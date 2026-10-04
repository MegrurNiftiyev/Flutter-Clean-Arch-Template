import '../../../core/constants/cache_keys.dart';
import '../../../core/managers/cache_manager.dart';
import '../../../core/managers/encrypted_cache_manager.dart';

class SettingsLocalDataSource {
  final CacheManager _cacheManager;
  final EncryptedCacheManager _encryptedCacheManager;

  SettingsLocalDataSource({
    required CacheManager cacheManager,
    required EncryptedCacheManager encryptedCacheManager,
  })  : _cacheManager = cacheManager,
        _encryptedCacheManager = encryptedCacheManager;

  Future<bool> isDarkMode() async {
    return _cacheManager.getOrDefault<bool>(
      CacheKeys.boxName,
      CacheKeys.themeKey,
      false,
    );
  }

  Future<void> setDarkMode(bool isDark) async {
    await _cacheManager.put<bool>(
      CacheKeys.boxName,
      CacheKeys.themeKey,
      isDark,
    );
  }

  Future<String> getLanguage() async {
    return _cacheManager.getOrDefault<String>(
      CacheKeys.boxName,
      CacheKeys.languageKey,
      'en',
    );
  }

  Future<void> setLanguage(String languageCode) async {
    await _cacheManager.put<String>(
        CacheKeys.boxName, CacheKeys.languageKey, languageCode);
  }

  Future<void> clearAuthData() async {
    await _encryptedCacheManager.deleteAll();
    await _cacheManager.clear(CacheKeys.boxName);
  }
}
