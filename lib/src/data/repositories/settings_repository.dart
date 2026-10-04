import '../../core/helpers/result.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/local/settings_local_data_source.dart';

class SettingsRepository implements ISettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepository({required this.localDataSource});

  @override
  Future<Result<bool>> isDarkMode() async {
    return safeCall(() async {
      return await localDataSource.isDarkMode();
    });
  }

  @override
  Future<Result<void>> setDarkMode(bool isDark) async {
    return safeCall(() async {
      await localDataSource.setDarkMode(isDark);
    });
  }

  @override
  Future<Result<String>> getLanguage() async {
    return safeCall(() async {
      return await localDataSource.getLanguage();
    });
  }

  @override
  Future<Result<void>> setLanguage(String languageCode) async {
    return safeCall(() async {
      await localDataSource.setLanguage(languageCode);
    });
  }

  @override
  Future<Result<void>> logout() async {
    return safeCall(() async {
      await localDataSource.clearAuthData();
    });
  }
}
