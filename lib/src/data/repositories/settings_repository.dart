import '../../domain/repositories/settings_repository.dart';
import '../datasources/local/settings_local_data_source.dart';

class SettingsRepository implements ISettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepository({required SettingsLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<bool> isDarkMode() async {
    return await _localDataSource.isDarkMode();
  }

  @override
  Future<void> setDarkMode(bool isDark) async {
    await _localDataSource.setDarkMode(isDark);
  }

  @override
  Future<String> getLanguage() async {
    return await _localDataSource.getLanguage();
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    await _localDataSource.setLanguage(languageCode);
  }

  @override
  Future<void> logout() async {
    await _localDataSource.clearAuthData();
  }
}
