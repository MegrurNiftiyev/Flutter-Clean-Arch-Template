import '../../../core/helpers/result.dart';
import '../../../core/exceptions/settings_exception.dart';
import '../../repositories/settings_repository.dart';

class GetLanguageUseCase {
  final ISettingsRepository repository;

  GetLanguageUseCase(this.repository);

  Future<Result<String>> call() {
    return repository.getLanguage();
  }
}
