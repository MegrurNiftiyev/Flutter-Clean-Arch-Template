import '../../../core/helpers/result.dart';
import '../../../core/exceptions/settings_exception.dart';
import '../../repositories/settings_repository.dart';

class UpdateThemeUseCase {
  final ISettingsRepository repository;

  UpdateThemeUseCase(this.repository);

  Future<Result<void>> call(bool isDark) {
    return repository.setDarkMode(isDark);
  }
}
