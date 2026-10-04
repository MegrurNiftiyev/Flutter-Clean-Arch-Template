import '../../../core/helpers/result.dart';
import '../../repositories/settings_repository.dart';

class GetDarkModeUseCase {
  final ISettingsRepository repository;

  const GetDarkModeUseCase(this.repository);

  Future<Result<bool>> call() {
    return repository.isDarkMode();
  }
}
