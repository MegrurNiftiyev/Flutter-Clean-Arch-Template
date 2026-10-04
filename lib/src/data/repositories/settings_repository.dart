import '../../core/helpers/result.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/local/settings_local_data_source.dart';

class SettingsRepository implements ISettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepository({required SettingsLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<Result<bool>> isDarkMode() async {
    return safeCall(() async {
      return await _localDataSource.isDarkMode();
    });
  }

  @override
  Future<Result<void>> setDarkMode(bool isDark) async {
    return safeCall(() async {
      await _localDataSource.setDarkMode(isDark);
    });
  }

  @override
  Future<Result<String>> getLanguage() async {
    return safeCall(() async {
      return await _localDataSource.getLanguage();
    });
  }

  @override
  Future<Result<void>> setLanguage(String languageCode) async {
    return safeCall(() async {
      await _localDataSource.setLanguage(languageCode);
    });
  }

  @override
  Future<Result<void>> logout() async {
    return safeCall(() async {
      await _localDataSource.clearAuthData();
    });
  }
}
