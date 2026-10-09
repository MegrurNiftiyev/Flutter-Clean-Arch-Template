import '../../../core/helpers/result.dart';
import '../../../core/exceptions/settings_exception.dart';
import '../../repositories/settings_repository.dart';

class GetThemeUseCase {
  final ISettingsRepository repository;

  GetThemeUseCase(this.repository);

  Future<Result<bool>> call() {
    return repository.isDarkMode();
  }
}
