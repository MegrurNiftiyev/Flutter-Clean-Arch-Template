import '../../../core/helpers/result.dart';
import '../../repositories/settings_repository.dart';

class UpdateThemeUseCase {
  final ISettingsRepository repository;

  const UpdateThemeUseCase(this.repository);

  Future<Result<void>> call(bool isDark) {
    return repository.setDarkMode(isDark);
  }
}
