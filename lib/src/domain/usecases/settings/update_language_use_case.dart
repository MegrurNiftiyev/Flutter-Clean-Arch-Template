import '../../repositories/settings_repository.dart';

class UpdateLanguageUseCase {
  final ISettingsRepository repository;

  UpdateLanguageUseCase({required this.repository});

  Future<void> call(String languageCode) async {
    await repository.setLanguage(languageCode);
  }
}
