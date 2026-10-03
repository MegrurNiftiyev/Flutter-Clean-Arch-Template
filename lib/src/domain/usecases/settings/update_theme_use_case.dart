import '../../repositories/settings_repository.dart';

class UpdateThemeUseCase {
  final ISettingsRepository repository;

  UpdateThemeUseCase({required this.repository});

  Future<void> call(bool isDark) async {
    await repository.setDarkMode(isDark);
  }
}
