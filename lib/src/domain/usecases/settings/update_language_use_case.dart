import '../../../core/helpers/result.dart';
import '../../repositories/settings_repository.dart';

class UpdateLanguageUseCase {
  final ISettingsRepository repository;

  const UpdateLanguageUseCase(this.repository);

  Future<Result<void>> call(String languageCode) {
    return repository.setLanguage(languageCode);
  }
}
