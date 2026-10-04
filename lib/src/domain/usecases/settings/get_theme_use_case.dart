import '../../../core/helpers/result.dart';
import '../../repositories/settings_repository.dart';

class GetThemeUseCase {
  final ISettingsRepository repository;

  const GetThemeUseCase(this.repository);

  Future<Result<bool>> call() {
    return repository.isDarkMode();
  }
}
