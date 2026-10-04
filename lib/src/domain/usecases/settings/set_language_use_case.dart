import '../../../core/helpers/result.dart';
import '../../repositories/settings_repository.dart';

class SetLanguageUseCase {
  final ISettingsRepository repository;

  const SetLanguageUseCase(this.repository);

  Future<Result<void>> call(String languageCode) {
    return repository.setLanguage(languageCode);
  }
}
