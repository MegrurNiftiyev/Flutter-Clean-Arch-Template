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
    final val = await _cacheManager.get<bool>(CacheKeys.boxName, CacheKeys.themeKey);
    return val ?? false;
  }

  Future<void> setDarkMode(bool isDark) async {
    await _cacheManager.put<bool>(CacheKeys.boxName, CacheKeys.themeKey, isDark);
  }

  Future<String> getLanguage() async {
    final val = await _cacheManager.get<String>(CacheKeys.boxName, CacheKeys.languageKey);
    return val ?? 'en';
  }

  Future<void> setLanguage(String languageCode) async {
    await _cacheManager.put<String>(CacheKeys.boxName, CacheKeys.languageKey, languageCode);
  }

  Future<void> clearAuthData() async {
    await _encryptedCacheManager.delete(CacheKeys.accessTokenKey);
    await _encryptedCacheManager.delete(CacheKeys.refreshTokenKey);
  }
}
