import '../../core/helpers/result.dart';
import '../../core/exceptions/settings_exception.dart';

abstract class ISettingsRepository {
  Future<Result<bool>> isDarkMode();
  Future<Result<void>> setDarkMode(bool isDark);
  Future<Result<String>> getLanguage();
  Future<Result<void>> setLanguage(String languageCode);
  Future<Result<void>> logout();
}
