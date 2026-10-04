import '../../../core/helpers/result.dart';
import '../../repositories/settings_repository.dart';

class SetDarkModeUseCase {
  final ISettingsRepository repository;

  const SetDarkModeUseCase(this.repository);

  Future<Result<void>> call(bool isDark) {
    return repository.setDarkMode(isDark);
  }
}
