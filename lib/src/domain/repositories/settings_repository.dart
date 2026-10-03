abstract class ISettingsRepository {
  Future<bool> isDarkMode();
  Future<void> setDarkMode(bool isDark);
  Future<String> getLanguage();
  Future<void> setLanguage(String languageCode);
  Future<void> logout();
}
