import '../../../core/helpers/result.dart';
import '../../../core/exceptions/settings_exception.dart';
import '../../repositories/settings_repository.dart';

class UpdateLanguageUseCase {
  final ISettingsRepository repository;

  UpdateLanguageUseCase(this.repository);

  Future<Result<void>> call(String languageCode) {
    return repository.setLanguage(languageCode);
  }
}
